//
//  MBNThemeManager.h
//  ChimeSquirrel
//
//  Created by Luke Jernejcic on 4/25/13.
//  Copyright (c) 2013 Luke Jernejcic. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kUserDefaultsThemeName;
static NSString * const kUserDefaultsThemeDirectory;
static NSString * const kThemeStyleChangedNotification;

@interface MBNThemeManager : NSObject

@property (strong, readonly) NSDictionary *styles;

/**
 * Singleton of the MBNThemeManager.
 *
 * This is the recommended way to manage your theme, but you
 * can allocate individual instances pulling in different themes.
 */
+ (MBNThemeManager *)sharedManager;
+ (void)setThemeWithDirectory:(NSString *)directory;

/**
 * Reloads the theme styles according the settings in NSUserDefaults.
 *
 * If the defaults have not been setup, it will for for the plist
 * file with the name "theme" without any directory.
 */
- (void)reloadTheme;

/**
 * Reloads the theme styles using the given values.
 *
 * These values will not update the NSUserDefaults used by the
 * singlton object.
 */
- (void)reloadThemeWithName:(NSString *)themeName inDirectory:(NSString *)themeDirectory;
- (UIImage *)themeImageNamed:(NSString *)key;
- (UIColor *)themeColorNamed:(NSString *)key;

/**
 * Expects 8 character RGBA value.
 * 
 * Returns nil if color can't be made.
 */
+ (UIColor *)colorWithRgbaHexValue:(uint)hexValue;

/**
 * Accepts RGBA hex strings with '#', '0x', or '' prefixes.
 *
 * Returns nil if color can't be made.
 */
+ (UIColor *)colorWithRgbaHexString:(NSString*)hexString;

@end
