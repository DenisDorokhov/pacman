//
//  Created by Denis Dorokhov on 14/11/2013.
//  Copyright (c) 2013 Denis Dorokhov. All rights reserved.
//

/** @file */

/**
* Simple application skin.
*
* Configuration tool to help application support several device types within one application.
*/
@protocol DDSkin <NSObject>

/**
* Returns absolute file path for relative one.
*/
- (NSString *)file:(NSString *)aRelativePath;

/**
* Return property as string.
*/
- (NSString *)string:(NSString *)aKey;
/**
* Return property as boolean.
*/
- (BOOL)boolValue:(NSString *)aKey;
/**
* Return property as integer.
*/
- (int)intValue:(NSString *)aKey;
/**
* Return property as float.
*/
- (float)floatValue:(NSString *)aKey;
/**
* Return property as double.
*/
- (double)doubleValue:(NSString *)aKey;

/**
* Return point.
*/
- (CGPoint)point:(NSString *)aKey;
/**
* Return size.
*/
- (CGSize)size:(NSString *)aKey;
/**
* Return rectangle.
*/
- (CGRect)rect:(NSString *)aKey;
/**
* Return inset.
*/
- (UIEdgeInsets)inset:(NSString *)aKey;

/**
* Return color.
*/
- (UIColor *)color:(NSString *)aKey;

@end