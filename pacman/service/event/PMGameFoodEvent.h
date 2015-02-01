//
//  PMGameFoodEvent
//  pacman
//
//  Created by Denis Dorokhov on 13/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMFood.h"
#import "DDEvent.h"

/**
* Game food event.
*/
@interface PMGameFoodEvent : DDEvent

/**
* Food instance.
*/
@property (nonatomic, strong) PMFood *food;

/**
* Dispatched when food is consumed.
*/
+ (NSString *)didConsumeFood;

@end