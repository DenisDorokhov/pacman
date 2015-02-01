//
//  DDErrorUtil
//
//  Created by Denis Dorokhov on 09/05/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "DDErrorUtil.h"

@implementation DDErrorUtil

+ (NSError *)errorForObject:(NSObject *)aObject message:(NSString *)aMessage
{
	return [self errorForObject:aObject code:0 message:aMessage];
}

+ (NSError *)errorForObject:(NSObject *)aObject code:(NSInteger)aCode message:(NSString *)aMessage
{
	return [self errorForClass:[aObject class] code:aCode message:aMessage];
}

+ (NSError *)errorForClass:(Class)aClass message:(NSString *)aMessage
{
	return [self errorForClass:aClass code:0 message:aMessage];
}

+ (NSError *)errorForClass:(Class)aClass code:(NSInteger)aCode message:(NSString *)aMessage
{
	return [self errorWithDomain:NSStringFromClass(aClass) code:aCode message:aMessage];
}

+ (NSError *)errorWithDomain:(NSString *)aDomain code:(NSInteger)aCode message:(NSString *)aMessage
{
	NSDictionary *userInfo = @{NSLocalizedDescriptionKey : aMessage};

	return [NSError errorWithDomain:aDomain code:aCode userInfo:userInfo];
}

+ (NSException *)exceptionForObject:(NSObject *)aObject message:(NSString *)aMessage
{
	return [self exceptionForClass:[aObject class] message:aMessage];
}

+ (NSException *)exceptionForClass:(Class)aClass message:(NSString *)aMessage
{
	return [NSException exceptionWithName:NSStringFromClass(aClass) reason:aMessage userInfo:nil];
}

@end