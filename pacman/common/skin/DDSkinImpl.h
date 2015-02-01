//
//  Created by Denis Dorokhov on 14/11/2013.
//  Copyright (c) 2013 Denis Dorokhov. All rights reserved.
//

/** @file */

#import "DDSkin.h"
#import "DDSkinLoader.h"
#import "DDLocaleManager.h"

/**
* Default skin implementation.
*
* This implementation loads file using DDSkinLoader instance which must return dictionary in the following format:
*
* 1) Dictionary key is used as skin property key.
* 2) Point, size, rectangle, inset and color are dictionaries.
* 3) Point is built using "x", "y" dictionary elements (NSNumber or NSString).
* 4) Size is built using "width", "height" dictionary elements (NSNumber or NSString).
* 5) Rectangle is built using "x", "y", "width", "height" dictionary elements (NSNumber or NSString).
* 6) Inset is built using "top", "bottom", "right", "left" dictionary elements (NSNumber or NSString).
* 7) Color is built using "red", "green", "blue", "alpha" dictionary elements (NSNumber or NSString). If alpha is not set, 1.0 alpha will be used.
* 8) String, boolean, integer, float and double values must be NSNumber or NSString.
*
* This implementation returns localized file path for a relative path.
*/
@interface DDSkinImpl : NSObject <DDSkin>

/**
* Skin loader.
*/
@property (nonatomic, strong) id <DDSkinLoader> skinLoader;

/**
* Locale manager. It's shared locale manager by default.
*/
@property (nonatomic, strong) DDLocaleManager *localeManager;

/**
* Build skin with loader and several files.
*/
+ (instancetype)skinWithLoader:(id <DDSkinLoader>)aSkinLoader files:(NSArray *)aFilePaths;
/**
* Build skin with loader and single file.
*/
+ (instancetype)skinWithLoader:(id <DDSkinLoader>)aSkinLoader file:(NSString *)aFilePath;

/**
* Initialize skin with loader and several files.
*/
- (instancetype)initWithLoader:(id <DDSkinLoader>)aSkinLoader files:(NSArray *)aFilePaths;
/**
* Initialize skin with loader and single file.
*/
- (instancetype)initWithLoader:(id <DDSkinLoader>)aSkinLoader file:(NSString *)aFilePath;

/**
* Load file.
*/
- (void)loadFile:(NSString *)aFilePath;

@end