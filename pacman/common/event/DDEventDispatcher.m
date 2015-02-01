//
//  DDEventDispatcher
//
//  Created by Denis Dorokhov on 21/04/2012.
//

#import "DDEventDispatcher.h"

@interface DDEventDispatcher ()
{
	@private

	NSMutableDictionary *typeToListeners;
}

@end

@implementation DDEventDispatcher

- (instancetype)init
{
	self = [super init];

	if (self != nil) {
		typeToListeners = [[NSMutableDictionary alloc] init];
	}

	return self;
}

#pragma mark -
#pragma mark Public

- (void)addEventListener:(NSString *)aType object:(id)aObject selector:(SEL)aSelector
{
	NSValue *objectKey = [NSValue valueWithNonretainedObject:aObject];

	NSMutableDictionary *listeners = typeToListeners[aType];
	if (listeners == nil) {
		listeners = [NSMutableDictionary dictionary];
		typeToListeners[aType] = listeners;
	}

	NSMutableSet *selectors = listeners[objectKey];
	if (selectors == nil) {
		selectors = [NSMutableSet set];
		listeners[objectKey] = selectors;
	}

	[selectors addObject:[NSValue valueWithPointer:aSelector]];
}

- (void)removeEventListener:(NSString *)aType object:(id)aObject selector:(SEL)aSelector
{
	NSMutableSet *selectors = typeToListeners[aType][[NSValue valueWithNonretainedObject:aObject]];

	[selectors removeObject:[NSValue valueWithPointer:aSelector]];
}

- (void)removeEventListenersWithObject:(id)aObject
{
	for (NSString *type in [typeToListeners copy]) {
		[typeToListeners[type] removeObjectForKey:[NSValue valueWithNonretainedObject:aObject]];
	}
}

- (void)dispatchEvent:(DDEvent *)aEvent
{
	NSMutableDictionary *listeners = typeToListeners[aEvent.type];

	for (NSValue *objectKey in [listeners copy]) {

		id object = [objectKey nonretainedObjectValue];

		for (NSValue *selectorKey in listeners[objectKey]) {

			SEL selector = [selectorKey pointerValue];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
			[object performSelector:selector withObject:aEvent];
#pragma clang diagnostic pop
		}
	}
}

@end