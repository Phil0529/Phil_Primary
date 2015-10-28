//
//  UserCenter.h
//  EZTV
//
//  Created by Sunni on 15/7/9.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OVCClient.h"
#import "UserInfo.h"
#import "ResponseModel.h"
#import "UserModel.h"
#import "ShakeModel.h"
#import "PicAdListModel.h"
#import "SuperTotalModel.h"
#import "ParticipantModel.h"
#import "ActivityListModel.h"
#import "ActivityDetailModel.h"

extern NSString* const cookieKey;

extern NSString* const keyHeadImg;  //头像
extern NSString* const keyNick;     //昵称
extern NSString* const keyGender;   //性别
extern NSString* const keyPhone;    //联系电话
extern NSString* const keyBirthday; //出生年月



@interface UserCenter : NSObject

@property (nonatomic, strong) UserInfo* currentUser;

/**
 *  单例模式
 *
 *  @return 返回单例实例
 */
+ (UserCenter *)defaultCenter;

/**
 *  根据图像Id获取
 *
 *  @param imgId 图像Id
 *
 *  @return 图像的完整Url
 */
+ (NSString *)getImgUrlByID:(NSString *)imgId;

/**
 *  获取活动图标
 *
 *  @param imgId 图像Id
 *
 *  @return 图像的完整Url
 */
+ (NSString *)getActivityImgUrlById:(NSInteger)activityId;

/**
 *  判断当前是否有用户登录了
 *
 *  @return YES/NO
 */
- (BOOL)isLogined;

/**
 *  清理当前用户登录信息
 */
- (void)expireUserLoginSession;

/**
 *  获取跟用户中心通信的Cookie信息
 *
 *  @return Cookie 字符串
 */
- (NSString *)userCookie;

/**
 *  注册接口
 *
 *  @param mpno       用户id/手机号
 *  @param password   密码
 *  @param nickname   昵称
 *  @param checkCode  短信验证码
 *  @param completion 数据返回block
 *
 *  @return AFHTTPRequestOperation
 */
- (AFHTTPRequestOperation *)registerUserWithUId:(NSString *)uId password:(NSString *)password nickname:(NSString *)nickname checkCode:(NSString *)checkCode completion:(void(^)(ResponseModel *response, NSError *error))completion;

/**
 *  登录接口
 *
 *  @param uid        用户id/手机号
 *  @param password   密码
 *  @param completion 数据返回block
 *
 *  @return AFHTTPRequestOperation
 */
- (AFHTTPRequestOperation *)loginWithUId:(NSString *)uId password:(NSString *)password completion:(void(^)(ResponseModel *response, NSError *error))completion;

typedef NS_ENUM(NSInteger, AuthFromType){
    AuthFrom_QQ = 2,
    AuthFrom_WeiXin = 3,
};

/**
 *  获取第三方登录认证
 *
 *  @param openid     openid
 *  @param nickName   昵称
 *  @param headImgUrl 头像
 *  @param province   省份
 *  @param gender     性别
 *  @param fromAuth   通过哪个第三方登录
 *  @param completion 完成数据回调
 *
 *  @return AFHTTPRequestOperation
 */
- (AFHTTPRequestOperation *)authCheckWithOpenId:(NSString *)openid nickName:(NSString *)nickName headImgUrl:(NSString *)headImgUrl province:(NSString *)province gender:(NSString *)gender fromAuth:(AuthFromType)fromAuth completion:(void(^)(ResponseModel *response, NSError *error))completion;

/**
 *  登出接口
 *
 *  @param completion 数据返回block
 *
 *  @return AFHTTPRequestOperation
 */
- (AFHTTPRequestOperation *)logoutWithCompletion:(void(^)(ResponseModel *response, NSError *error))completion;

/**
 *  获取用户详细信息
 *
 *  @param completion 数据返回block
 *
 *  @return AFHTTPRequestOperation
 */
- (AFHTTPRequestOperation *)pullUserInfo:(void(^)(UserModel* user, NSError *error))completion;

