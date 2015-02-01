//
//  TDEntity
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
* Drawable 2D application entity.
*/
@interface TDEntity : NSObject

/**
* Entity position.
*/
@property (nonatomic) CGPoint position;

/**
* Entity normalized anchor point.
*/
@property (nonatomic) CGPoint anchor;

/**
* Entity anchor point in pixels.
*/
@property (nonatomic, readonly) CGPoint anchorPixels;

/**
* Rotation in radians.
*/
@property (nonatomic) float rotation;

/**
* Scale.
*/
@property (nonatomic) CGPoint scale;

/**
* Entity size. It is important to define it when using anchor point.
*/
@property (nonatomic) CGSize size;

/**
* Should entity be rendered?
*/
@property (nonatomic) BOOL isVisible;

/**
* Is entity activated? Entity is activated if it is inside current application scene.
*/
@property (nonatomic, readonly) BOOL isActivated;

/**
* Child antities (NSArray of TDEntity).
*/
@property (nonatomic, strong) NSArray *children;

/**
* Parent entity.
*/
@property (nonatomic, weak) TDEntity *parent;

/**
* Builds an entity.
*/
+ (instancetype)entity;

/**
* Adds child entity.
*/
- (void)addChild:(TDEntity *)aEntity;

/**
* Adds child entity at some index.
*/
- (void)addChild:(TDEntity *)aEntity at:(NSUInteger)aIndex;

/**
* Removes child entity.
*/
- (void)removeChild:(TDEntity *)aEntity;

/**
* Removes child entity at some index.
*/
- (void)removeChildAt:(NSUInteger)aIndex;

/**
* Removes all child entities.
*/
- (void)removeAllChildren;

/**
* Activates entity and its children recursively. This method doesn't need to be called explicitly.
*/
- (void)activate;

/**
* Passivates entity and its children recursively. This method doesn't need to be called explicitly.
*/
- (void)passivate;

/**
* Updates entity with last frame time.
*/
- (void)update:(float)aTime;

/**
* Visits entity the following way:
*
* 1) Pushes transformation matrix.
* 2) Validates entity.
* 3) Transforms entity.
* 4) Draws entity.
* 5) Visits child entities.
* 6) Pops transformation matrix.
*/
- (void)visit;

@end