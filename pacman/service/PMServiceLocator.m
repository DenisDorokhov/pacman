//
//  PMServiceLocator
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMServiceLocator.h"
#import "TDTextureLoaderImpl.h"
#import "TDSpriteFrameLoaderImpl.h"
#import "PMMapLoaderImpl.h"
#import "PMMapLoaderCached.h"
#import "TDFPSCounter.h"
#import "DDSkinImpl.h"
#import "DDSkinLoaderPlist.h"
#import "DDSkinScaled.h"


@implementation PMServiceLocator

static id <DDSkin> _skin = nil;
static TDApplication *_application = nil;
static TDTextureLoaderCached *_textureLoader = nil;
static TDSpriteFrameLoaderCached *_spriteFrameLoader = nil;
static PMMapLoaderCached *_mapLoader = nil;
static PMLocationTransformer *_locationTransformer = nil;
static PMGameController *_gameController = nil;
static TDFPSCounter *_fpsCounter = nil;
static DDEventDispatcher *_eventDispatcher = nil;

+ (id <DDSkin>)skin
{
	if (_skin == nil) {

		DDSkinImpl *skin = [DDSkinImpl skinWithLoader:[DDSkinLoaderPlist skinLoader]
		                                         file:[[NSBundle mainBundle] pathForResource:@"skin" ofType:@"plist"]];

		DDSkinScaled *skinScaled = [DDSkinScaled skinWithTarget:skin];

		skinScaled.scale = 2;

		_skin = skinScaled;
	}

	return _skin;
}

+ (TDApplication *)application
{
	if (_application == nil) {

		_fpsCounter = [[TDFPSCounter alloc] init];
		_fpsCounter.consoleOutput = YES;

		_application = [[TDApplication alloc] init];
		_application.surfaceColor = tdColorByteMake(0x2F, 0x2F, 0x3B, 0xFF);
		_application.delegate = _fpsCounter;
	}

	return _application;
}

+ (TDTextureLoaderCached *)textureLoader
{
	if (_textureLoader == nil) {
		_textureLoader = [TDTextureLoaderCached textureLoaderWithTarget:[TDTextureLoaderImpl textureLoader]];
	}

	return _textureLoader;
}

+ (TDSpriteFrameLoaderCached *)spriteFrameLoader
{
	if (_spriteFrameLoader == nil) {

		TDSpriteFrameLoaderImpl *frameLoaderImpl = [TDSpriteFrameLoaderImpl frameLoaderWithTextureLoader:[self textureLoader]];

		_spriteFrameLoader = [[TDSpriteFrameLoaderCached alloc] initWithTarget:frameLoaderImpl];
	}

	return _spriteFrameLoader;
}

+ (id <PMMapLoader>)mapLoader
{
	if (_mapLoader == nil) {
		_mapLoader = [[PMMapLoaderCached alloc] initWithTarget:[PMMapLoaderImpl mapLoader]];
	}

	return _mapLoader;
}

+ (PMLocationTransformer *)locationTransformer
{
	if (_locationTransformer == nil) {
		_locationTransformer = [[PMLocationTransformer alloc] init];
	}

	return _locationTransformer;
}

+ (PMGameController *)gameController
{
	if (_gameController == nil) {
		_gameController = [[PMGameController alloc] init];
	}

	return _gameController;
}

+ (DDEventDispatcher *)eventDispatcher
{
	if (_eventDispatcher == nil) {
		_eventDispatcher = [[DDEventDispatcher alloc] init];
	}

	return _eventDispatcher;
}

@end