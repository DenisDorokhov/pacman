//
//  TDTextureLoaderCached
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDTextureLoader.h"

/**
* Caching texture loader. Follows decorator design pattern - needs TDTextureLoader implementation.
*/
@interface TDTextureLoaderCached : NSObject <TDTextureLoader>

/**
* Texture loader to cache.
*/
@property (nonatomic, strong) id <TDTextureLoader> target;

/**
* Builds texture loader that caches some TDTextureLoader instance.
*/
+ (instancetype)textureLoaderWithTarget:(id <TDTextureLoader>)aTarget;

/**
* Initializes texture loader that caches some TDTextureLoader instance.
*/
- (instancetype)initWithTarget:(id <TDTextureLoader>)aTarget;

/**
* Removes all textures from the cache.
*/
- (void)clearAll;

/**
* Removes all not used textures from the cache.
*/
- (void)clearUnused;

@end