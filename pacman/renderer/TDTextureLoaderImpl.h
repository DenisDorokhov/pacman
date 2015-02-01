//
//  TDTextureLoaderImpl
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDTextureLoader.h"

/**
* Simple texture loader implementation.
*/
@interface TDTextureLoaderImpl : NSObject <TDTextureLoader>

/**
* Builds a texture loader.
*/
+ (instancetype)textureLoader;

@end