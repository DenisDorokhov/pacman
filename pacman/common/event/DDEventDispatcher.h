//
//  DDEventDispatcher
//
//  Created by Denis Dorokhov on 21/04/2012.
//

#import "DDEvent.h"

/** @file */

/**
* Event bus.
*/
@interface DDEventDispatcher : NSObject

/**
* Add event listener for particular event type.
*/
- (void)addEventListener:(NSString *)aType object:(id)aObject selector:(SEL)aSelector;

/**
* Remove event listener for particular event type.
*/
- (void)removeEventListener:(NSString *)aType object:(id)aObject selector:(SEL)aSelector;
/**
* Remove event listener with particular object for all event types.
*/
- (void)removeEventListenersWithObject:(id)aObject;

/**
* Dispatch event and call all its type listeners.
*/
- (void)dispatchEvent:(DDEvent *)aEvent;

@end