//
//  TDSprite
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDEntity.h"
#import "TDSpriteFrame.h"
#import "TDUtil.h"
#import "TDEntityColored.h"
#import "TDEntityTransparent.h"

/**
* Sprite entity.
*/
@interface TDSprite : TDEntity <TDEntityColored, TDEntityTransparent>

/**
* Sprite frame.
*/
@property (nonatomic, strong) TDSpriteFrame *frame;

/**
* Flips X axis.
*/
@property (nonatomic) BOOL flipX;

/**
* Flips Y axis.
*/
@property (nonatomic) BOOL flipY;

/**
* Builds sprite with some frame.
*/
+ (instancetype)spriteWithSpriteFrame:(TDSpriteFrame *)aFrame;

/**
* Initializes sprite with some frame.
*/
- (instancetype)initWithSpriteFrame:(TDSpriteFrame *)aFrame;

@end