//
//  ATBarnesHutBranch.h
//  PSArborTouch
//
//  Created by Ed Preston on 19/09/11.
//  Copyright 2011 Preston Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATBarnesHutBranch : NSObject

@property (nonatomic, assign) CGRect bounds;
@property (nonatomic, assign) CGFloat mass;
@property (nonatomic, assign) CGPoint position;

// Can be a branch or a single particle
@property (nonatomic, strong) id northEstQuadrant;
@property (nonatomic, strong) id northWestQuadrant;
@property (nonatomic, strong) id southWestQuadrant;
@property (nonatomic, strong) id southEstQuadrant;

- (instancetype)init NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithBounds:(CGRect)bounds
                          mass:(CGFloat)mass
                      position:(CGPoint)position;

@end
