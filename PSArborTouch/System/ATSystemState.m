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

@end


@implementation ATSystemState

//@synthesize nodes       = nodes_;
- (NSArray *) nodes
{
    return [nodes_ allValues];
}

//@synthesize edges       = edges_;
- (NSArray *) edges
{
    return [edges_ allValues];
}

//@synthesize adjacency   = adjacency_;
- (NSArray *) adjacency
{
    return [adjacency_ allValues]; 
}

//@synthesize names       = names_;
- (NSArray *) names
{
    return [names_ allValues]; 
}

- (instancetype) init
{
    self = [super init];
    if (self) {
        nodes_      = [NSMutableDictionary dictionaryWithCapacity:32];      
        edges_      = [NSMutableDictionary dictionaryWithCapacity:32];      
        adjacency_  = [NSMutableDictionary dictionaryWithCapacity:32];             
        names_      = [NSMutableDictionary dictionaryWithCapacity:32];
    }
    
    return self;
}


#pragma mark - Nodes

- (void) setNodesObject:(ATNode *)NodesObject forKey:(NSNumber *)Key
{
    NSParameterAssert(Key != nil);
    NSParameterAssert(NodesObject != nil);
    
    if (NodesObject == nil || Key == nil) return;
    nodes_[Key] = NodesObject;
}

- (void) removeNodesObjectForKey:(NSNumber *)Key
{
    NSParameterAssert(Key != nil);
    
    if (Key == nil) return;
    [nodes_ removeObjectForKey:Key];
}

- (ATNode *) getNodesObjectForKey:(NSNumber *)Key
{
    NSParameterAssert(Key != nil);
    
    if (Key == nil) return nil;
    return nodes_[Key];
}

#pragma mark - Edges

- (void) setEdgesObject:(ATEdge *)EdgesObject forKey:(NSNumber *)Key
{
    NSParameterAssert(Key != nil);
    NSParameterAssert(EdgesObject != nil);
    
    if (EdgesObject == nil || Key == nil) return;
    edges_[Key] = EdgesObject;
}

- (void) removeEdgesObjectForKey:(NSNumber *)Key
{
    NSParameterAssert(Key != nil);
    
    if (Key == nil) return;
    [edges_ removeObjectForKey:Key];
}

- (ATEdge *) getEdgesObjectForKey:(NSNumber *)Key
{
    NSParameterAssert(Key != nil);
    
    if (Key == nil) return nil;
    return edges_[Key];
}


#pragma mark - Adjacency

- (void) setAdjacencyObject:(NSMutableDictionary *)AdjacencyObject forKey:(NSNumber *)Key
{
    NSParameterAssert(Key != nil);
    NSParameterAssert(AdjacencyObject != nil);
    
    if (AdjacencyObject == nil || Key == nil) return;
    adjacency_[Key] = AdjacencyObject;
}

- (void) removeAdjacencyObjectForKey:(NSNumber *)Key
{
    NSParameterAssert(Key != nil);
    
    if (Key == nil) return;
    [adjacency_ removeObjectForKey:Key];
}

- (NSMutableDictionary *) getAdjacencyObjectForKey:(NSNumber *)Key
{
    NSParameterAssert(Key != nil);
    
    if (Key == nil) return nil;
    return adjacency_[Key];
}


#pragma mark - Names

- (void) setNamesObject:(ATNode *)NamesObject forKey:(NSString *)Key
{
    NSParameterAssert(Key != nil);
    NSParameterAssert(NamesObject != nil);
    
    if (NamesObject == nil || Key == nil) return;
    names_[Key] = NamesObject;
}

- (void) removeNamesObjectForKey:(NSString *)Key
{
    NSParameterAssert(Key != nil);
    
    if (Key == nil) return;
    [names_ removeObjectForKey:Key];
}

- (ATNode *) getNamesObjectForKey:(NSString *)Key
{
    NSParameterAssert(Key != nil);
    
    if (Key == nil) return nil;
    return names_[Key];
}



#pragma mark - Keyed Archiving


- (void) encodeWithCoder:(NSCoder *)encoder 
{
    [encoder encodeObject:nodes_ forKey:@"nodes"];
    [encoder encodeObject:edges_ forKey:@"edges"];
    [encoder encodeObject:adjacency_ forKey:@"adjacency"];
    [encoder encodeObject:names_ forKey:@"names"];
}

- (instancetype) initWithCoder:(NSCoder *)decoder 
{
    self = [super init];
    if (self) {
        nodes_      = [decoder decodeObjectForKey:@"nodes"];
        edges_      = [decoder decodeObjectForKey:@"edges"];
        adjacency_  = [decoder decodeObjectForKey:@"adjacency"];
        names_      = [decoder decodeObjectForKey:@"names"];
    }
    return self;
}

@end
