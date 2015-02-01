//
//  Created by Denis Dorokhov on 14/11/2013.
//  Copyright (c) 2013 Denis Dorokhov. All rights reserved.
//

#import "DDSkinImpl.h"
#import "DDDebug.h"
#import "DDLogging.h"

#define DDSkinImpl_KeyWarning(aKey) ddlog(@"value not found for key [%@]", aKey)
#define DDSkinImpl_TypeWarning(aKey, aValue, aType) ddlog(@"incorrect type [%@] for key [%@], expected type is [%@]", NSStringFromClass([aValue class]), aKey, NSStringFromClass(aType))

@interface DDSkinImpl ()
{
	@private

	NSMutableDictionary *data;
}

@end

@implementation DDSkinImpl

+ (instancetype)skinWithLoader:(id <DDSkinLoader>)aSkinLoader files:(NSArray *)aFilePaths
{
	return [[self alloc] initWithLoader:aSkinLoader files:aFilePaths];
}

+ (instancetype)skinWithLoader:(id <DDSkinLoader>)aSkinLoader file:(NSString *)aFilePath
{
	return [self skinWithLoader:aSkinLoader files:@[aFilePath]];
}

- (instancetype)init
{
	self = [super init];

	if (self != nil) {
		data = [NSMutableDictionary dictionary];
	}

	return self;
}

- (instancetype)initWithLoader:(id <DDSkinLoader>)aSkinLoader files:(NSArray *)aFilePaths
{
	self = [self init];

	if (self != nil) {

		self.skinLoader = aSkinLoader;

		for (NSString *filePath in aFilePaths) {
			[self loadFile:filePath];
		}
	}

	return self;
}

- (instancetype)initWithLoader:(id <DDSkinLoader>)aSkinLoader file:(NSString *)aFilePath
{
	return [self initWithLoader:aSkinLoader files:@[aFilePath]];
}

#pragma mark -
#pragma mark Public

- (DDLocaleManager *)localeManager
{
	if (_localeManager == nil) {
		_localeManager = [DDLocaleManager sharedLocaleManager];
	}

	return _localeManager;
}

- (void)loadFile:(NSString *)aFilePath
{
	DDAssert(aFilePath != nil);

	DDAssert(self.skinLoader != nil);

	NSDictionary *fileData = [self.skinLoader loadFile:aFilePath];

	for (NSString *key in fileData) {

		id value = fileData[key];

		if (data[key] != nil) {
			ddlog(@"overriding key [%@]", key);
		}

		data[key] = value;
	}

	ddlog(@"file [%@] loaded", aFilePath);
}

#pragma mark -
#pragma mark <DDSkin>

- (NSString *)file:(NSString *)aRelativePath
{
	DDAssert(aRelativePath != nil);

	return [self.localeManager path:aRelativePath];
}

- (NSString *)string:(NSString *)aKey
{
	DDAssert(aKey != nil);

	id value = data[aKey];

	if (value != nil) {
		if ([value isKindOfClass:[NSString class]]) {
			return value;
		} else if ([value isKindOfClass:[NSNumber class]]) {
			return [value stringValue];
		} else {
			DDSkinImpl_TypeWarning(aKey, value, [NSString class]);
		}
	} else {
		DDSkinImpl_KeyWarning(aKey);
	}

	return nil;
}

- (BOOL)boolValue:(NSString *)aKey
{
	DDAssert(aKey != nil);

	id value = data[aKey];

	if (value != nil) {
		if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
			return [value boolValue];
		} else {
			DDSkinImpl_TypeWarning(aKey, value, [NSNumber class]);
		}
	} else {
		DDSkinImpl_KeyWarning(aKey);
	}

	return NO;
}

- (int)intValue:(NSString *)aKey
{
	DDAssert(aKey != nil);

	id value = data[aKey];

	if (value != nil) {
		if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
			return [value intValue];
		} else {
			DDSkinImpl_TypeWarning(aKey, value, [NSNumber class]);
		}
	} else {
		DDSkinImpl_KeyWarning(aKey);
	}

	return NO;
}

- (float)floatValue:(NSString *)aKey
{
	DDAssert(aKey != nil);

	id value = data[aKey];

	if (value != nil) {
		if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
			return [value floatValue];
		} else {
			DDSkinImpl_TypeWarning(aKey, value, [NSNumber class]);
		}
	} else {
		DDSkinImpl_KeyWarning(aKey);
	}

	return NO;
}

- (double)doubleValue:(NSString *)aKey
{
	DDAssert(aKey != nil);

	id value = data[aKey];

	if (value != nil) {
		if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
			return [value doubleValue];
		} else {
			DDSkinImpl_TypeWarning(aKey, value, [NSNumber class]);
		}
	} else {
		DDSkinImpl_KeyWarning(aKey);
	}

	return NO;
}

- (CGPoint)point:(NSString *)aKey
{
	DDAssert(aKey != nil);

	id value = data[aKey];

	if (value != nil) {
		if ([value isKindOfClass:[NSDictionary class]]) {

			NSDictionary *dictionary = value;

			id x = dictionary[@"x"];
			id y = dictionary[@"y"];

			if ((x == nil || [x isKindOfClass:[NSNumber class]] || [x isKindOfClass:[NSString class]]) &&
					(y == nil || [y isKindOfClass:[NSNumber class]] || [y isKindOfClass:[NSString class]])) {

				CGPoint point = CGPointZero;

				point.x = [x floatValue];
				point.y = [y floatValue];

				return point;
			}

		} else {
			DDSkinImpl_TypeWarning(aKey, value, [NSDictionary class]);
		}
	} else {
		DDSkinImpl_KeyWarning(aKey);
	}

	return CGPointZero;
}

