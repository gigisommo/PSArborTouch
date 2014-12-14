//
//  ATSystemState.m
//  PSArborTouch
//
//  Created by Ed Preston on 30/09/11.
//  Copyright 2011 Preston Software. All rights reserved.
//

#import "ATSystemState.h"

#import "ATEdge.h"
#import "ATNode.h"


@interface ATSystemState ()

@property (nonatomic, strong) NSMutableDictionary *mutableNodes;
@property (nonatomic, strong) NSMutableDictionary *mutableEdges;
@property (nonatomic, strong) NSMutableDictionary *mutableAdjacency;
@property (nonatomic, strong) NSMutableDictionary *mutableNames;

@end


@implementation ATSystemState

- (NSArray *)nodes
{
    return [self.mutableNodes allValues];
}

- (NSArray *)edges
{
    return [self.mutableEdges allValues];
}

- (NSArray *)adjacency
{
    return [self.mutableAdjacency allValues];
}

- (NSArray *)names
{
    return [self.mutableNames allValues];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mutableNodes = [NSMutableDictionary dictionary];
        _mutableEdges = [NSMutableDictionary dictionary];
        _mutableAdjacency = [NSMutableDictionary dictionary];
        _mutableNames = [NSMutableDictionary dictionary];
    }
    return self;
}


#pragma mark - Nodes

- (void)setNodesObject:(ATNode *)NodesObject forKey:(NSNumber *)Key
{
    NSParameterAssert(Key != nil);
    NSParameterAssert(NodesObject != nil);
    
    if (NodesObject == nil || Key == nil) return;
    self.mutableNodes[Key] = NodesObject;
}

- (void)removeNodesObjectForKey:(NSNumber *)Key
{
    NSParameterAssert(Key != nil);
    
    if (Key == nil) return;
    [self.mutableNodes removeObjectForKey:Key];
}

- (ATNode *)getNodesObjectForKey:(NSNumber *)Key
{
    NSParameterAssert(Key != nil);
    
    if (Key == nil) return nil;
    return self.mutableNodes[Key];
}

#pragma mark - Edges

- (void)setEdgesObject:(ATEdge *)EdgesObject forKey:(NSNumber *)Key
{
    NSParameterAssert(Key != nil);
    NSParameterAssert(EdgesObject != nil);
    
    if (EdgesObject == nil || Key == nil) return;
    self.mutableEdges[Key] = EdgesObject;
}

- (void)removeEdgesObjectForKey:(NSNumber *)Key
{
    NSParameterAssert(Key != nil);
    
    if (Key == nil) return;
    [self.mutableEdges removeObjectForKey:Key];
}

- (ATEdge *)getEdgesObjectForKey:(NSNumber *)Key
{
    NSParameterAssert(Key != nil);
    
    if (Key == nil) return nil;
    return self.mutableEdges[Key];
}


#pragma mark - Adjacency

- (void)setAdjacencyObject:(NSMutableDictionary *)AdjacencyObject forKey:(NSNumber *)Key
{
    NSParameterAssert(Key != nil);
    NSParameterAssert(AdjacencyObject != nil);
    
    if (AdjacencyObject == nil || Key == nil) return;
    self.mutableAdjacency[Key] = AdjacencyObject;
}

- (void)removeAdjacencyObjectForKey:(NSNumber *)Key
{
    NSParameterAssert(Key != nil);
    
    if (Key == nil) return;
    [self.mutableAdjacency removeObjectForKey:Key];
}

- (NSMutableDictionary *)getAdjacencyObjectForKey:(NSNumber *)Key
{
    NSParameterAssert(Key != nil);
    
    if (Key == nil) return nil;
    return self.mutableAdjacency[Key];
}


#pragma mark - Names

- (void)setNamesObject:(ATNode *)NamesObject forKey:(NSString *)Key
{
    NSParameterAssert(Key != nil);
    NSParameterAssert(NamesObject != nil);
    
    if (NamesObject == nil || Key == nil) return;
    self.mutableNames[Key] = NamesObject;
}

- (void)removeNamesObjectForKey:(NSString *)Key
{
    NSParameterAssert(Key != nil);
    
    if (Key == nil) return;
    [self.mutableNames removeObjectForKey:Key];
}

- (ATNode *)getNamesObjectForKey:(NSString *)Key
{
    NSParameterAssert(Key != nil);
    
    if (Key == nil) return nil;
    return self.mutableNames[Key];
}



#pragma mark - Keyed Archiving


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.mutableNodes forKey:@"nodes"];
    [encoder encodeObject:self.mutableEdges forKey:@"edges"];
    [encoder encodeObject:self.mutableAdjacency forKey:@"adjacency"];
    [encoder encodeObject:self.mutableNames forKey:@"names"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.mutableNodes = [decoder decodeObjectForKey:@"nodes"];
        self.mutableEdges = [decoder decodeObjectForKey:@"edges"];
        self.mutableAdjacency = [decoder decodeObjectForKey:@"adjacency"];
        self.mutableNames = [decoder decodeObjectForKey:@"names"];
    }
    return self;
}

@end
