//
//  ATSpring.m
//  PSArborTouch
//
//  Created by Ed Preston on 19/09/11.
//  Copyright 2011 Preston Software. All rights reserved.
//

#import "ATSpring.h"
#import "ATParticle.h"

@implementation ATSpring

- (instancetype)init
{
    self = [super init];
    if (self) {
        _stiffness = 1000.0;
    }
    return self;
}

- (ATParticle *)point1
{
    return (ATParticle *)self.sourceNode; 
}

- (ATParticle *)point2
{
    return (ATParticle *)self.destinationNode; 
}

#pragma mark - Geometry

- (CGFloat)distanceToParticle:(ATParticle *)particle
{
    NSParameterAssert(particle != nil);
    
    return [self distanceToNode:particle];
}

@end
