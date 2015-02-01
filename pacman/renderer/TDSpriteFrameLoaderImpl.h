//
//  TDSpriteFrameLoaderImpl
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDSpriteFrameLoader.h"
#import "TDTextureLoader.h"

/**
* Simple TDSpriteFrameLoader implementation. Needs TDTextureLoader instance.
* Supports Zwoptex Flash file format for sprite frame configuration file.
* Zwoptex Flash support is limited: this implementation does not support trimmed frames.
*/
@interface TDSpriteFrameLoaderImpl : NSObject <TDSpriteFrameLoader>

/**
* Texture loader implementation.
*/
@property (nonatomic, strong) id <TDTextureLoader> textureLoader;

/**
* Builds sprite frame loader with some texture loader.
*/
+ (instancetype)frameLoaderWithTextureLoader:(id <TDTextureLoader>)aTextureLoader;

/**
* Initializes sprite frame loader with some texture loader.
*/
- (instancetype)initWithTextureLoader:(id <TDTextureLoader>)aTextureLoader;

@end