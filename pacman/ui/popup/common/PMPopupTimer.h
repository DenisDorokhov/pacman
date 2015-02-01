//
//  PMPopupTimer
//  pacman
//
//  Created by Denis Dorokhov on 13/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMPopupColored.h"

/**
* Popup implementation that will be automatically hidden after some time.
*/
@interface PMPopupTimer : PMPopupColored

/**
* Popup show time.
*/
@property (nonatomic) float showTime;

@end