//
//  DDErrorUtil
//
//  Created by Denis Dorokhov on 15/02/2011.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
* Error utilities.
*/
@interface DDErrorUtil : NSObject

/**
* Builds error with message, object class name as its domain and zero code.
*/
+ (NSError *)errorForObject:(NSObject *)aObject message:(NSString *)aMessage;
/**
* Builds error with message, object class name as its domain and particular code.
*/
+ (NSError *)errorForObject:(NSObject *)aObject code:(NSInteger)aCode message:(NSString *)aMessage;

/**
* Builds error with message, class name as its domain and zero code.
*/
+ (NSError *)errorForClass:(Class)aClass message:(NSString *)aMessage;
/**
* Builds error with message, class name as its domain and particular code.
*/
+ (NSError *)errorForClass:(Class)aClass code:(NSInteger)aCode message:(NSString *)aMessage;

/**
* Build error with domain, code and message.
*/
+ (NSError *)errorWithDomain:(NSString *)aDomain code:(NSInteger)aCode message:(NSString *)aMessage;

/**
* Build exception with message and object class name as exception name.
*/
+ (NSException *)exceptionForObject:(NSObject *)aObject message:(NSString *)aMessage;
/**
* Build exception with message and class name as exception name.
*/
+ (NSException *)exceptionForClass:(Class)aClass message:(NSString *)aMessage;

@end