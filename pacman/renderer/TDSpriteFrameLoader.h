//
//  TDSpriteFrameLoader
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "TDTexture.h"
#import "TDSpriteFrame.h"

/**
* Abstract sprite frame loader.
*/
@protocol TDSpriteFrameLoader <NSObject>

/**
* Load frame from single image.
*/
- (TDSpriteFrame *)load:(NSString *)aFilePath;

/**
* Load frames from configuration file.
*/
- (NSDictionary *)loadBatch:(NSString *)aFilePath;

@end