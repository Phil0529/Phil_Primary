//
//  Macros.h
//  iPhone
//
//

#define APP_BUILDVER [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define APP_VERSION  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define IOS_VERSION [NSString stringWithFormat:@"iOS %.2f",[[[UIDevice currentDevice] systemVersion] floatValue]]

//应用程序审核版本号
#define VER_KEY @"ver"
#define REVIEW_VER @"1509201000"
//项目标识号
#define PROJECT_KEY @"project"
#define PROJECT_ID  @"hainan"
//ios系统版本号
#define OS_KEY  @"os"
#define OS_VERSION  @"2" // 2 = ios

//服务器版本
//#define RELEASE_VER
//#define TESTENV
#define DEVENV

#ifdef RELEASE_VER
#define SWLOG 0
#define CMSServerString     @"hainan.cms.joygo.com/v1.3"
#define CMSBaseURLString    [NSString stringWithFormat:@"http://%@/api／", CMSServerString]
#define RongCloud_KEY       @"6tnym1brns7w7"                    //rongyun jkey
#define UserBaseURLString   @"http://user.joygo.com/hainan/"
#define APPSBaseURLString   @"http://hainan.chat.joygo.com/"
#define OISBaseURLSTring    @"http://hainan.micro.joygo.com:5000"
#define OIS_UID             @"sunniwell"
#define OIS_TID             @"tid001"
#define OIS_TOKEN           @"guoziyun"
#define OIS_PLAYFORMAT      [OISBaseURLSTring stringByAppendingString:@"/%@.m3u8?protocal=hls&user=%@&tid=%@&sid=%@&type=5&token=%@"]
#define localCfgMap  \
[[NSMutableDictionary alloc] initWithObjectsAndKeys:\
@"http://yf.joygo.com:8081/m/home/indexcoin", cfgKeyshopright,\
@"http://yf.joygo.com:8081/MShop/sc/ci?flag=appcart", cfgKeyshopcart,\
@"http://yf.joygo.com:8081/MShop/u/Orders?flag=appcart", cfgkeymyorder,\
@"http://fuzhou.cms.joygo.com/html5/page/discount/discount.html", cfgKeydiscount,\
@"http://fuzhou.cms.joygo.com/html5/page/coin/my_coin.html", cfgKeymycoin,\
@"http://fuzhou.cms.joygo.com/html5/page/coin/coin_desc.html", cfgKeycoindesc,\
@"http://fuzhou.cms.joygo.com/html5/page/feedback/feedback.html", cfgKeyfeedback,\
@"http://fuzhou.cms.joygo.com/html5/agreement.html", cfgkeyagreement,\
@"http://fuzhou.cms.joygo.com/html5/page/about/about.html", cfgKeyabout,\
@"10000", cfgKeylive,\
@"http://fuzhou.cms.joygo.com/html5/page/coin/my_coin_discoin.html", cfgkeywelfare,\
@"http://fuzhou.cms.joygo.com/html5/page/about/about_code.html", cfgkeyqrcode,\
@"http://fuzhou.app.joygo.com/touch/", cfgkeyslink,\
@"福视悦动", cfgkeystitle,\
@"上福视悦动，做有福之人", cfgkeyscontent,\
@"http://fuzhou.cms.joygo.com/html5/page/about/img/logo.png", cfgkeysicon,\
@"http://fuzhou.cms.joygo.com/html5/page/anchor/my_answer_nohead.html", cfgkeymyqna,\
@"http://fuzhou.cms.joygo.com/html5/page/vod/VODabout.html", cfgkeylivedesc, \
@"http://fuzhou.cms.joygo.com/html5/page/vod/my_vod.html", cfgkeymylive,\
@"http://fuzhou.cms.joygo.com/html5/page/feedback/myback.html", cfgKeymyfeedback,\
@"http://fuzhou.cms.joygo.com/html5/page/vod/share.html", cfgkeyliveshare ,\
@"http://fuzhou.cms.joygo-dev.com/html5/page/news/broadcast_share.html",cfgkeyradioshare,nil]
#endif

