//
//  PMScene
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMScene.h"
#import "DDDeviceUtil.h"

@implementation PMScene

- (instancetype)init
{
	self = [super init];

	if (self != nil) {

		CGFloat scaleValue = [DDDeviceUtil screenScale] / 2.0f;

		self.scale = CGPointMake(scaleValue, scaleValue);
	}

	return self;
}

@end