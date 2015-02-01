//
//  Created by Denis Dorokhov on 14/11/2013.
//  Copyright (c) 2013 Denis Dorokhov. All rights reserved.
//

/** @file */

#import "DDSkinLoader.h"

/**
* Skin loader for PLIST files.
*
* This implementation parses PLIST file into a dictionary returning it.
*/
@interface DDSkinLoaderPlist : NSObject <DDSkinLoader>

/**
* Build skin loader.
*/
+ (instancetype)skinLoader;

/**
* Loads PLIST data.
*/
- (NSDictionary *)loadData:(NSData *)aData;

@end