//
//  TDFilledRectangle
//  pacman
//
//  Created by Denis Dorokhov on 12/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDEntity.h"
#import "TDEntityColored.h"
#import "TDEntityTransparent.h"

/**
* Filled rectangle implementation.
*/
@interface TDFilledRectangle : TDEntity <TDEntityColored, TDEntityTransparent>

/**
* Builds filled rectangle with some position and size.
*/
+ (instancetype)rectangleWithRectangle:(CGRect)aRectangle;

/**
* Builds filled rectangle with some size and zero position.
*/
+ (instancetype)rectangleWithSize:(CGSize)aSize;

/**
* Initializes filled rectangle with some position and size.
*/
- (instancetype)initWithRectangle:(CGRect)aRectangle;

/**
* Initializes filled rectangle with some size and zero position.
*/
- (instancetype)initWithSize:(CGSize)aSize;

@end