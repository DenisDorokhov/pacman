//
//  PMPopupFading(Protected)
//  pacman
//
//  Created by Denis Dorokhov on 12/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMPopupFading.h"

/**
* Fading popup protected methods.
*/
@interface PMPopupFading (Protected)

/**
* This method is called when show animation is started.
*/
- (void)onShowingAnimationStarted;

/**
* This method is called when show animation is finished.
*/
- (void)onShowingAnimationFinished;

/**
* This method is called when hiding animation is started.
*/
- (void)onHidingAnimationStarted;

/**
* This method is called when hiding animation is finished.
*/
- (void)onHidingAnimationFinished;

/**
* This method is called when popup is shown without animation. This method must be overridden.
*/
- (void)showWithoutAnimation;

/**
* This method is called when popup is hidden without animation. This method must be overridden.
*/
- (void)hideWithoutAnimation;

/**
* Sets popup opacity. This method must be overridden.
*/
- (void)setOpacity:(unsigned char)aOpacity;

@end