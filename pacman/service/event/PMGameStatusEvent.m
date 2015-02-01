//
//  PMGameStatusEvent
//  pacman
//
//  Created by Denis Dorokhov on 12/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMGameStatusEvent.h"

@implementation PMGameStatusEvent

+ (NSString *)didCommitVictory
{
	return @"PMGameStatusEvent_didCommitVictory";
}

+ (NSString *)didCommitDefeat
{
	return @"PMGameStatusEvent_didCommitDefeat";
}

@end