#ifdef TESTENV
#define SWLOG 4
#define CMSServerString     @"hainantest.cms.joygo-dev.com/v1.3"
#define CMSBaseURLString    [NSString stringWithFormat:@"http://%@/api/", CMSServerString]
#define RongCloud_KEY       @"c9kqb3rdkhwnj"
#define UserBaseURLString   @"http://user.test.joygo-dev.com/test/"
#define APPSBaseURLString   @"http://test.chat.joygo-dev.com/"
#define OISBaseURLSTring    @"http://dev.micro.joygo-dev.com:5000"
#define OIS_UID             @"sunniwell"
#define OIS_TID             @"tid001"
#define OIS_TOKEN           @"guoziyun"
#define OIS_PLAYFORMAT      [OISBaseURLSTring stringByAppendingString:@"/%@.m3u8?protocal=hls&user=%@&tid=%@&sid=%@&type=5&token=%@"]
#define localCfgMap  \
[[NSMutableDictionary alloc] initWithObjectsAndKeys:\
@"http://121.41.13.117:8001/m/home/indexcoin", cfgKeyshopright,\
@"http://121.41.13.117:8001/MShop/sc/ci?flag=appcart", cfgKeyshopcart,\
@"http://121.41.13.117:8001/MShop/u/Orders?flag=appcart", cfgkeymyorder,\
@"http://hainantest.cms.joygo-dev.com/html5/page/discount/discount.html", cfgKeydiscount,\
@"http://hainantest.cms.joygo-dev.com/html5/page/coin/my_coin.html", cfgKeymycoin,\
@"http://fuzhoutest.cms.joygo-dev.com/html5/page/coin/coin_desc.html", cfgKeycoindesc,\
@"http://fuzhoutest.cms.joygo-dev.com/html5/page/feedback/feedback.html", cfgKeyfeedback,\
@"http://fuzhoutest.cms.joygo-dev.com/html5/page/feedback/myfeedback.html", cfgKeymyfeedback,\
@"http://fuzhoutest.cms.joygo-dev.com/html5/page/about/about.html", cfgKeyabout,\
@"http://fuzhoutest.cms.joygo-dev.com/html5/agreement.html", cfgkeyagreement,\
@"10000", cfgKeylive,\
@"http://fuzhoutest.cms.joygo-dev.com/html5/page/coin/my_coin_discoin.html", cfgkeywelfare,\
@"http://fuzhoutest.cms.joygo-dev.com/html5/page/about/about_code.html", cfgkeyqrcode,\
@"http://fuzhoutest.cms.joygo-dev.com/html5/page/anchor/my_answer.html", cfgkeymyqna,\
@"福视悦动", cfgkeystitle,\
@"上福视悦动，做有福之人", cfgkeyscontent,\
@"http://fuzhou.app.joygo.com/touch/", cfgkeyslink,\
@"http://fuzhoutest.cms.joygo-dev.com/html5/page/about/img/logo.png", cfgkeysicon,\
@"http://fuzhoutest.cms.joygo-dev.com/html5/page/vod/VODabout.html", cfgkeylivedesc,\
@"http://fuzhoutest.cms.joygo-dev.com/html5/page/vod/my_vod.html", cfgkeymylive,\
@"http://fuzhoutest.cms.joygo-dev.com/html5/page/vod/share.html", cfgkeyliveshare,\
@"http://fuzhou.cms.joygo-dev.com/html5/page/news/broadcast_share.html",cfgkeyradioshare,nil]
#endif

