//
//  PMGameScene
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMGameScene.h"
#import "PMServiceLocator.h"
#import "PMGameStatusEvent.h"
#import "PMPopupVictory.h"
#import "TDSprite.h"
#import "PMMapEntity.h"
#import "PMPopupSplash.h"
#import "PMGameController.h"
#import "PMPopupDefeat.h"
#import "PMPopupVictory.h"

@interface PMGameScene ()
{
@private

	PMGameController *gameController;

	BOOL isGameActive;

	PMMapEntity *mapEntity;

	PMPopupSplash *popupSplash;
	PMPopupDefeat *popupDefeat;
	PMPopupVictory *popupVictory;

	CGPoint touchStartPosition;

	BOOL isTouching;
}

- (void)setup;

- (void)setGame:(PMGame *)aGame;

- (PMMovementDirection)touchDiffToDirection:(CGPoint)aTouchDiff;

- (void)gameDidCommitDefeat:(PMGameStatusEvent *)aEvent;
- (void)gameDidCommitVictory:(PMGameStatusEvent *)aEvent;

@end

@implementation PMGameScene

- (instancetype)init
{
	self = [super init];

	if (self != nil) {

		gameController = [PMServiceLocator gameController];

		isGameActive = YES;

		[self setup];
	}

	return self;
}

- (void)dealloc
{
	[application removeTouchHandler:self];

	[eventDispatcher removeEventListenersWithObject:self];
}

#pragma mark -
#pragma mark <TDTouchHandler>

- (void)touchesBegan:(NSSet *)aTouches withEvent:(UIEvent *)aEvent
{
	if (!isGameActive || self.game.state != PMGameState_Play) {
		return;
	}

	touchStartPosition = [application touchPosition:[aTouches anyObject]];

	isTouching = YES;
}

- (void)touchesEnded:(NSSet *)aTouches withEvent:(UIEvent *)aEvent
{
	if (!isGameActive || !isTouching) {
		return;
	}

	CGPoint currentPosition = [application touchPosition:[aTouches anyObject]];

	PMMovementDirection direction = [self touchDiffToDirection:CGPointSubtract(currentPosition, touchStartPosition)];

	if (direction != PMMovementDirection_None) {
		[gameController updatePlayerDirection:direction game:self.game];
	}

	isTouching = NO;
}

#pragma mark -
#pragma mark <PMPopupDelegate>

- (void)popupWillShow:(PMPopup *)aPopup animated:(BOOL)aAnimated
{
	isGameActive = NO;
}

- (void)popupDidShow:(PMPopup *)aPopup animated:(BOOL)aAnimated
{
	if (aPopup == popupSplash) {
		self.game = [gameController startGame];
	}
	if (aPopup == popupVictory || aPopup == popupDefeat) {
		self.game = [gameController resetGame:self.game];
	}
}

- (void)popupDidHide:(PMPopup *)aPopup animated:(BOOL)aAnimated
{
	isGameActive = YES;
}

#pragma mark -
#pragma mark Override

- (void)onUpdate:(float)aTime
{
	if (isGameActive) {
		[gameController updateWithStep:aTime game:self.game];
	}
}

#pragma mark -
#pragma mark Private

- (void)setup
{
	NSDictionary *frames = [frameLoader loadBatch:[skin file:@"textures.plist"]];

	mapEntity = [[PMMapEntity alloc] init];
	mapEntity.position = [skin point:@"mapPosition"];
	[self addChild:mapEntity];

	TDSprite *help = [TDSprite spriteWithSpriteFrame:frames[@"hand"]];
	help.position = [skin point:@"helpPosition"];
	[self addChild:help];

	popupSplash = [[PMPopupSplash alloc] init];
	popupDefeat = [[PMPopupDefeat alloc] init];
	popupVictory = [[PMPopupVictory alloc] init];

	popupSplash.delegate = self;
	popupDefeat.delegate = self;
	popupVictory.delegate = self;

	[self addChild:popupSplash];
	[self addChild:popupDefeat];
	[self addChild:popupVictory];

	[application addTouchHandler:self];

	[eventDispatcher addEventListener:[PMGameStatusEvent didCommitDefeat]
	                           object:self selector:@selector(gameDidCommitDefeat:)];
	[eventDispatcher addEventListener:[PMGameStatusEvent didCommitVictory]
	                           object:self selector:@selector(gameDidCommitVictory:)];

	[popupSplash setIsShown:YES animated:NO];
}

- (void)setGame:(PMGame *)aGame
{
	_game = aGame;

	mapEntity.game = _game;
}

- (PMMovementDirection)touchDiffToDirection:(CGPoint)aTouchDiff
{
	PMMovementDirection direction = PMMovementDirection_None;

	if (ABS(aTouchDiff.y) > ABS(aTouchDiff.x)) {
		if (aTouchDiff.y > 0) {
			direction = PMMovementDirection_Up;
		} else if (aTouchDiff.y < 0) {
			direction = PMMovementDirection_Down;
		}
	} else {
		if (aTouchDiff.x > 0) {
			direction = PMMovementDirection_Right;
		} else if (aTouchDiff.x < 0) {
			direction = PMMovementDirection_Left;
		}
	}

	return direction;
}

- (void)gameDidCommitDefeat:(PMGameStatusEvent *)aEvent
{
	[popupDefeat setIsShown:YES animated:YES];
}

- (void)gameDidCommitVictory:(PMGameStatusEvent *)aEvent
{
	[popupVictory setIsShown:YES animated:YES];
}

@end