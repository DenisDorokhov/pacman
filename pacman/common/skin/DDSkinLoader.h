//
//  Created by Denis Dorokhov on 14/11/2013.
//  Copyright (c) 2013 Denis Dorokhov. All rights reserved.
//

/** @file */

/**
* Skin loader.
*
* Translates file contents to dictionary format supported by DDSkinImpl class.
*/
@protocol DDSkinLoader <NSObject>

/**
* Load file into dictionary for using in DDSkinImpl.
*/
- (NSDictionary *)loadFile:(NSString *)aFilePath;

@end