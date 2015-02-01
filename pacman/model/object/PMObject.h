//
//  PMObject
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMMapLocation.h"

/**
* Abstract game object model.
*/
@interface PMObject : NSObject

/**
* Position in game world coordinates.
*/
@property (nonatomic) CGPoint position;

/**
* Builds an object at some position.
*/
+ (instancetype)objectWithPosition:(CGPoint)aPosition;

/**
* Initializes an object at some position.
*/
- (instancetype)initWithPosition:(CGPoint)aPosition;

/**
* Rounded position of the object on game map.
*/
- (PMMapLocation)currentMapLocation;

@end