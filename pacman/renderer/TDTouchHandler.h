//
//  TDTouchHandler
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

/**
* Abstract touch handler.
*/
@protocol TDTouchHandler <NSObject>

@optional

/**
* Touch beginning handler.
*/
- (void)touchesBegan:(NSSet *)aTouches withEvent:(UIEvent *)aEvent;

/**
* Touch moving handler.
*/
- (void)touchesMoved:(NSSet *)aTouches withEvent:(UIEvent *)aEvent;

/**
* Touch ending handler.
*/
- (void)touchesEnded:(NSSet *)aTouches withEvent:(UIEvent *)aEvent;

/**
* Touch cancellation handler.
*/
- (void)touchesCancelled:(NSSet *)aTouches withEvent:(UIEvent *)aEvent;

@end