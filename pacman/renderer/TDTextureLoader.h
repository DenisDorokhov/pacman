//
//  TDTextureLoader
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "TDTexture.h"

/**
* Abstract texture loader.
*/
@protocol TDTextureLoader <NSObject>

/**
* Load texture synchronously.
*/
- (TDTexture *) load:(NSString *)aFilePath;

@end