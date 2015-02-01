//
//  DDDeviceUtil
//
//  Created by Denis Dorokhov on 15/02/2011.
//

#import "DDDeviceUtil.h"
#include <sys/sysctl.h>

@implementation DDDeviceUtil

+ (CGFloat)screenScale
{
	return [[UIScreen mainScreen] respondsToSelector:@selector(scale)] ? [[UIScreen mainScreen] scale] : 1.0f;
}

+ (CGSize)screenSize
{
	return [[UIScreen mainScreen] bounds].size;
}

+ (BOOL)isIPhone
{
	if ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)]) {
		return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
	}

	return YES;
}

+ (BOOL)isIPhoneRetina
{
	return ([self isIPhone] && [self screenScale] == 2.0f);
}

+ (BOOL)isIPad
{
	return [[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] &&
			[[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

+ (BOOL)isIPadRetina
{
	if ([self screenScale] == 2.0f) {
		return [self isIPad];
	}

	return NO;
}

+ (NSString *)platformAsString
{
	size_t size;

	sysctlbyname("hw.machine", NULL, &size, NULL, 0);

	char *machine = malloc(size);

	sysctlbyname("hw.machine", machine, &size, NULL, 0);

	NSString *platform = @(machine);

	free(machine);

	return platform;
}

@end