#ifdef DEVENV
#define SWLOG 4
#define CMSServerString     @"fuzhou.cms.joygo-dev.com/v1.3"
#define CMSBaseURLString    [NSString stringWithFormat:@"http://%@/api/", CMSServerString]
#define RongCloud_KEY       @"c9kqb3rdkhwnj"
#define UserBaseURLString   @"http://user.dev.joygo-dev.com/dev/"
#define APPSBaseURLString   @"http://dev.chat.joygo-dev.com/"
#define OISBaseURLSTring    @"http://121.40.230.231:5000"
#define OIS_UID             @"sunniwell"
#define OIS_TID             @"tid001"
#define OIS_TOKEN           @"guoziyun"
#define OIS_PLAYFORMAT      [OISBaseURLSTring stringByAppendingString:@"/%@.m3u8?protocal=hls&user=%@&tid=%@&sid=%@&type=5&token=%@"]
#define localCfgMap  \
[[NSMutableDictionary alloc] initWithObjectsAndKeys:\
@"http://dev.shop.joygo-dev.com/m/home/indexcoin", cfgKeyshopright,\
@"http://dev.shop.joygo-dev.com/MShop/sc/ci?flag=appcart", cfgKeyshopcart,\
@"http://dev.shop.joygo-dev.com/MShop/u/Orders?flag=appcart", cfgkeymyorder,\
@"http://fuzhou.cms.joygo-dev.com/html5/page/discount/discount.html", cfgKeydiscount,\
@"http://fuzhou.cms.joygo-dev.com/html5/page/coin/my_coin.html", cfgKeymycoin,\
@"http://fuzhou.cms.joygo-dev.com/html5/page/coin/coin_desc.html", cfgKeycoindesc,\
@"http://fuzhou.cms.joygo-dev.com/html5/page/feedback/feedback.html", cfgKeyfeedback,\
@"http://fuzhou.cms.joygo-dev.com/html5/page/feedback/myfeedback.html", cfgKeymyfeedback,\
@"http://fuzhou.cms.joygo-dev.com/html5/page/about/about.html", cfgKeyabout,\
@"http://fuzhou.cms.joygo-dev.com/html5/agreement.html", cfgkeyagreement,\
@"10000", cfgKeylive,\
@"http://fuzhou.cms.joygo-dev.com/html5/page/coin/my_coin_discoin.html", cfgkeywelfare,\
@"http://fuzhou.cms.joygo-dev.com/html5/page/about/about_code.html", cfgkeyqrcode,\
@"http://fuzhou.cms.joygo-dev.com/html5/page/anchor/my_answer.html", cfgkeymyqna,\
@"福视悦动", cfgkeystitle,\
@"上福视锐动，做有福之人", cfgkeyscontent,\
@"http://fuzhou.cms.joygo-dev.com/touch/", cfgkeyslink,\
@"http://fuzhou.cms.joygo-dev.com/html5/page/about/img/logo.png", cfgkeysicon,\
@"http://fuzhou.cms.joygo-dev.com/html5/page/vod/VODabout.html", cfgkeylivedesc,\
@"http://fuzhou.cms.joygo-dev.com/html5/page/vod/my_vod.html", cfgkeymylive,\
@"http://fuzhou.cms.joygo-dev.com/html5/page/vod/share.html", cfgkeyliveshare, \
@"http://fuzhou.cms.joygo-dev.com/html5/page/upload/uploadagreement.html", cfgkeyuploadagreement, \
@"http://fuzhou.cms.joygo-dev.com/html5/page/news/broadcast_share.html",cfgkeyradioshare,\
nil]
#endif

#define UMENG_APPKEY @"55d0b23a67e58ec12c000e16"
#define SMS_KEY @"9a9288e4505b"
#define SMS_SECRET @"41f4d2f3dcfb6ef3855b9d2db4374eee"

#define QQ_KEY @"1104740207"
#define QQ_SECRET @"rpBzdBX7KLpvWuYf"
#define WeiXin_KEY @"wxee9c402442cf7884"
#define WeiXin_SECRET @"97babf6dbc5fcc14135c2efdeb73d461"

#define kDeviceToken @"deviceTokenk"
#define kLaunchImgUrl @"dlaunchImgUrl"
#define kWeiXinLoginResponeNotification @"kWeiXinLoginResponeNotification"

//常量定义
#define NAVBTN_WIDTH 26.5f
#define NAVBTN_HEIGHT 44.f

#define padding 20
#define itemPerLine 4
#define kItemW (SCREEN_WIDTH-padding*(itemPerLine+1))/itemPerLine
#define kItemH 25

