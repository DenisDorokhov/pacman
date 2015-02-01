//
//  PMPopupFading
//  pacman
//
//  Created by Denis Dorokhov on 12/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMPopup.h"

/**
* Popup implementation with fading effect for showing and hiding.
*/
@interface PMPopupFading : PMPopup

/**
* Fade animation duration.
*/
@property (nonatomic) float fadingDuration;

@end