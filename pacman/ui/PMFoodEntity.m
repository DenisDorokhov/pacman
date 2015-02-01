//
//  PMFoodEntity
//  pacman
//
//  Created by Denis Dorokhov on 11/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMFoodEntity.h"
#import "PMGameFoodEvent.h"
#import "PMObjectBatchEntity+Protected.h"

@interface PMFoodEntity ()

- (void) gameDidConsumeFood:(PMGameFoodEvent *)aEvent;

@end

@implementation PMFoodEntity

+ (instancetype)entityWithFood:(NSArray *)aFood
{
	return [[self alloc] initWithFood:aFood];
}

- (instancetype)initWithFood:(NSArray *)aFood
{
	self = [self init];

	if (self != nil) {

		NSDictionary *frames = [frameLoader loadBatch:[skin file:@"textures.plist"]];

		[self setObjects:aFood frame:frames[@"food"]];
	}

	return self;
}

- (instancetype)init
{
	self = [super init];

	if (self != nil) {
		[eventDispatcher addEventListener:[PMGameFoodEvent didConsumeFood]
		                           object:self selector:@selector(gameDidConsumeFood:)];
	}

	return self;
}

- (void)dealloc
{
	[eventDispatcher removeEventListenersWithObject:self];
}

#pragma mark -
#pragma mark Override

- (void) validateObjectAtIndex:(NSUInteger)aIndex
{
	[super validateObjectAtIndex:aIndex];

	PMFood *food = self.objects[aIndex];

	if (food.isConsumed) {

		size_t baseVertexIndex = [self objectVertexSize] * aIndex;

		for (size_t i = 0; i < 12; i++) {
			vertexData[baseVertexIndex + i] = 0;
		}
	}
}

#pragma mark -
#pragma mark Private

- (void) gameDidConsumeFood:(PMGameFoodEvent *)aEvent
{
	[self invalidateObject:aEvent.food];
}

@end