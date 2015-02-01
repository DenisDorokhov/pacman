//
//  PMMapLoaderCached
//  pacman
//
//  Created by Denis Dorokhov on 11/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMMapLoader.h"

/**
* Caching map loader. Follows decorator design pattern - needs TDMapLoader implementation.
*/
@interface PMMapLoaderCached : NSObject <PMMapLoader>

/**
* Map loader to cache.
*/
@property (nonatomic, strong) id <PMMapLoader> target;

/**
* Builds map loader with PMMapLoader instance to cache.
*/
+ (instancetype)mapLoaderWithTarget:(id <PMMapLoader>)aTarget;

/**
* Initializes map loader with PMMapLoader instance to cache.
*/
- (instancetype)initWithTarget:(id <PMMapLoader>)aTarget;

@end