//
//  ATNode.m
//  PSArborTouch
//
//  Created by Ed Preston on 19/09/11.
//  Copyright 2011 Preston Software. All rights reserved.
//

#import "ATNode.h"

// Nodes have positive indexes, Edges have negative indexes
static NSInteger nextNodeIndex_ = 1; 


@interface ATNode ()
// Reserved
@end


@implementation ATNode

- (instancetype) init
{
    self = [super init];
    if (self) {
        _index = @(nextNodeIndex_++);
        _mass = 1.0;
        _position = CGPointZero;
    }
    return self;
}

- (instancetype) initWithName:(NSString *)name mass:(CGFloat)mass position:(CGPoint)position fixed:(BOOL)fixed 
{
    self = [self init];
    if (self) {
        _name = [name copy];
        _mass = mass;
        _position = position;
        _fixed = fixed;
    }
    return self;
}

- (instancetype) initWithName:(NSString *)name userData:(NSMutableDictionary *)data 
{
    self = [self init];
    if (self) {
        _name = [name copy];
        _userData = data;
    }
    return self;
}

#pragma mark - Internal Interface


#pragma mark - Keyed Archiving

- (void) encodeWithCoder:(NSCoder *)encoder 
{
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeFloat:self.mass forKey:@"mass"];
    [encoder encodeCGPoint:self.position forKey:@"position"];
    [encoder encodeBool:self.fixed forKey:@"fixed"];
    [encoder encodeObject:self.index forKey:@"index"];
    [encoder encodeObject:self.userData forKey:@"data"];
}

- (instancetype) initWithCoder:(NSCoder *)decoder 
{
    self = [self init];
    if (self) {
        _name = [decoder decodeObjectForKey:@"name"];
        _mass = [decoder decodeFloatForKey:@"mass"];
        _position = [decoder decodeCGPointForKey:@"position"];
        _fixed = [decoder decodeBoolForKey:@"fixed"];
        _index = [decoder decodeObjectForKey:@"index"];
        _userData = [decoder decodeObjectForKey:@"data"];
        
        nextNodeIndex_  = MAX(nextNodeIndex_, ([_index integerValue] + 1));
    }
    
    return self;
}

@end
