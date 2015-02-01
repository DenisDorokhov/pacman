//
//  DDEvent
//
//  Created by Denis Dorokhov on 21/04/2012.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

/** @file */

/**
* Event class for using with event bus.
*
* Default initializer is not supported.
*/
@interface DDEvent : NSObject

/**
* Event type.
*
* Event listeners subscribe to particular event type. Cannot be nil.
*/
@property (nonatomic, readonly) NSString *type;

/**
* User data (arbitrary dictionary).
*/
@property (nonatomic, strong) NSDictionary *userData;

/**
* Default init method is unavailable.
*/
- (instancetype)init __unavailable;

/**
* Build event with type and target.
*/
+ (instancetype)eventWithType:(NSString *)aType;

/**
* Initialize event with type and target.
*/
- (instancetype)initWithType:(NSString *)aType;

@end