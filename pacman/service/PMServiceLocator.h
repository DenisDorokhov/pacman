//
//  PMServiceLocator
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDSkin.h"
#import "TDApplication.h"
#import "TDTextureLoaderCached.h"
#import "TDSpriteFrameLoaderCached.h"
#import "PMLocationTransformer.h"
#import "PMMapLoader.h"
#import "PMGameController.h"
#import "DDEventDispatcher.h"

/**
* Game service locator.
*/
@interface PMServiceLocator : NSObject

/**
* Skin.
*/
+ (id <DDSkin>)skin;

/**
* 2D application.
*/
+ (TDApplication *)application;

/**
* Texture loader.
*/
+ (TDTextureLoaderCached *)textureLoader;

/**
* Sprite frame loader.
*/
+ (TDSpriteFrameLoaderCached *)spriteFrameLoader;

/**
* Game map loader.
*/
+ (id <PMMapLoader>)mapLoader;

/**
* Location transformer.
*/
+ (PMLocationTransformer *)locationTransformer;

/**
* Game controller.
*/
+ (PMGameController *)gameController;

/**
* Event bus.
*/
+ (DDEventDispatcher *)eventDispatcher;

@end