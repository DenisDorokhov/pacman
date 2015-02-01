//
//  PMPlayerEntity
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMPlayerEntity.h"
#import "TDSprite.h"

@interface PMPlayerEntity ()
{
@private

	TDSprite *sprite;

	TDSpriteFrame *frame01;
	TDSpriteFrame *frame02;

	float animationTime;
}

- (void)setup;

- (void)updateFromObject;

- (float)directionToRotation:(PMMovementDirection)aDirection;

@end

@implementation PMPlayerEntity

static float const ANIMATION_INTERVAL = 0.2f;

+ (instancetype)entityWithPlayer:(PMPlayer *)aPlayer
{
	return [[self alloc] initWithPlayer:aPlayer];
}

- (instancetype)initWithPlayer:(PMPlayer *)aPlayer
{
	self = [self init];

	if (self != nil) {
		self.player = aPlayer;
	}

	return self;
}

- (instancetype)init
{
	self = [super init];

	if (self != nil) {
		[self setup];
	}

	return self;
}

#pragma mark -
#pragma mark Public

- (void)setPlayer:(PMPlayer *)aPlayer
{
	_player = aPlayer;

	[self updateFromObject];
}

#pragma mark -
#pragma mark Override

- (void)onUpdate:(float)aTime
{
	if (self.player.direction != PMMovementDirection_None) {

		animationTime += aTime;

		if (animationTime >= ANIMATION_INTERVAL) {

			sprite.frame = (sprite.frame == frame01 ? frame02 : frame01);

			animationTime = 0;
		}

	} else {
		animationTime = 0;
	}

	[self updateFromObject];
}

#pragma mark -
#pragma mark Private

- (void)setup
{
	NSDictionary *frames = [frameLoader loadBatch:[skin file:@"textures.plist"]];

	frame01 = frames[@"character-02"];
	frame02 = frames[@"character-01"];

	sprite = [TDSprite spriteWithSpriteFrame:frame01];

	[self addChild:sprite];

	animationTime = 0;
}

- (void)updateFromObject
{
	sprite.position = [locationTransformer objectPositionToScreenPosition:self.player.position];

	if (self.player.direction != PMMovementDirection_None) {
		sprite.rotation = [self directionToRotation:self.player.direction];
	} else if (self.player.targetDirection != PMMovementDirection_None) {
		sprite.rotation = [self directionToRotation:self.player.targetDirection];
	}
}

- (float)directionToRotation:(PMMovementDirection)aDirection
{
	float rotation = 0;

	switch (aDirection) {

		case PMMovementDirection_Up:
			rotation = -90;
			break;

		case PMMovementDirection_Down:
			rotation = 90;
			break;

		case PMMovementDirection_Left:
			rotation = 180;
			break;

		default:
			break;
	}

	return rotation;
}

@end