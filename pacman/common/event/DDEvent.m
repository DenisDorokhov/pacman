//
//  DDEvent
//
//  Created by Denis Dorokhov on 21/04/2012.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "DDEvent.h"
#import "DDErrorUtil.h"
#import "DDDebug.h"

@implementation DDEvent

+ (instancetype)eventWithType:(NSString *)aType
{
	return [[self alloc] initWithType:aType];
}

- (instancetype)initWithType:(NSString *)aType
{
	DDAssert(aType != nil);

	self = [super init];

	if (self != nil) {
		_type = [aType copy];
	}

	return self;
}

@end