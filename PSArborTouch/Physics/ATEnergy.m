//
//  ATEnergy.m
//  PSArborTouch
//
//  Created by Ed Preston on 19/09/11.
//  Copyright 2011 Preston Software. All rights reserved.
//

#import "ATEnergy.h"

@implementation ATEnergy

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    id theCopy = [[[self class] allocWithZone:zone] init];  // use designated initializer
    
    [theCopy setSum:self.sum];
    [theCopy setMax:self.max];
    [theCopy setMean:self.mean];
    [theCopy setCount:self.count];
    
    return theCopy;
}

@end
