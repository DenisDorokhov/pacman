//
//  PMPopupVictory
//  pacman
//
//  Created by Denis Dorokhov on 13/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMPopupVictory.h"
#import "PMPopup+Protected.h"
#import "TDSprite.h"

@implementation PMPopupVictory

#pragma mark -
#pragma mark Override

- (void) setup
{
	[super setup];

	NSDictionary *frames = [frameLoader loadBatch:[skin file:@"textures.plist"]];

	TDSprite *label = [TDSprite spriteWithSpriteFrame:frames[@"victory"]];
	label.position = [skin point:@"popupLabelPosition"];

	TDSprite *icon = [TDSprite spriteWithSpriteFrame:frames[@"icon"]];
	icon.position = [skin point:@"iconPosition"];

	[self.colorProxy addChild:label];
	[self.colorProxy addChild:icon];
}

@end