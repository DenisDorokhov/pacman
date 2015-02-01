//
//  Created by Denis Dorokhov on 31/10/2013.
//  Copyright (c) 2013 Denis Dorokhov. All rights reserved.
//

#import "DDLocaleManager.h"
#import "DDLogging.h"
#import "DDDebug.h"
#import "NSArray+NSValue.h"

@interface DDLocaleManager ()
{
	@private

	NSBundle *currentBundle;

	NSMutableArray *delegates;
}

@end

@implementation DDLocaleManager

static NSString *const USER_DEFAULTS_KEY = @"DDLocaleManager.language";
static NSString *const DEFAULT_LANGUAGE = @"en"; // This language will be used if there are no other languages available.

static DDLocaleManager *_sharedInstance = nil;

+ (instancetype)sharedLocaleManager
{
	if (_sharedInstance == nil) {
		_sharedInstance = [[DDLocaleManager alloc] init];
	}

	return _sharedInstance;
}

- (instancetype)init
{
	self = [super init];

	if (self != nil) {

		delegates = [[NSMutableArray alloc] init];

		BOOL isLanguageLoaded = NO;

		if (self.defaultLanguage != nil) {
			if ([self changeLanguage:self.defaultLanguage makeDefault:NO]) {
				isLanguageLoaded = YES;
			} else {
				ddlog(@"could not load remembered language [%@]", self.defaultLanguage);
			}
		}

		if (!isLanguageLoaded && self.systemLanguage != nil) {
			if ([self changeLanguage:self.systemLanguage makeDefault:NO]) {
				isLanguageLoaded = YES;
			} else {
				ddlog(@"could not load system language [%@]", self.systemLanguage);
			}
		}

		if (!isLanguageLoaded) {
			[self changeLanguage:DEFAULT_LANGUAGE makeDefault:NO];
		}
	}

	return self;
}

#pragma mark -
#pragma mark Public

- (NSString *)defaultLanguage
{
	return [[NSUserDefaults standardUserDefaults] stringForKey:USER_DEFAULTS_KEY];
}

- (NSString *)systemLanguage
{
	NSString *systemLanguage = nil;

	NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];

	if ([languages count] > 0) {
		systemLanguage = languages[0];
	}

	return systemLanguage;
}

- (NSString *)string:(NSString *)aKey, ...
{
	NSBundle *bundle = currentBundle;

	if (bundle == nil) {
		bundle = [NSBundle mainBundle];
	}

	NSString *format = [bundle localizedStringForKey:aKey value:aKey table:nil];

	va_list argumentList;
	va_start(argumentList, aKey);
	NSString *result = [[NSString alloc] initWithFormat:format arguments:argumentList];
	va_end(argumentList);

	return result;
}

- (NSString *)path:(NSString *)aFile
{
	return [self path:aFile root:nil];
}

- (NSString *)path:(NSString *)aFile root:(NSString *)aRoot
{
	NSBundle *localeBundle = nil;
	NSBundle *rootBundle = nil;

	if (aRoot != nil) {

		localeBundle = [NSBundle bundleWithPath:[aRoot stringByAppendingPathComponent:[self buildLocaleFolderName:self.language]]];
		rootBundle = [NSBundle bundleWithPath:aRoot];
	}

	if (rootBundle == nil) {

		localeBundle = currentBundle;
		rootBundle = [NSBundle mainBundle];

		aRoot = nil;
	}

	NSString *resultPath = nil;

	// Look for file of name of special format in main bundle.
	resultPath = [rootBundle pathForResource:[self buildLocalizedFileName:aFile language:self.language] ofType:nil];

	if (resultPath == nil) {
		// Look for file of name of special format in default language bundle.
		resultPath = [rootBundle pathForResource:[self buildLocalizedFileName:aFile language:DEFAULT_LANGUAGE] ofType:nil];
	}
	if (resultPath == nil && localeBundle != nil) {
		// Look for file in current locale bundle.
		resultPath = [localeBundle pathForResource:aFile ofType:nil];
	}
	if (resultPath == nil && localeBundle != rootBundle) {
		// Look for file in root (if root argument exists) or main bundle.
		resultPath = [rootBundle pathForResource:aFile ofType:nil];
	}
	if (resultPath == nil && aRoot != nil) {
		// Look for file ignoring root argument
		resultPath = [self path:aFile root:nil];
	}

	return resultPath != nil ? resultPath : aFile;
}

- (BOOL)changeLanguage:(NSString *)aLanguage makeDefault:(BOOL)aMakeDefault
{
	DDAssert(aLanguage != nil);

	NSString *bundlePath = [[NSBundle mainBundle] pathForResource:[self buildLocaleFolderName:aLanguage] ofType:nil];

	if (bundlePath != nil) {

		ddlog(@"loading language [%@] with bundle [%@]", aLanguage, bundlePath);

		for (id <DDLocaleManagerDelegate> delegate in [delegates nonretainedObjects]) {
			[delegate localeManager:self willChangeLanguageTo:aLanguage];
		}

		_language = [aLanguage copy];

		currentBundle = [NSBundle bundleWithPath:bundlePath];

		for (id <DDLocaleManagerDelegate> delegate in [delegates nonretainedObjects]) {
			[delegate localeManagerDidChangeLanguage:self];
		}

		if (aMakeDefault) {
			[[NSUserDefaults standardUserDefaults] setObject:_language forKey:USER_DEFAULTS_KEY];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}

		return YES;

	} else {
		ddlog(@"could not find bundle for language [%@]", aLanguage);
	}

	return NO;
}

- (void)addDelegate:(id <DDLocaleManagerDelegate>)aDelegate
{
	NSValue *value = [NSValue valueWithNonretainedObject:aDelegate];

	if ([delegates indexOfObject:value] == NSNotFound) {
		[delegates addObject:value];
	}
}

- (void)removeDelegate:(id <DDLocaleManagerDelegate>)aDelegate
{
	[delegates removeObject:[NSValue valueWithNonretainedObject:aDelegate]];
}

#pragma mark -
#pragma mark Private

- (NSString *)buildLocaleFolderName:(NSString *)aLanguage
{
	return [NSString stringWithFormat:@"%@.lproj", aLanguage];
}

- (NSString *)buildLocalizedFileName:(NSString *)aFile language:(NSString *)aLanguage
{
	NSString *fileName = [aFile stringByDeletingPathExtension];
	NSString *fileExtension = [aFile pathExtension];

	return [NSString stringWithFormat:@"%@.%@.%@", fileName, aLanguage, fileExtension];
}

@end