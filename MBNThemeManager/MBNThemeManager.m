//
//  MBNThemeManager.m
//  ChimeSquirrel
//
//  Created by Luke Jernejcic on 4/25/13.
//  Copyright (c) 2013 Luke Jernejcic. All rights reserved.
//

#import "MBNThemeManager.h"

static NSString * const kUserDefaultsThemeName = @"MBNThemeManagerKeyThemeName";
static NSString * const kUserDefaultsThemeDirectory = @"MBNThemeManagerKeyThemeDirectory";
static NSString * const kThemeStyleChangedNotification = @"MBNThemeManagerStyleChangedNotification";

@implementation MBNThemeManager

@synthesize styles = _styles;

+ (MBNThemeManager *)sharedManager
{
    static MBNThemeManager *sharedManager = nil;
    if (sharedManager == nil)
    {
        sharedManager = [[MBNThemeManager alloc] init];
    }
    return sharedManager;
}

- (id)init
{
    if ((self = [super init]))
    {
        [self reloadTheme];
    }
    return self;
}

- (void)reloadTheme
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *themeName = [defaults objectForKey:kUserDefaultsThemeName] ?: @"theme";
    NSString *themeDirectory = [defaults objectForKey:kUserDefaultsThemeDirectory] ?: nil;

    [self reloadThemeWithName:themeName inDirectory:themeDirectory];
}

- (void)reloadThemeWithName:(NSString *)themeName inDirectory:(NSString *)themeDirectory
{
    NSString *path = [[NSBundle mainBundle] pathForResource:themeName ofType:@"plist" inDirectory:themeDirectory];
    _styles = [NSDictionary dictionaryWithContentsOfFile:path];
}

+ (void)setThemeWithDirectory:(NSString *)directory
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:directory forKey:kUserDefaultsThemeDirectory];
}

- (UIImage *)themeImageNamed:(NSString *)key
{
    NSString *imageName = [self.styles objectForKey:key];
    
    return [UIImage imageNamed:imageName];
}

- (UIColor *)themeColorNamed:(NSString *)key
{
    NSString *hexColor = [self.styles objectForKey:key];
    
    return [MBNThemeManager colorWithRgbaHexString:hexColor];
}

+ (UIColor *)colorWithRgbaHexValue:(uint)hexValue {
    return [UIColor
            colorWithRed:((float)((hexValue & 0xFF000000) >> 24))/255.0
            green:((float)((hexValue & 0xFF0000) >>16))/255.0
            blue:((float)(hexValue & 0xFF00 >> 8))/255.0
            alpha:((float)(hexValue & 0xFF))/255.0];
}


+ (UIColor*)colorWithRgbaHexString:(NSString*)hexString {
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#"
                                                     withString:@"0x"];
    
    uint hexValue;
    if ([[NSScanner scannerWithString:hexString] scanHexInt:&hexValue]) {
        return [self colorWithRgbaHexValue:hexValue];
    } else {
        return nil;
    }
}

@end
