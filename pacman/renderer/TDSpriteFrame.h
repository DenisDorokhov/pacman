//
//  TDSpriteFrame
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDTexture.h"

/**
* Sprite frame.
*
* Named rectangle in a texture.
*/
@interface TDSpriteFrame : NSObject

/**
* Frame name.
*/
@property (nonatomic, copy) NSString *name;

/**
* Frame position in the texture.
*/
@property (nonatomic) CGPoint position;

/**
* Frame size in the texture.
*/
@property (nonatomic) CGSize size;

/**
* Frame texture.
*/
@property (nonatomic, strong) TDTexture *texture;

/**
* Builds a sprite frame.
*/
+ (TDSpriteFrame *)frame;

@end