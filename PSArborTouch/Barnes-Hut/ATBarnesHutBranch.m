//
//  ATBarnesHutBranch.m
//  PSArborTouch
//
//  Created by Ed Preston on 19/09/11.
//  Copyright 2011 Preston Software. All rights reserved.
//

#import "ATBarnesHutBranch.h"


@interface ATBarnesHutBranch ()
// reserved
@end


@implementation ATBarnesHutBranch

@synthesize bounds      = bounds_;
@synthesize mass        = mass_;
@synthesize position    = position_;

@synthesize ne = ne_;
@synthesize nw = nw_;
@synthesize se = se_;
@synthesize sw = sw_;

- (instancetype) init
{
    self = [super init];
    if (self) {
        bounds_     = CGRectZero;
        mass_       = 0.0;
        position_   = CGPointZero;
        
        ne_ = nil;
        nw_ = nil;
        se_ = nil;
        sw_ = nil;
    }
    return self;
}

- (instancetype) initWithBounds:(CGRect)bounds mass:(CGFloat)mass position:(CGPoint)position 
{
    self = [self init];
    if (self) {
        bounds_     = bounds;
        mass_       = mass;
        position_   = position;
    }
    return self;
}



#pragma mark - Internal Interface


@end