typedef enum{
    topViewClick = 0,
    FromTopToTop = 1,
    FromTopToTopLast = 2,
    FromTopToBottomHead = 3,
    FromBottomToTopLast = 4
} animateType;

#define baseTag 1000

#define pageLoadSize 25

#define	cfgKeyshopright	@"shopright"
#define	cfgKeyshopcart	@"shopcart"
#define	cfgKeydiscount	@"discount"
#define	cfgKeymycoin	@"mycoin"
#define	cfgKeycoindesc	@"coindesc"
#define	cfgKeyfeedback	@"feedback"
#define	cfgKeymyfeedback @"myfeedback"
#define	cfgKeyabout		@"about"
#define	cfgKeylive		@"live"
#define cfgkeyagreement @"agreement"
#define cfgkeymyorder   @"myorder"
#define cfgkeywelfare   @"welfare"
#define cfgkeyqrcode    @"qrcode"
#define cfgkeymyqna     @"myqna"
#define cfgkeystitle    @"sharetitle"
#define cfgkeyscontent  @"sharecontent"
#define cfgkeyslink     @"sharelink"
#define cfgkeysicon     @"shareicon"
#define cfgkeylivedesc  @"vodabout"
#define cfgkeymylive    @"myvod"
#define cfgkeyliveshare @"vodshare"
#define cfgkeyuploadagreement   @"uploadagreement"
#define cfgkeyradioshare @"radioshare"

#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define _IPHONE80_ 80000

//判断系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

//语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//判断设备
#define IS_SCREEN_55_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_47_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_4_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_35_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

//转换成浮点数
#define OBJ2FLOAT(v, s)  (s = (v == nil || v == [NSNull null]) ? 0.0 : [v doubleValue])
//转换成整型
#define OBJ2INT(v, s)  (s = (v == nil || v == [NSNull null]) ? 0 : [v integerValue])
//转换成字符串
#define OBJ2STR(v, s)  (s = (v == nil || v == [NSNull null]) ? @"" :v)
//消除nil字符串
#define NONNILSTR(v)    (v = (v == nil || v == [NSNull null]) ? @"" : v)
//消除nil的Nsnumber
#define NONNILNSNUMBER(v)   (v = (v == nil || v == [NSNull null]) ? [NSNumber numberWithInt:0] : v)

//测试数组
#define OBJArray(v,s) (s = (v == nil || v == [NSNull null]) ? @[] :v)
//测试字典
#define OBJDictionary(v,s) (s = (v == nil || v == [NSNull null]) ? @{} :v)

//判断是否为空字符串
#define ISEMPTYSTR(str)   (str == nil || [str isEqualToString:@""])

//界面宽高
#define STATUSBAR_HEIGHT ((IS_OS_7_OR_LATER)? 20.f : 0.f)
#define NAVBAR_HEIGHT  44.0f
#define TABBAR_HEIGHT  49.0f

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//将size放大/缩小n倍
#define SIZE_SCALE(size,n) (CGSizeMake(size.width*n, size.height*n))

#define SAFE_RELEASE(x) [x release];x=nil  //release

//数组越界判定
#define ISINDEXINRANGE(idx,arr)\
(idx >=0 && idx < arr.count)

//手机号码校验

//检测是否是手机号码
/**
 * 手机号码
 * 移动：134,135,136,137,138,139,147,150,151,152,157,158,159,178,182,183,187,188,//移动
 * 联通：130,131,132,155,156,185,186,145,176,//联通
 * 电信：133,153,170,177,180,181,189,//电信
 */

//    130,131,132,133,134,135,136,137,138,139
//    145,147,
//    150,151,152,153,155,156,157,158,159,
//    170,176,177,178,
//    180,181,182,183,185,186,187,188,189,
#define ISPHONENUM(str)\
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^1(3[0-9]|4[57]|5[0-35-9]|7[06-8]|8[0-35-9])\\d{8}$"] evaluateWithObject:str]



#define kStatusHeight 20
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBColorAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]



