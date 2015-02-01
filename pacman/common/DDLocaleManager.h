//
//  Created by Denis Dorokhov on 31/10/2013.
//  Copyright (c) 2013 Denis Dorokhov. All rights reserved.
//

/** @file */

@class DDLocaleManager;

#define ddl(key, ...) [[DDLocaleManager sharedLocaleManager] string:key, ##__VA_ARGS__]
#define ddlp(file) [[DDLocaleManager sharedLocaleManager] path:file]

/**
* Locale manager delegate.
*/
@protocol DDLocaleManagerDelegate <NSObject>

/**
* This method is called before switching the language.
*/
- (void)localeManager:(DDLocaleManager *)aLocaleManager willChangeLanguageTo:(NSString *)aLanguage;
/**
* This method is called after switching the language.
*/
- (void)localeManagerDidChangeLanguage:(DDLocaleManager *)aLocaleManager;

@end

/**
* Locale manager.
*/
@interface DDLocaleManager : NSObject

/**
* Current language.
*/
@property (nonatomic, readonly) NSString *language;

/**
* Default language.
*
* It will be used as locale manager language next time when loading the application.
*/
@property (nonatomic, readonly) NSString *defaultLanguage;
/**
* System language.
*/
@property (nonatomic, readonly) NSString *systemLanguage;

/**
* Get singleton instance.
*/
+ (DDLocaleManager *)sharedLocaleManager;

/**
* Returns localized string by key and format it using provided arguments.
*/
- (NSString *)string:(NSString *)aKey, ...;

/**
* Returns absolute path for localized file. File argument can be a file path (e.g. when you use folder references in Xcode).
*
* Searches localized file in the following order:
*
* 1) Looks for file of name "<NAME>.<LANGUAGE>.<EXTENSION>" in the main bundle.
*
* 2) If previous step failed, looks for file in current locale bundle.
*
* 3) If previous step failed, looks for file in default application bundle.
*
* 4) If previous step failed, returns the same file argument.
*/
- (NSString *)path:(NSString *)aFile;
/**
* Returns absolute path for localized file starting from custom directory root. It means that search paths will be built
* with this directory as the root of file hierarchy. This method can be useful when the application needs to use
* alternative directory structure in some conditions. For example, a game can download alternative resources to some
* folder and search for locale files inside it.
*
* If file cannot be found using given directory root, locale manager will use a standard localized file search
* algorithm.
*/
- (NSString *)path:(NSString *)aFile root:(NSString *)aRoot;

/**
* Switch current language and make it default it if needed.
*/
- (BOOL)changeLanguage:(NSString *)aLanguage makeDefault:(BOOL)aMakeDefault;

/**
* Add delegate.
*
* Delegate is not retained. You must remove delegate on its deallocation to avoid access to invalid pointer.
*/
- (void)addDelegate:(id <DDLocaleManagerDelegate>)aDelegate;
/**
* Remove delegate.
*/
- (void)removeDelegate:(id <DDLocaleManagerDelegate>)aDelegate;

@end