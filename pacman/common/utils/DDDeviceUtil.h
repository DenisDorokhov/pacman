//
//  DDDeviceUtil
//
//  Created by Denis Dorokhov on 15/02/2011.
//

/** @file */

/**
* Device utilities.
*/
@interface DDDeviceUtil : NSObject

/**
* Current device screen scale.
*/
+ (CGFloat)screenScale;
/**
* Current device screen size (in points).
*/
+ (CGSize)screenSize;

/**
* Returns YES if current device is iPhone / iPod Touch.
*/
+ (BOOL)isIPhone;
/**
* Returns YES if current device is iPhone / iPod Touch with retina display.
*/
+ (BOOL)isIPhoneRetina;
/**
* Returns YES if current device is iPad.
*/
+ (BOOL)isIPad;
/**
* Returns YES if current device is iPad with retina display.
*/
+ (BOOL)isIPadRetina;

@end