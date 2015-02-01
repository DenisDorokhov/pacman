//
//  PMPopupColored
//  pacman
//
//  Created by Denis Dorokhov on 12/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMPopupFading.h"
#import "TDFilledRectangle.h"
#import "TDEntityColorProxy.h"

/**
* Popup implementation with filled rectangle as a background.
*/
@interface PMPopupColored : PMPopupFading

/**
* Background rectangle.
*/
@property (nonatomic, readonly) TDFilledRectangle *rectangle;

/**
* Foreground entity.
*/
@property (nonatomic, readonly) TDEntityColorProxy *colorProxy;

/**
* Builds a popup with some background color.
*/
+ (instancetype)popupWithRectangleColor:(tdColorByte)aColor;

/**
* Initializes a popup with some background color.
*/
- (instancetype)initWithRectangleColor:(tdColorByte)aColor;

@end