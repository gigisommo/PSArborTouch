//
//  ATNode.h
//  PSArborTouch
//
//  Created by Ed Preston on 19/09/11.
//  Copyright 2011 Preston Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATNode : NSObject <NSCoding>
{
    
@private
    NSString   *name_;
    CGFloat     mass_;
    CGPoint     position_;
    BOOL        fixed_;
    
    NSNumber   *index_;
    
    NSMutableDictionary *data_;
}

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, assign) CGFloat mass;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign, getter=isFixed) BOOL fixed;

@property (nonatomic, readonly, strong) NSNumber *index;

@property (nonatomic, strong) NSMutableDictionary *userData;

- (instancetype) init NS_DESIGNATED_INITIALIZER;

- (instancetype) initWithName:(NSString *)name 
               mass:(CGFloat)mass 
           position:(CGPoint)position 
              fixed:(BOOL)fixed;

- (instancetype) initWithName:(NSString *)name 
           userData:(NSMutableDictionary *)data;

@end
