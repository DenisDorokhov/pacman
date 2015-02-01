//
//  PMPopup(Protected)
//  pacman
//
//  Created by Denis Dorokhov on 12/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMPopup.h"

/**
* Popup protected methods.
*/
@interface PMPopup (Protected)

/**
* Initializes popup.
*/
- (void)setup;

/**
* Finishes showing of popup.
*/
- (void)finishShowing;

/**
* Finishes hiding of popup.
*/
- (void)finishHiding;

/**
* Shows popup with optional animation. This method must be overridden.
*/
- (void)show:(BOOL)aAnimated;

/**
* Hides popup with optional animation. This method must be overridden.
*/
- (void)hide:(BOOL)aAnimated;

@end