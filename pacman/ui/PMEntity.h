//
//  PMEntity
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDSkin.h"
#import "TDEntity.h"
#import "PMLocationTransformer.h"
#import "TDSpriteFrameLoader.h"
#import "TDApplication.h"
#import "DDEventDispatcher.h"

/**
* Game drawable entity. Will get all commonly used services on initialization.
*/
@interface PMEntity : TDEntity
{
@protected

	/**
	* Skin.
	*/
	id <DDSkin> skin;

	/**
	* Application.
	*/
	TDApplication *application;

	/**
	* Sprite frame loader.
	*/
	id <TDSpriteFrameLoader> frameLoader;

	/**
	* Location transformer.
	*/
	PMLocationTransformer *locationTransformer;

	/**
	* Event dispatcher.
	*/
	DDEventDispatcher *eventDispatcher;
}

@end