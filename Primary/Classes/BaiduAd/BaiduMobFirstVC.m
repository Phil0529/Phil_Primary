//
//  BaiduMobFirstVC.m
//  Primary
//
//  Created by Phil Xhc on 15/10/29.
//  Copyright © 2015年 Xhc. All rights reserved.
//

#import "BaiduMobFirstVC.h"
#import "BaiduMobAdView.h"
#define kAdViewPortraitRect CGRectMake(0, SCREEN_HEIGHT - 100.f, SCREEN_WIDTH, 100.f)

@interface BaiduMobFirstVC ()<BaiduMobAdViewDelegate>

@end

@implementation BaiduMobFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self philInitPageBMFVC];
}
- (void)philInitPageBMFVC{
    [self.view setBackgroundColor:BACKGROUND_COLOR];
//    NAVBAR_HEIGHT
//    STATUSBAR_HEIGHT
//    SCREEN_HEIGHT
    
    BaiduMobAdView *sharedAdView	=	[[BaiduMobAdView	alloc]	init];
    //把在mssp.baidu.com上创建后获得的⼲告位id写到这⾥
    sharedAdView.AdUnitTag	=	@"2078466";
    sharedAdView.AdType	=	BaiduMobAdViewTypeBanner;
    sharedAdView.frame	=	kAdViewPortraitRect;
    sharedAdView.delegate	=	self;
    [self.view	addSubview:sharedAdView];
    [sharedAdView	start];
}

#pragma mark BaiduMobAdViewDelegate

-(void)	willDisplayAd:(BaiduMobAdView*)	adview
{
    NSLog(@"delegate:	will	display	ad");
}
- (NSString	*)publisherId
{
    return @"fffe32a4";	//@"your_own_app_id";
}
-(BOOL)enableLocation
{
    //启⽤location会有⼀次alert提⽰,请根据系统进⾏相关配置
    return	NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
