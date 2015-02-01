//
//  TDEntityColorProxy
//  pacman
//
//  Created by Denis Dorokhov on 13/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "TDEntityColorProxy.h"
#import "TDUtil.h"

@implementation TDEntityColorProxy

@synthesize color = _color;

- (instancetype)init
{
	self = [super init];

	if (self != nil) {
		self.color = tdColorByteMake(0xFF, 0xFF, 0xFF, 0xFF);
	}

	return self;
}

#pragma mark -
#pragma mark Public

- (void)setColor:(tdColorByte)aColor
{
	_color = aColor;

	for (TDEntity *entity in self.children) {
		if ([entity conformsToProtocol:@protocol(TDEntityColored)]) {
			[(id <TDEntityColored>)entity setColor:aColor];
		}
	}
}

- (unsigned char)opacity
{
	return self.color.alpha;
}

- (void)setOpacity:(unsigned char)aOpacity
{
	tdColorByte oldColor = self.color;

	self.color = tdColorByteMake(oldColor.red, oldColor.green, oldColor.blue, aOpacity);
}

@end