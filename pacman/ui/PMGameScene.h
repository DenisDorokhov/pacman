//
//  PMGameScene
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMScene.h"
#import "TDTouchHandler.h"
#import "PMGame.h"
#import "PMPopup.h"

/**
* Main game scene.
*/
@interface PMGameScene : PMScene <TDTouchHandler, PMPopupDelegate>

/**
* Game model.
*/
@property (nonatomic, readonly) PMGame *game;

@end