//
//  PMGameFoodEvent
//  pacman
//
//  Created by Denis Dorokhov on 13/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMGameFoodEvent.h"

@implementation PMGameFoodEvent

+ (NSString *)didConsumeFood
{
	return @"PMGameFoodEvent_didConsumeFood";
}

@end