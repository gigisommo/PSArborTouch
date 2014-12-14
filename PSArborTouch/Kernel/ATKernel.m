//
//  ATKernel.m
//  PSArborTouch
//
//  Created by Ed Preston on 22/09/11.
//  Copyright 2011 Preston Software. All rights reserved.
//

#import "ATKernel.h"
#import "ATPhysics.h"
#import "ATSpring.h"
#import "ATParticle.h"
#import "ATEnergy.h"

#import "ATSystemParams.h"
#import "ATSystemRenderer.h"


// Interval in seconds: make sure this is more than 0
static CGFloat const kTimerInterval = 0.05;

@interface ATKernel ()

@property (nonatomic, readonly, assign) dispatch_queue_t physicsQueue;
@property (nonatomic, readonly, assign) dispatch_source_t physicsTimer;

@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) dispatch_queue_t queue;

@property (nonatomic, assign) BOOL running;

@property (nonatomic, readwrite, assign) CGRect simulationBounds;

@end


@implementation ATKernel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _physics = [[ATPhysics alloc] initWithDeltaTime:0.02
                                              stiffness:1000.0
                                              repulsion:600.0
                                               friction:0.5];
        _simulationEnergy = [[ATEnergy alloc] init];
        _simulationBounds = CGRectMake(-1.0, -1.0, 2.0, 2.0);
    }
    return self;
}

- (void)dealloc
{
    // stop the simulation
    [self stop];
    
    // tear down the timer
    BOOL timerInitialized = (self.timer != nil);
    if ( timerInitialized ) {
        dispatch_source_cancel(self.timer);
        dispatch_resume(self.timer);
    }
}


#pragma mark - Rendering (override in subclass)

- (BOOL)updateViewport
{
    return NO;
}


#pragma mark - Simulation Control

- (void)stepSimulation
{
    // step physics
    
    //    dispatch_async( [self physicsQueue] , ^{
    
    // Run physics loop.
    BOOL stillActive = [self.physics update];
    
    // Update the viewport
    if ([self updateViewport]) {
        stillActive = YES;
    }
    
    // Stop timer if not stillActive.
    if (!stillActive) {
        [self stop];
        
    }
    
    // Call back to main thread (UI Thread) to update the text
    // Dispatch SYNC or ASYNC here?  Could we queue too many updates?
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // Update cached properties
        //
        //      - Energy in the simulation
        //      - Bounds of the simulation
        
        ATEnergy *currentEnergy = self.physics.energy;
        
        self.simulationEnergy.sum = currentEnergy.sum;
        self.simulationEnergy.max = currentEnergy.max;
        self.simulationEnergy.mean = currentEnergy.mean;
        self.simulationEnergy.count = currentEnergy.count;
        
        self.simulationBounds = self.physics.bounds;
        
        
        // Call back into the main thread
        //
        //      - Update the debug barnes-hut display
        //      - Update the debug bounds display
        //      - Update the debug viewport display
        //      - Update the edge display
        //      - Update the node display
        
        if ([self.delegate respondsToSelector:@selector(redraw)]) {
            [self.delegate redraw];
        }
    });
    //    });
}

- (void)start
{
    if (self.running) {
        return;               // already running
    }
    // start the simulation
    
    self.running = YES;
    
    // Configure handler when it fires
    dispatch_source_set_event_handler( [self physicsTimer], ^{
        
        // Call back to main thread (UI Thread) to update the text
        //            dispatch_async(dispatch_get_main_queue(), ^{
        [self stepSimulation];
        //            });
        
    });
    
    // Start the timer
    dispatch_resume( [self physicsTimer] );
    
    NSLog(@"Kernel started.");
}

- (void)stop
{
    BOOL timerInitialized = (self.timer != nil);
    if ( timerInitialized && self.running ) {
        self.running = NO;
        dispatch_suspend(self.timer);
    }
    
    NSLog(@"Kernel stopped.");
}


#pragma mark - Protected Physics Interface

// Physics methods protected by a GCD queue to ensure serial execution.  We do
// not want to do things like add and remove items from a simulation mid-calculation.

- (void)updateSimulation:(ATSystemParams *)params
{
    NSParameterAssert(params != nil);
    if (params == nil) return;
    
    dispatch_async( [self physicsQueue] , ^{
        ATPhysics *physics = self.physics;
        physics.repulsion = params.repulsion;
        physics.stiffness = params.stiffness;
        physics.friction = params.friction;
        physics.deltaTime = params.deltaTime;
        physics.gravity = params.gravity;
        physics.theta = params.precision;
        
        // params.timeout;  // Used by kernel to control update cycle
        
        // start, unpaused NO
    });
}

- (void)addParticle:(ATParticle *)particle
{
    NSParameterAssert(particle != nil);
    if (particle == nil) return;
    
    dispatch_async( [self physicsQueue] , ^{
        
        [self.physics addParticle:particle];
        
        // start, unpaused NO
    });
}

- (void)removeParticle:(ATParticle *)particle
{
    NSParameterAssert(particle != nil);
    if (particle == nil) return;
    
    dispatch_async( [self physicsQueue] , ^{
        
        [self.physics removeParticle:particle];
        
        // start, unpaused NO
    });
}

- (void)addSpring:(ATSpring *)spring
{
    NSParameterAssert(spring != nil);
    if (spring == nil) return;
    
    dispatch_async( [self physicsQueue] , ^{
        
        [self.physics addSpring:spring];
        
        // start, unpaused NO
    });
}

- (void)removeSpring:(ATSpring *)spring
{
    NSParameterAssert(spring != nil);
    if (spring == nil) return;
    
    dispatch_async( [self physicsQueue] , ^{
        
        [self.physics removeSpring:spring];
        
        // start, unpaused NO
    });
}


#pragma mark - Internal Interface

- (dispatch_queue_t)physicsQueue
{
    if (self.queue == nil) {
        self.queue = dispatch_queue_create("com.prestonsoft.psarbortouch", DISPATCH_QUEUE_SERIAL);
    }
    return self.queue;
}

- (dispatch_source_t)physicsTimer
{
    if (!self.timer) {
        
        //        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        // create our timer source
        //        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, [self physicsQueue]);
        
        // set the time to fire
        dispatch_source_set_timer(self.timer,
                                  dispatch_time(DISPATCH_TIME_NOW, kTimerInterval * NSEC_PER_SEC),
                                  kTimerInterval * NSEC_PER_SEC, (kTimerInterval * NSEC_PER_SEC) / 2.0);
    }
    
    return self.timer;
}

@end
