//
//  BaiduMobSecondVC.m
//  Primary
//
//  Created by Phil Xhc on 15/10/29.
//  Copyright © 2015年 Xhc. All rights reserved.
//

#import "BaiduMobSecondVC.h"
#import "BaiduMobAdInterstitial.h"
@interface BaiduMobSecondVC ()<BaiduMobAdInterstitialDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) BaiduMobAdInterstitial *interstitialView;
@end

@implementation BaiduMobSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BACKGROUND_COLOR];
    [self philInitUIBMSVC];
    
}

- (void)philInitUIBMSVC{
    UIButton *btnLoad = [UIButton buttonWithType:0];
    btnLoad.frame = CGRectMake(50.f, 200.f, 100.f, 40.f);
    [btnLoad addTarget:self action:@selector(loadTableScreen:) forControlEvents:1<<6];
    [btnLoad setTitle:@"加载插屏广告" forState:0];
    [btnLoad setTitleColor:[UIColor redColor] forState:0];
    [self.view addSubview:btnLoad];
    
    UIButton *btnShow = [UIButton buttonWithType:0];
    btnShow.frame = CGRectMake(200.f, 200.f, 100.f, 40.f);
    [btnShow addTarget:self action:@selector(showableScreen:) forControlEvents:1<<6];
    [btnShow setTitle:@"展示插屏广告" forState:0];
    [btnShow setTitleColor:[UIColor redColor] forState:0];
    [self.view addSubview:btnShow];

}

- (void)loadTableScreen:(UIButton *)btn{
    
    self.interstitialView =	[[BaiduMobAdInterstitial alloc]	init];
    self.interstitialView.delegate	= self;
    //把在mssp.baidu.com上创建后获得的⼲告位id写到这⾥
    self.interstitialView.AdUnitTag	=	@"2078466";
    self.interstitialView.interstitialType	=	BaiduMobAdViewTypeInterstitialOther;
    //	 加载全屏插屏.	 每次仅加载⼀个⼲告的物料,若需多次使⽤请在下次展⽰前
//    重新执⾏load⽅法
    [self.interstitialView	load];
    
}

- (void)showableScreen:(UIButton *)btn{
    if (self.interstitialView.isReady){
        [self.interstitialView presentFromRootViewController:self];
    }
    else{
        NSLog(@"not ready!");
    }
}


- (NSString *)publisherId
{
    return	@"fffe32a4";	//@"your_own_app_id";
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.interstitialView.delegate = nil;
    self.interstitialView = nil;
}



/**
 *  广告预加载成功
 */
- (void)interstitialSuccessToLoadAd:(BaiduMobAdInterstitial *)interstitial
{
    NSLog(@"interstitialSuccessToLoadAd");
    UIAlertView*alv = [[UIAlertView alloc]initWithTitle:@"加载成功" message:@"可以点击显示插屏了" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
    [alv show];
}

/**
 *  广告预加载失败
 */
- (void)interstitialFailToLoadAd:(BaiduMobAdInterstitial *)interstitial
{
    NSLog(@"interstitialFailToLoadAd");
    UIAlertView*alv = [[UIAlertView alloc]initWithTitle:@"加载失败" message:@"请重新点击加载插屏" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
    [alv show];
}

/**
 *  广告即将展示
 */
- (void)interstitialWillPresentScreen:(BaiduMobAdInterstitial *)interstitial
{
    NSLog(@"interstitialWillPresentScreen");
}

/**
 *  广告展示成功
 */
- (void)interstitialSuccessPresentScreen:(BaiduMobAdInterstitial *)interstitial
{
    NSLog(@"interstitialSuccessPresentScreen");
}

/**
 *  广告展示失败
 */
- (void)interstitialFailPresentScreen:(BaiduMobAdInterstitial *)interstitial withError:(BaiduMobFailReason) reason
{
    NSLog(@"interstitialFailPresentScreen, withError: %d",reason);
}

/**
 *  广告展示结束
 */
- (void)interstitialDidDismissScreen:(BaiduMobAdInterstitial *)interstitial
{
    NSLog(@"interstitialDidDismissScreen");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
