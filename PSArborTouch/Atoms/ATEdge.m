//
//  ATEdge.m
//  PSArborTouch
//
//  Created by Ed Preston on 19/09/11.
//  Copyright 2011 Preston Software. All rights reserved.
//

#import "ATEdge.h"
#import "ATNode.h"

#import "ATGeometry.h"

// Edges have negative indexes, Nodes have positive indexes,
static NSInteger nextEdgeIndex_ = -1;


@interface ATEdge ()

@property (nonatomic, readwrite, strong) ATNode *sourceNode;
@property (nonatomic, readwrite, strong) ATNode *destinationNode;

@property (nonatomic, readwrite, strong) NSNumber *index;

@end

@implementation ATEdge

- (instancetype) init
{
    self = [super init];
    if (self) {
        _index = @(nextEdgeIndex_--);
        _length = 1.0;
    }
    return self;
}

- (instancetype) initWithSource:(ATNode *)source target:(ATNode *)target length:(CGFloat)length 
{
    self = [self init];
    if (self) {
        _sourceNode = source;
        _destinationNode = target;
        _length = length;
    }
    return self;
}

- (instancetype) initWithSource:(ATNode *)source target:(ATNode *)target userData:(NSMutableDictionary *)data 
{
    self = [self init];
    if (self) {
        _sourceNode = source;
        _destinationNode = target;
        _userData = data;
    }
    return self;
}

#pragma mark - Geometry

- (CGFloat) distanceToNode:(ATNode *)node
{
    NSParameterAssert(node != nil);
    
// see http://stackoverflow.com/questions/849211/shortest-distance-between-a-point-and-a-line-segment/865080#865080
    CGPoint n = CGPointNormalize( CGPointNormal( CGPointSubtract(self.destinationNode.position, self.sourceNode.position) ) );
    CGPoint ac = CGPointSubtract(node.position, self.sourceNode.position);
    return ABS(ac.x * n.x + ac.y * n.y);
}


#pragma mark - Internal Interface


#pragma mark - Keyed Archiving

- (void)encodeWithCoder:(NSCoder *)encoder 
{
    [encoder encodeObject:self.sourceNode forKey:@"source"];
    [encoder encodeObject:self.destinationNode forKey:@"target"];
    [encoder encodeFloat:self.length forKey:@"length"];
    [encoder encodeObject:self.index forKey:@"index"];
    [encoder encodeObject:self.userData forKey:@"data"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder 
{
    self = [self init];
    if (self) {
        _sourceNode = [decoder decodeObjectForKey:@"source"];
        _destinationNode = [decoder decodeObjectForKey:@"target"];
        _length = [decoder decodeFloatForKey:@"length"];
        _index = [decoder decodeObjectForKey:@"index"];
        _userData = [decoder decodeObjectForKey:@"data"];
        
        
        nextEdgeIndex_  = MIN(nextEdgeIndex_, ([_index integerValue] - 1));
    }
        
    return self;
}

@end
