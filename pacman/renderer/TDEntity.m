//
//  TDEntity
//  pacman
//
//  Created by Denis Dorokhov on 09/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "TDEntity.h"
#import "TDEntity+Protected.h"
#import "DDLogging.h"
#import "TDUtil.h"
#import <OpenGLES/ES1/gl.h>

@interface TDEntity ()
{
	NSMutableArray *_children;
}

@property (nonatomic) CGPoint anchorPixels;

@end

@implementation TDEntity

+ (instancetype)entity
{
	return [[self alloc] init];
}

- (instancetype)init
{
	self = [super init];

	if (self != nil) {

		self.position = CGPointZero;
		self.anchor = CGPointMake(0.5, 0.5);
		self.rotation = 0;
		self.scale = CGPointMake(1.0, 1.0);
		self.size = CGSizeZero;
		self.isVisible = YES;

		_children = [[NSMutableArray alloc] init];

		_isActivated = NO;
	}

	return self;
}

#pragma mark -
#pragma mark Public

- (void)setAnchor:(CGPoint)aAnchor
{
	_anchor = aAnchor;
	_anchorPixels = CGPointScale(_anchor, CGPointFromCGSize(self.size));
}

- (void)setSize:(CGSize)aSize
{
	_size = aSize;
	_anchorPixels = CGPointScale(_anchor, CGPointFromCGSize(self.size));
}

- (NSArray *)children
{
	return [NSArray arrayWithArray:_children];
}

- (void)setChildren:(NSArray *)aChildren
{
	_children = [[NSMutableArray alloc] initWithArray:aChildren];
}

- (void)addChild:(TDEntity *)aEntity
{
	[self addChild:aEntity at:[_children count]];
}

- (void)addChild:(TDEntity *)aEntity at:(NSUInteger)aIndex
{
	if (aEntity.parent != nil) {
		[NSException raise:NSStringFromClass([self class]) format:@"object already added as a child"];
	}

	[_children insertObject:aEntity atIndex:aIndex];

	aEntity.parent = self;

	[aEntity activate];
}

- (void)removeChild:(TDEntity *)aEntity
{
	NSUInteger index = [_children indexOfObject:aEntity];

	if (index != NSNotFound) {
		[self removeChildAt:index];
	} else {
		ddlog(@"child %@ not found",aEntity);
	}
}

- (void)removeChildAt:(NSUInteger)aIndex
{
	TDEntity *entity = _children[aIndex];

	[entity passivate];

	[_children removeObjectAtIndex:aIndex];
}

- (void)removeAllChildren
{
	while ([_children count] > 0) {
		[self removeChildAt:0];
	}
}

- (void)activate
{
	_isActivated = YES;

	[self onActivated];

	for (TDEntity *entity in _children) {
		[entity onActivated];
	}
}

- (void)passivate
{
	_isActivated = NO;

	[self onPassivated];

	for (TDEntity *entity in _children) {
		[entity onPassivated];
	}
}

- (void)update:(float)aTime
{
	[self onUpdate:aTime];

	for (TDEntity *entity in _children) {
		[entity update:aTime];
	}
}

- (void)visit
{
	if (!self.isVisible) {
		return;
	}

	glPushMatrix();

	[self validate];

	[self transform];

	[self draw];

#if defined(TD_DEBUG) && TD_DEBUG == 1
	GLenum glError = glGetError();
	if (glError != 0) {
		ddlog(@"OpenGL error %u", glError);
	}
#endif

	for (TDEntity *entity in _children) {
		[entity visit];
	}

	glPopMatrix();
}

#pragma mark -
#pragma mark Protected

- (void)onActivated
{}

- (void)onPassivated
{}

- (void)validate
{}

- (void)transform
{
	glTranslatef(-self.anchorPixels.x, -self.anchorPixels.y, 0);
	glTranslatef(self.position.x + self.anchorPixels.x, self.position.y + self.anchorPixels.y, 0);

	glRotatef(-self.rotation, 0, 0, 1);
	glScalef(self.scale.x, self.scale.y, 1);

	glTranslatef(-self.anchorPixels.x, -self.anchorPixels.y, 0);
}

- (void)onUpdate:(float)aTime
{}

- (void)draw
{}

@end