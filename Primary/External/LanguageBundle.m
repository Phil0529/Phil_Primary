//
//  LanguageBundle.m
//  GOODTV
//
//  Created by liangliang on 13-7-9.
//  Copyright (c) 2013年 Sunniwell. All rights reserved.
//

#import "LanguageBundle.h"

static LanguageBundle *_sharedInstance;

static NSString* const kNotification = @"languageBundelChanged";

@implementation LanguageBundle

+ (LanguageBundle *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[LanguageBundle alloc] init];
    });
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.bundle = [NSBundle mainBundle];
    }
    return self;
}

- (void)setLanguage:(NSString *)language
{
    if ([language isEqualToString:@"zh"]) {
        language = @"zh-Hans";
    }else if ([language isEqualToString:@"zh_hk"]){
        language = @"zh-Hant";
    }
    _language = language;
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj" ];
    self.bundle = [NSBundle bundleWithPath:path];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification object:self];
}

- (NSString *)LBFont
{
    if ([_language hasPrefix:@"zh"]) {
        return @"STHeitiSC-Light";
    }
    return @"Helvetica";
}

- (NSString *)LBFontBold
{
    if ([_language hasPrefix:@"zh"]) {
        return @"STHeitiSC-Medium";
    }
    return @"Helvetica-Bold";
}

- (void)addObserver:(id)target withSelector:(SEL)selector
{
    [[NSNotificationCenter defaultCenter] addObserver:target selector:selector name:kNotification object:self];
}

- (void)removeObserver:(id)target
{
    [[NSNotificationCenter defaultCenter] removeObserver:target name:kNotification object:self];
}

@end
