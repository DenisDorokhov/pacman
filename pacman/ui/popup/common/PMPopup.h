//
//  PMPopup
//  pacman
//
//  Created by Denis Dorokhov on 12/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMEntity.h"
#import "DDSkin.h"
#import "TDSpriteFrameLoader.h"

@class PMPopup;

/**
* Popup delegate.
*/
@protocol PMPopupDelegate <NSObject>

@optional

/**
* This method is called before hiding popup.
*/
- (void) popupWillHide:(PMPopup *)aPopup animated:(BOOL)aAnimated;

/**
* This method is called after hiding popup.
*/
- (void) popupDidHide:(PMPopup *)aPopup animated:(BOOL)aAnimated;

/**
* This method is called before showing popup.
*/
- (void) popupWillShow:(PMPopup *)aPopup animated:(BOOL)aAnimated;

/**
* This method is called after showing popup.
*/
- (void) popupDidShow:(PMPopup *)aPopup animated:(BOOL)aAnimated;

@end

/**
* Abstract animating popup.
*/
@interface PMPopup : PMEntity

/**
* Is popup currently shown?
*/
@property (nonatomic, readonly) BOOL isShown;

/**
* Is popup currently animating?
*/
@property (nonatomic, readonly) BOOL isAnimating;

/**
* Popup delegate.
*/
@property (nonatomic, weak) id <PMPopupDelegate> delegate;

/**
* Builds a popup.
*/
+ (instancetype)popup;

/**
* Shows / hides popup with optional animation.
*/
- (void)setIsShown:(BOOL)aIsShown animated:(BOOL)aAnimated;

@end