//
//  ATPhysics.h
//  PSArborTouch
//
//  Created by Ed Preston on 19/09/11.
//  Copyright 2011 Preston Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ATBarnesHutTree;
@class ATEnergy;
@class ATParticle;
@class ATSpring;

@interface ATPhysics : NSObject

@property (nonatomic, readonly, strong) ATBarnesHutTree *bhTree;

@property (nonatomic, readonly) NSArray *particles;
- (void) addParticle:(ATParticle *)particle;
- (void) removeParticle:(ATParticle *)particle;

@property (nonatomic, readonly) NSArray *springs;
- (void) addSpring:(ATSpring *)spring;
- (void) removeSpring:(ATSpring *)spring;

@property (nonatomic, readonly, copy) ATEnergy *energy;
@property (nonatomic, assign) CGRect bounds;

@property (nonatomic, assign) CGFloat speedLimit;

@property (nonatomic, assign) CGFloat deltaTime;
@property (nonatomic, assign) CGFloat stiffness;
@property (nonatomic, assign) CGFloat repulsion;
@property (nonatomic, assign) CGFloat friction;

@property (nonatomic, assign) BOOL gravity;
@property (nonatomic, assign) CGFloat theta;

@property (NS_NONATOMIC_IOSONLY, readonly) BOOL update;

- (instancetype)init NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithDeltaTime:(CGFloat)deltaTime 
              stiffness:(CGFloat)stiffness 
              repulsion:(CGFloat)repulsion 
               friction:(CGFloat)friction;

@end
