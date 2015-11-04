//
//  LanguageBundle.h
//  GOODTV
//
//  Created by liangliang on 13-7-9.
//  Copyright (c) 2013年 Sunniwell. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 Languages: (
 en,
 fr,
 de,
 ja,
 nl,
 it,
 es,
 pt,
 "pt-PT",
 da,
 fi,
 nb,
 sv,
 ko,
 "zh-Hans",
 "zh-Hant",
 ru,
 pl,
 tr,
 uk,
 ar,
 hr,
 cs,
 el,
 he,
 ro,
 sk,
 th,
 id,
 ms,
 "en-GB",
 ca,
 hu,
 vi
 )
 */

#define LBLocalized(key) \
      NSLocalizedStringFromTableInBundle(key, @"Localizable", [LanguageBundle sharedInstance].bundle, nil)

#define LocalFont \
    [LanguageBundle sharedInstance].LBFont

#define LocalFontBold \
[LanguageBundle sharedInstance].LBFontBold

@interface LanguageBundle : NSObject

@property (nonatomic, retain) NSBundle *bundle;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong, readonly) NSString *LBFont;
@property (nonatomic, strong, readonly) NSString *LBFontBold;

+ (LanguageBundle *)sharedInstance;
- (void)addObserver:(id)target withSelector:(SEL)selector;
- (void)removeObserver:(id)target;

@end
