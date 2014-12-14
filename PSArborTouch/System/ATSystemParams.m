//
//  ATSystemParams.m
//  PSArborTouch
//
//  Created by Ed Preston on 30/09/11.
//  Copyright 2011 Preston Software. All rights reserved.
//

#import "ATSystemParams.h"

@implementation ATSystemParams

- (instancetype) init
{
    self = [super init];
    if (self) {        
        _repulsion = 1000;
        _stiffness = 600;
        _friction = 0.5;
        _deltaTime = 0.02;
        _gravity = YES;
        _precision = 0.6;
        _timeout = 1000 / 50;
    }
    return self;
}

#pragma mark - NSCopying

- (id) copyWithZone:(NSZone *)zone
{
    id theCopy = [[[self class] allocWithZone:zone] init];  // use designated initializer
    
    [theCopy setRepulsion:self.repulsion];
    [theCopy setStiffness:self.stiffness];
    [theCopy setFriction:self.friction];
    [theCopy setDeltaTime:self.deltaTime];
    [theCopy setGravity:self.gravity];
    [theCopy setPrecision:self.precision];
    [theCopy setTimeout:self.timeout];
    
    return theCopy;
}


#pragma mark - Keyed Archiving

- (void) encodeWithCoder:(NSCoder *)encoder 
{
    [encoder encodeFloat:self.repulsion forKey:@"repulsion"];
    [encoder encodeFloat:self.stiffness forKey:@"stiffness"];
    [encoder encodeFloat:self.friction forKey:@"friction"];
    [encoder encodeFloat:self.deltaTime forKey:@"deltaTime"];
    [encoder encodeBool:self.gravity forKey:@"gravity"];
    [encoder encodeFloat:self.precision forKey:@"precision"];
    [encoder encodeFloat:self.timeout forKey:@"timeout"];
}

- (instancetype) initWithCoder:(NSCoder *)decoder 
{
    self = [super init];
    if (self) {
        _repulsion = [decoder decodeFloatForKey:@"repulsion"];
        _stiffness = [decoder decodeFloatForKey:@"stiffness"];
        _friction = [decoder decodeFloatForKey:@"friction"];
        _deltaTime = [decoder decodeFloatForKey:@"deltaTime"];
        _gravity = [decoder decodeBoolForKey:@"gravity"];
        _precision = [decoder decodeFloatForKey:@"precision"];
        _timeout = [decoder decodeFloatForKey:@"timeout"];
    }
    return self;
}

@end
