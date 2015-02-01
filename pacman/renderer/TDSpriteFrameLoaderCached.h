//
//  TDSpriteFrameLoaderCached
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDSpriteFrameLoader.h"

/**
* Caching sprite frame loader. Follows decorator design pattern - needs TSSpriteFrameLoader implementation.
*/
@interface TDSpriteFrameLoaderCached : NSObject <TDSpriteFrameLoader>

/**
* Sprite frame loader to cache.
*/
@property (nonatomic, strong) id <TDSpriteFrameLoader> target;

/**
* Builds frame loader that caches some TDSpriteFrameLoader implementation.
*/
+ (instancetype)frameLoaderWithTarget:(id <TDSpriteFrameLoader>)aTarget;

/**
* Initializes frame loader that caches some TDSpriteFrameLoader implementation.
*/
- (instancetype)initWithTarget:(id <TDSpriteFrameLoader>)aTarget;

/**
* Removes all frames from cache.
*/
- (void)clearAll;

/**
* Removes not used frames from cache.
*/
- (void)clearUnused;

@end