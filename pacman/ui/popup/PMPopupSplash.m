//
//  PMPopupSplash
//  pacman
//
//  Created by Denis Dorokhov on 12/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMPopupSplash.h"
#import "PMPopup+Protected.h"
#import "TDEntity+Protected.h"
#import "PMPopupFading+Protected.h"
#import "TDSprite.h"

@implementation PMPopupSplash

#pragma mark -
#pragma mark Override

- (void) setup
{
	[super setup];

	TDSprite *sprite = [TDSprite spriteWithSpriteFrame:[frameLoader load:[skin file:@"Default.png"]]];
	sprite.anchor = CGPointZero;
	[self.colorProxy addChild:sprite];
}

@end