- (CGSize)size:(NSString *)aKey
{
	DDAssert(aKey != nil);

	id value = data[aKey];

	if (value != nil) {
		if ([value isKindOfClass:[NSDictionary class]]) {

			NSDictionary *dictionary = value;

			id width = dictionary[@"width"];
			id height = dictionary[@"height"];

			if ((width == nil || [width isKindOfClass:[NSNumber class]] || [width isKindOfClass:[NSString class]]) &&
					(height == nil || [height isKindOfClass:[NSNumber class]] || [height isKindOfClass:[NSString class]])) {

				CGSize size = CGSizeZero;

				size.width = [width floatValue];
				size.height = [height floatValue];

				return size;
			}

		} else {
			DDSkinImpl_TypeWarning(aKey, value, [NSDictionary class]);
		}
	} else {
		DDSkinImpl_KeyWarning(aKey);
	}

	return CGSizeZero;
}

- (CGRect)rect:(NSString *)aKey
{
	DDAssert(aKey != nil);

	id value = data[aKey];

	if (value != nil) {
		if ([value isKindOfClass:[NSDictionary class]]) {

			NSDictionary *dictionary = value;

			id x = dictionary[@"x"];
			id y = dictionary[@"y"];

			id width = dictionary[@"width"];
			id height = dictionary[@"height"];

			if ((x == nil || [x isKindOfClass:[NSNumber class]] || [x isKindOfClass:[NSString class]]) &&
					(y == nil || [y isKindOfClass:[NSNumber class]] || [y isKindOfClass:[NSString class]]) &&
					(width == nil || [width isKindOfClass:[NSNumber class]] || [width isKindOfClass:[NSString class]]) &&
					(height == nil || [height isKindOfClass:[NSNumber class]] || [height isKindOfClass:[NSString class]])) {

				CGRect rect = CGRectZero;

				rect.origin.x = [x floatValue];
				rect.origin.y = [y floatValue];

				rect.size.width = [width floatValue];
				rect.size.height = [height floatValue];

				return rect;
			}

		} else {
			DDSkinImpl_TypeWarning(aKey, value, [NSDictionary class]);
		}
	} else {
		DDSkinImpl_KeyWarning(aKey);
	}

	return CGRectZero;
}

- (UIEdgeInsets)inset:(NSString *)aKey
{
	DDAssert(aKey != nil);

	id value = data[aKey];

	if (value != nil) {
		if ([value isKindOfClass:[NSDictionary class]]) {

			NSDictionary *dictionary = value;

			id top = dictionary[@"top"];
			id bottom = dictionary[@"bottom"];

			id right = dictionary[@"right"];
			id left = dictionary[@"left"];

			if ((top == nil || [top isKindOfClass:[NSNumber class]] || [top isKindOfClass:[NSString class]]) &&
					(bottom == nil || [bottom isKindOfClass:[NSNumber class]] || [bottom isKindOfClass:[NSString class]]) &&
					(right == nil || [right isKindOfClass:[NSNumber class]] || [right isKindOfClass:[NSString class]]) &&
					(left == nil || [left isKindOfClass:[NSNumber class]] || [left isKindOfClass:[NSString class]])) {

				UIEdgeInsets inset = UIEdgeInsetsZero;

				inset.top = [top floatValue];
				inset.bottom = [bottom floatValue];

				inset.right = [right floatValue];
				inset.left = [left floatValue];

				return inset;
			}

		} else {
			DDSkinImpl_TypeWarning(aKey, value, [NSDictionary class]);
		}
	} else {
		DDSkinImpl_KeyWarning(aKey);
	}

	return UIEdgeInsetsZero;
}

- (UIColor *)color:(NSString *)aKey
{
	DDAssert(aKey != nil);

	id value = data[aKey];

	if (value != nil) {
		if ([value isKindOfClass:[NSDictionary class]]) {

			NSDictionary *dictionary = value;

			id red = dictionary[@"red"];
			id green = dictionary[@"green"];
			id blue = dictionary[@"blue"];
			id alpha = dictionary[@"alpha"];

			if ((red == nil || [red isKindOfClass:[NSNumber class]] || [red isKindOfClass:[NSString class]]) &&
					(green == nil || [green isKindOfClass:[NSNumber class]] || [green isKindOfClass:[NSString class]]) &&
					(blue == nil || [blue isKindOfClass:[NSNumber class]] || [blue isKindOfClass:[NSString class]]) &&
					(alpha == nil || [alpha isKindOfClass:[NSNumber class]] || [alpha isKindOfClass:[NSString class]])) {

				CGFloat alphaValue = [alpha floatValue];

				if (alpha == nil) {
					alphaValue = 1.0f;
				}

				return [UIColor colorWithRed:[red floatValue] green:[green floatValue] blue:[blue floatValue]
									   alpha:alphaValue];
			}

		} else {
			DDSkinImpl_TypeWarning(aKey, value, [NSDictionary class]);
		}
	} else {
		DDSkinImpl_KeyWarning(aKey);
	}

	return nil;
}

@end