/**
 *  设置用户信息
 *
 *  @param key        用户字段的key,valKeyGender,valKeyNick,valKeyHeadImg
 *  @param value      用户字段的值
 *  @param completion 数据返回
 *
 *  @return AFHTTPRequestOperation
 */
- (AFHTTPRequestOperation *)setUserInfoWithKey:(NSString *)key value:(NSString *)value completion:(void(^)(ResponseModel *response, NSError *error))completion;

/**
 *  设置用户信息通用
 *
 *  @param params     用户信息字典
 *  @param completion 数据返回
 *
 *  @return AFHTTPRequestOperation
 */
- (AFHTTPRequestOperation *)setUserInfoWithDic:(NSDictionary *)params completion:(void(^)(ResponseModel *response, NSError *error))completion;

/**
 *  修改用户密码
 *
 *  @param oldPassword 旧密码
 *  @param newPassword 新密码
 *  @param completion  数据返回
 *
 *  @return AFHTTPRequestOperation
 */
- (AFHTTPRequestOperation *)changePassword:(NSString *)oldPassword newPassword:(NSString *)newPassword completion:(void(^)(ResponseModel *response, NSError *error))completion;

/**
 *  找回密码接口
 *
 *  @param mpno       手机号
 *  @param password   新密码
 *  @param checkCode  短信验证码
 *  @param completion  数据返回
 *
 *  @return AFHTTPRequestOperation
 */
- (AFHTTPRequestOperation *)findPasswordWithMpno:(NSString *)mpno password:(NSString *)password checkCode:(NSString *)checkCode completion:(void(^)(ResponseModel *response, NSError *error))completion;

/**
 *  获取摇得宝首页广告图片列表
 *
 *  @param completion  数据返回
 *
 *  @return AFHTTPRequestOperation
 */
- (AFHTTPRequestOperation *)getAdPicListWithCompletion:(void(^)(PicAdListModel* adList, NSError *error))completion;

/**
 *  获取活动列表
 *
 *  @param pageIndex  页标
 *  @param pageSize   每页尺寸
 *  @param completion  数据返回
 *
 *  @return AFHTTPRequestOperation
 */
- (AFHTTPRequestOperation *)getActivityListWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize completion:(void(^)(ActivityListModel* activityList, NSError *error))completion;

/**
 *  获取活动的详细
 *
 *  @param activityId 活动Id
 *  @param completion 数据返回
 *
 *  @return AFHTTPRequestOperation
 */
- (AFHTTPRequestOperation *)getActivityDetailWithId:(NSInteger)activityId completion:(void(^)(ActivityDetailModel* activityDetail, NSError *error))completion;

/**
 *  获取上/下相邻活动的信息
 *
 *  @param activityId 当前活动Id
 *  @param kind       0向前 1往后
 *  @param completion 数据返回
 *
 *  @return AFHTTPRequestOperation
 */
- (AFHTTPRequestOperation *)getNextActivityDetailWithId:(NSInteger)activityId kind:(NSInteger)kind completion:(void(^)(ActivityDetailModel* activityDetail, NSError *error))completion;

/**
 *  摇得宝首页数据获取接口
 *
 *  @param tvId       节目Id
 *  @param completion  数据返回
 *
 *  @return AFHTTPRequestOperation
 */
- (AFHTTPRequestOperation *)getSuperTotalWithTvId:(NSInteger)tvId completion:(void(^)(SuperTotalModel* totalInfo, NSError *error))completion;

/**
 *  获取活动参与总人数与获奖人数
 *
 *  @param tvId       节目Id
 *  @param completion  数据返回
 *
 *  @return AFHTTPRequestOperation
 */
- (AFHTTPRequestOperation *)getParticipantWithTvId:(NSInteger)tvId completion:(void(^)(ParticipantModel* participantInfo, NSError *error))completion;

/**
 *  摇一摇
 *
 *  @param tvId       节目Id
 *  @param completion  数据返回
 *
 *  @return AFHTTPRequestOperation
 */
- (AFHTTPRequestOperation *)shakeRequestWithTvId:(NSInteger)tvId completion:(void(^)(ShakeModel* shakeInfo, NSError *error))completion;

@end
