//
//  ATParticle.h
//  PSArborTouch
//
//  Created by Ed Preston on 19/09/11.
//  Copyright 2011 Preston Software. All rights reserved.
//

#import "ATNode.h"

@interface ATParticle : ATNode

@property (nonatomic, assign) CGPoint velocity;
@property (nonatomic, assign) CGPoint force;
@property (nonatomic, assign) CGFloat tempMass;
@property (nonatomic, assign) NSUInteger connections;

- (instancetype)init NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithVelocity:(CGPoint)velocity
                           force:(CGPoint)force
                        tempMass:(CGFloat)tempMass;

- (void)applyForce:(CGPoint)force;

@end
