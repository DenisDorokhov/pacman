//
//  PMMapLoaderImpl
//  pacman
//
//  Created by Denis Dorokhov on 10/02/2013.
//  Copyright (c) Denis Dorokhov 2013. All rights reserved.
//

#import "PMMapLoaderImpl.h"
#import "PMObstacle.h"
#import "PMPlayer.h"
#import "PMFood.h"

@interface PMMapLoaderImpl ()

- (NSArray *)readFileLines;

- (PMMapCell *)cellForChar:(unichar)aChar location:(PMMapLocation)aLocation;

@end

@implementation PMMapLoaderImpl

static NSUInteger const MAP_WIDTH = 19;
static NSUInteger const MAP_HEIGHT = 19;

static unichar const MAP_CHAR_VACANT = 32; // <SPACE>
static unichar const MAP_CHAR_OBSTACLE = 79; // <O>
static unichar const MAP_CHAR_PLAYER = 80; // <P>
static unichar const MAP_CHAR_ENEMY = 69; // <E>
static unichar const MAP_CHAR_FOOD = 70; // <F>

+ (instancetype)mapLoader
{
	return [[self alloc] init];
}

#pragma mark -
#pragma mark <PMMapLoader>

- (PMMap *)loadMap
{
	NSArray *allLines = [self readFileLines];

	PMMap *map = [PMMap mapWithWidth:MAP_WIDTH height:MAP_HEIGHT];

	for (NSUInteger row = 0; row < [allLines count]; row++) {

		NSString *line = allLines[row];

		for (NSUInteger cell = 0; cell < [line length]; cell++) {
			[map putCell:[self cellForChar:[line characterAtIndex:cell] location:PMMapLocationMake(cell, row)]];
		}
	}

	return map;
}

#pragma mark -
#pragma mark Private

- (NSArray *)readFileLines
{
	NSString* filePath = [[NSBundle mainBundle] pathForResource:@"map" ofType:@"dat"];

	NSError *error = nil;

	NSString *contents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];

	if (error != nil) {
		[NSException raise:NSStringFromClass([self class]) format:@"could not read file [%@]",filePath];
	}

	return [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
}

- (PMMapCell *)cellForChar:(unichar)aChar location:(PMMapLocation)aLocation
{
	PMMapCell *cell = [PMMapCell cell];

	cell.location = aLocation;

	switch (aChar) {

		case MAP_CHAR_VACANT:
			cell.type = PMMapCellType_Vacant;
			break;

		case MAP_CHAR_OBSTACLE:
			cell.type = PMMapCellType_Obstacle;
			break;

		case MAP_CHAR_PLAYER:
			cell.type = PMMapCellType_Player;
			break;

		case MAP_CHAR_ENEMY:
			cell.type = PMMapCellType_Enemy;
			break;

		case MAP_CHAR_FOOD:
			cell.type = PMMapCellType_Food;
			break;

		default:
			[NSException raise:NSStringFromClass([self class]) format:@"unknown map char [%d]",aChar];
	}

	return cell;
}

@end