//颜色

#define FOREGROUND_COLOR \
[UIColor colorWithRed:0.0/255.0 green:170.0/255.0 blue:238.0/255.0 alpha:1.0]

#define BACKGROUND_COLOR \
[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0]

#define RGBCOLOR(r,g,b) \
[UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]

#define RGBACOLOR(r,g,b,a) \
[UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define COLORFORRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0f]

#define COLORFORRGBa(rgbaValue) \
[UIColor colorWithRed:((float)((rgbaValue & 0xFF000000) >> 24))/255.0 \
green:((float)((rgbaValue & 0xFF0000) >> 16))/255.0 \
blue:((float)((rgbaValue & 0xFF00) >> 8))/255.0 \
alpha:((float)(rgbaValue & 0xFF))/255.0]

//微软雅黑字体定义
//#define FONT_MSYH(F) [UIFont fontWithName:@"MicrosoftYaHei" size:F]
//方正黑体简体字体定义
//#define FONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]

#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

#define USER_DEFAULT [NSUserDefaults standardUserDefaults] //user Default

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
//例如 imageView.image =  LOADIMAGE(@"文件名",@"png");

//定义UIImage对象
#define IMAGE(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

// degrees/radian functions
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

//viewWithTag
#define VIEWWITHTAG(_OBJECT, _TAG) [_OBJECT viewWithTag:_TAG]

//
#define ITTAssert(condition, ...)   \
do {    \
if (!(condition)) { \
[[NSAssertionHandler currentHandler]    \
handleFailureInFunction:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
file:[NSString stringWithUTF8String:__FILE__]   \
lineNumber:__LINE__ \
description:__VA_ARGS__];   \
}   \
} while(0)

#ifdef SWLOG
#define SWLog(l, s) NSLog(@"SWlogInfo %@(%d%s) \n%@", l, __LINE__, __func__, (s))

#if SWLOG == 4
#define SWLogV(f, s...) SWLog(@"LOGV:", ([NSString stringWithFormat:f, ##s]))
#define SWLogD(f, s...) SWLog(@"LOGD:", ([NSString stringWithFormat:f, ##s]))
#define SWLogE(f, s...) SWLog(@"LOGE:", ([NSString stringWithFormat:f, ##s]))
#define SWLogW(f, s...) SWLog(@"LOGW:", ([NSString stringWithFormat:f, ##s]))
#endif

#if SWLOG == 3
#define SWLogV(f, s...)
#define SWLogD(f, s...) SWLog(@"LOGD:", ([NSString stringWithFormat:f, ##s]))
#define SWLogE(f, s...) SWLog(@"LOGE:", ([NSString stringWithFormat:f, ##s]))
#define SWLogW(f, s...) SWLog(@"LOGW:", ([NSString stringWithFormat:f, ##s]))
#endif

#if SWLOG == 2
#define SWLogV(f, s...)
#define SWLogD(f, s...)
#define SWLogE(f, s...) SWLog(@"LOGE:", ([NSString stringWithFormat:f, ##s]))
#define SWLogW(f, s...) SWLog(@"LOGW:", ([NSString stringWithFormat:f, ##s]))
#endif

#if SWLOG == 1
#define SWLogV(f, s...)
#define SWLogD(f, s...)
#define SWLogE(f, s...)
#define SWLogW(f, s...) SWLog(@"LOGW:", ([NSString stringWithFormat:f, ##s]))
#endif

#if SWLOG == 0
#define SWLogV(f, s...)
#define SWLogD(f, s...)
#define SWLogE(f, s...)
#define SWLogW(f, s...)
#endif



#define ZFONT 0

//系统字体MicrosoftYaHei
#if ZFONT == 0
#define FONT(F) [UIFont fontWithName:@"PingFang SC" size:F]
#endif

//方正黑体简体字体定义
#if ZFONT == 1
//#define FONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]
#endif

//微软雅黑
#if ZFONT == 2
//#define FONT(F) [UIFont fontWithName:@"MicrosoftYaHei" size:F]
#endif


#endif


