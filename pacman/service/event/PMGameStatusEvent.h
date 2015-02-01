//
//  PMGameStatusEvent
//  pacman
//
//  Created by Denis Dorokhov on 12/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDEvent.h"

/**
* Game status event.
*/
@interface PMGameStatusEvent : DDEvent

/**
* Dispatched when game victory is committed.
*/
+ (NSString *)didCommitVictory;

/**
* Dispatched when game defeat is committed.
*/
+ (NSString *)didCommitDefeat;

@end