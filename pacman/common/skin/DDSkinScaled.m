//
//  Created by Denis Dorokhov on 01/02/15.
//  Copyright (c) 2015 Denis Dorokhov. All rights reserved.
//

#import "DDSkinScaled.h"
#import "DDDebug.h"

@implementation DDSkinScaled

+ (instancetype)skinWithTarget:(id <DDSkin>)aTarget
{
	return [[DDSkinScaled alloc] initWithTarget:aTarget];
}

- (instancetype)initWithTarget:(id <DDSkin>)aTarget
{
	self = [self init];

	if (self != nil) {
		self.target = aTarget;
		self.scale = 1;
	}

	return self;
}

#pragma mark -
#pragma mark <DDSkin>

- (NSString *)file:(NSString *)aRelativePath
{
	DDAssert(self.target != nil);

	return [self.target file:aRelativePath];
}

- (NSString *)string:(NSString *)aKey
{
	DDAssert(self.target != nil);

	return [self.target string:aKey];
}

- (BOOL)boolValue:(NSString *)aKey
{
	DDAssert(self.target != nil);

	return [self.target boolValue:aKey];
}

- (int)intValue:(NSString *)aKey
{
	DDAssert(self.target != nil);

	return (int) ([self.target intValue:aKey] * self.scale);
}

- (float)floatValue:(NSString *)aKey
{
	DDAssert(self.target != nil);

	return [self.target floatValue:aKey] * self.scale;
}

- (double)doubleValue:(NSString *)aKey
{
	DDAssert(self.target != nil);

	return [self.target doubleValue:aKey] * self.scale;
}

- (CGPoint)point:(NSString *)aKey
{
	DDAssert(self.target != nil);

	CGPoint value = [self.target point:aKey];

	return CGPointMake(value.x * self.scale, value.y * self.scale);
}

- (CGSize)size:(NSString *)aKey
{
	DDAssert(self.target != nil);

	CGSize value = [self.target size:aKey];

	return CGSizeMake(value.width * self.scale, value.height * self.scale);
}

- (CGRect)rect:(NSString *)aKey
{
	DDAssert(self.target != nil);

	CGRect value = [self.target rect:aKey];

	return CGRectMake(value.origin.x * self.scale, value.origin.y * self.scale, value.size.width * self.scale, value.size.height * self.scale);
}

- (UIEdgeInsets)inset:(NSString *)aKey
{
	DDAssert(self.target != nil);

	UIEdgeInsets value = [self.target inset:aKey];

	return UIEdgeInsetsMake(value.top * self.scale, value.left * self.scale, value.left * self.scale, value.right * self.scale);
}

- (UIColor *)color:(NSString *)aKey
{
	DDAssert(self.target != nil);

	return [self.target color:aKey];
}

@end