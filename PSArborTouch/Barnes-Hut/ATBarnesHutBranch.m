//
//  ATBarnesHutBranch.m
//  PSArborTouch
//
//  Created by Ed Preston on 19/09/11.
//  Copyright 2011 Preston Software. All rights reserved.
//

#import "ATBarnesHutBranch.h"

@implementation ATBarnesHutBranch

- (instancetype)init
{
    self = [super init];
    if (self) {
        _bounds = CGRectZero;
        _position = CGPointZero;
    }
    return self;
}

- (instancetype)initWithBounds:(CGRect)bounds mass:(CGFloat)mass position:(CGPoint)position
{
    self = [self init];
    if (self) {
        _bounds = bounds;
        _mass = mass;
        _position = position;
    }
    return self;
}

@end
