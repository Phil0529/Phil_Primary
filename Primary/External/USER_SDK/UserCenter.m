//
//  UserCenter.m
//  EZTV
//
//  Created by Sunni on 15/7/9.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "UserCenter.h"
#import "TMCache.h"
#import "UMessage.h"

NSString* const cookieKey = @"Cookie";

NSString* const keyHeadImg = @"img";
NSString* const keyNick = @"nickname";
NSString* const keyGender = @"gender";
NSString* const keyPhone = @"phone";
NSString* const keyBirthday = @"birthday";

static NSString* dataKey = @"usercookies1.data";
static OVCClient *_APIClient;

@implementation UserCenter

@synthesize currentUser = _currentUser;

+ (UserCenter *)defaultCenter
{
    static UserCenter *_sharedCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedCenter = [[UserCenter alloc] init];
        _APIClient = [OVCClient clientWithBaseURL:[NSURL URLWithString:UserBaseURLString] account:nil];
        NSSet *newContentTypes = [_APIClient.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        [_APIClient.responseSerializer setAcceptableContentTypes:newContentTypes];
        [_APIClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
    });
    return _sharedCenter;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _currentUser = [[TMCache sharedCache] objectForKey:dataKey];
    }
    return self;
}

+ (NSString *)getImgUrlByID:(NSString *)imgId
{
    return [NSString stringWithFormat:@"%@user/headimg?img=%@", UserBaseURLString, imgId];
}

+ (NSString *)getActivityImgUrlById:(NSInteger)activityId
{    
    return [NSString stringWithFormat:@"%@activity/activityimg?activityid=%ld&utc=%f", UserBaseURLString, (long)activityId, [[NSDate date] timeIntervalSince1970]];
}

- (BOOL)isLogined
{
    return !ISEMPTYSTR([self userCookie]);
}

- (void)expireUserLoginSession
{
    if (!ISEMPTYSTR(_currentUser.mpno)) {
        [UMessage removeAlias:_currentUser.mpno type:kUMessageAliasTypeQQ response:nil];
    }
    _currentUser = nil;
    [[TMCache sharedCache] removeObjectForKey:dataKey];
}

- (NSString *)userCookie
{
    return _currentUser.userCookie;
}

- (void)saveUserInfo
{
    [[TMCache sharedCache] setObject:_currentUser forKey:dataKey block:nil];
}

- (AFHTTPRequestOperation *)registerUserWithUId:(NSString *)uId password:(NSString *)password nickname:(NSString *)nickname checkCode:(NSString *)checkCode completion:(void (^)(ResponseModel *, NSError *))completion
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken];
    if (ISEMPTYSTR(token)) {
        token = @"";
    }
    NSDictionary *params = @{@"mpno": uId,
                             @"password": password,
                             @"nickname": nickname,
                             @"checkcode": checkCode,
                             @"channel": @"AppStore",
                             @"token": token,
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    return [_APIClient POST:@"user/register" parameters:params resultClass:[ResponseModel class]
              resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
    {
        if (completion) {
            completion(responseObject, error);
        }
    }];
}

- (AFHTTPRequestOperation *)loginWithUId:(NSString *)uId password:(NSString *)password completion:(void (^)(ResponseModel *, NSError *))completion
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken];
    if (ISEMPTYSTR(token)) {
        token = @"";
    }
    NSDictionary *params = @{@"mpno": uId,
                             @"password": password,
                             @"token": token,
                             @"longitude": @"",
                             @"latitude": @"",
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    __weak UserCenter* weakSelf = self;
    return [_APIClient POST:@"user/login" parameters:params resultClass:[ResponseModel class]
              resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
    {
        if ([responseObject isKindOfClass:[ResponseModel class]]) {
            if ([(ResponseModel *)responseObject success]) {
                __strong UserCenter* strongSelf = weakSelf;
                strongSelf.currentUser = [[UserInfo alloc] initWithMpno:uId];
                strongSelf.currentUser.userCookie = [[operation.response allHeaderFields] objectForKey:@"Set-Cookie"];
                [strongSelf saveUserInfo];
            }
        }
        if (completion) {
            completion(responseObject, error);
        }
    }];
}

- (AFHTTPRequestOperation *)authCheckWithOpenId:(NSString *)openid nickName:(NSString *)nickName headImgUrl:(NSString *)headImgUrl province:(NSString *)province gender:(NSString *)gender fromAuth:(AuthFromType)fromAuth completion:(void (^)(ResponseModel *, NSError *))completion
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken];
    if (ISEMPTYSTR(token)) {
        token = @"";
    }
    NSDictionary *params = @{@"openid": openid,
                             @"nickname": nickName,
                             @"headurl": headImgUrl,
                             @"province": province,
                             @"gender": gender,
                             @"fromauth": @(fromAuth),
                             @"channel": @"AppStore",
                             @"token": token,
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    __weak UserCenter* weakSelf = self;
    return [_APIClient POST:@"user/authcheck" parameters:params resultClass:[ResponseModel class]
              resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if ([responseObject isKindOfClass:[ResponseModel class]]) {
                    if ([(ResponseModel *)responseObject success]) {
                        __strong UserCenter* strongSelf = weakSelf;
                        if (strongSelf) {
                            strongSelf.currentUser = [[UserInfo alloc] initWithMpno:openid];
                            strongSelf.currentUser.userCookie = [[operation.response allHeaderFields] objectForKey:@"Set-Cookie"];
                            [strongSelf saveUserInfo];
                        }
                    }
                }
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

- (AFHTTPRequestOperation *)pullUserInfo:(void (^)(UserModel *, NSError *))completion
{
    NSDictionary *params = @{@"os": @"IOS",
                             @"ver": APP_BUILDVER};
    __weak UserCenter* weakSelf = self;
    [_APIClient.requestSerializer setValue:[self userCookie] forHTTPHeaderField:cookieKey];
    return [_APIClient POST:@"user/info" parameters:params resultClass:[UserModel class]
              resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
                if (responseObject && [responseObject isKindOfClass:[UserModel class]]) {
                    UserModel *result = responseObject;
                    __strong UserCenter* strongSelf = weakSelf;
                    if (!strongSelf.currentUser) {
                        strongSelf.currentUser = [[UserInfo alloc] init];
                    }
                    [strongSelf.currentUser fillWithUser:responseObject];
                    strongSelf.currentUser.headImgUri = [[self class] getImgUrlByID:_currentUser.imgId];
                    if (result.success) {
                        [strongSelf saveUserInfo];
                    } else {
                        [strongSelf expireUserLoginSession];
                    }
                }
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

- (AFHTTPRequestOperation *)logoutWithCompletion:(void (^)(ResponseModel *, NSError *))completion
{
    __weak UserCenter* weakSelf = self;
    [_APIClient.requestSerializer setValue:[self userCookie] forHTTPHeaderField:cookieKey];
    NSDictionary *params = @{@"os": @"IOS",
                             @"ver": APP_BUILDVER};
    return [_APIClient POST:@"user/logout" parameters:params
                resultClass:[ResponseModel class] resultKeyPath:nil
                 completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
    {
        __strong UserCenter* strongSelf = weakSelf;
        [strongSelf expireUserLoginSession];
        if (completion) {
            completion(responseObject, error);
        }
    }];
}

- (AFHTTPRequestOperation *)setUserInfoWithKey:(NSString *)key value:(NSString *)value completion:(void (^)(ResponseModel *, NSError *))completion
{
    NSDictionary *params = @{@"key": key,
                             @"value": value,
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    [_APIClient.requestSerializer setValue:[self userCookie] forHTTPHeaderField:cookieKey];
    return [_APIClient POST:@"user/setval" parameters:params resultClass:[ResponseModel class]
              resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
    {
        if (completion) {
            completion(responseObject, error);
        }
    }];
}

- (AFHTTPRequestOperation *)setUserInfoWithDic:(NSDictionary *)params completion:(void (^)(ResponseModel *, NSError *))completion
{
    [_APIClient.requestSerializer setValue:[self userCookie] forHTTPHeaderField:cookieKey];
    return [_APIClient POST:@"user/setvals" parameters:params resultClass:[ResponseModel class]
              resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

- (AFHTTPRequestOperation *)changePassword:(NSString *)oldPassword newPassword:(NSString *)newPassword completion:(void (^)(ResponseModel *, NSError *))completion
{
    NSDictionary *params = @{@"oldpassword": oldPassword,
                             @"newpassword": newPassword,
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    [_APIClient.requestSerializer setValue:[self userCookie] forHTTPHeaderField:cookieKey];
    return [_APIClient POST:@"user/changepassword" parameters:params
                resultClass:[ResponseModel class] resultKeyPath:nil
                 completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

- (AFHTTPRequestOperation *)findPasswordWithMpno:(NSString *)mpno password:(NSString *)password checkCode:(NSString *)checkCode completion:(void (^)(ResponseModel *, NSError *))completion
{
    NSDictionary *params = @{@"mpno": mpno,
                             @"newpassword": password,
                             @"checkcode": checkCode,
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    [_APIClient.requestSerializer setValue:[self userCookie] forHTTPHeaderField:cookieKey];
    return [_APIClient POST:@"user/findpassword" parameters:params
                resultClass:[ResponseModel class] resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

- (AFHTTPRequestOperation *)getAdPicListWithCompletion:(void (^)(PicAdListModel *, NSError *))completion
{
    NSDictionary *params = @{@"os": @"IOS",
                             @"ver": APP_BUILDVER};
    return [_APIClient POST:@"adv/adpiclist" parameters:params
                resultClass:[PicAdListModel class] resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
    {
        if (completion) {
            completion(responseObject, error);
        }
    }];
}

- (AFHTTPRequestOperation *)getActivityListWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize completion:(void (^)(ActivityListModel *, NSError *))completion
{
    NSDictionary *params = @{@"pageindex": @(pageIndex),
                             @"pageSize": @(pageSize),
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    [_APIClient.requestSerializer setValue:[self userCookie] forHTTPHeaderField:cookieKey];
    return [_APIClient POST:@"activity/list" parameters:params
                resultClass:[ActivityListModel class] resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

- (AFHTTPRequestOperation *)getActivityDetailWithId:(NSInteger)activityId completion:(void (^)(ActivityDetailModel *, NSError *))completion
{
    NSDictionary *params = @{@"activityid": @(activityId),
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    [_APIClient.requestSerializer setValue:[self userCookie] forHTTPHeaderField:cookieKey];
    return [_APIClient POST:@"activity/detail" parameters:params
                resultClass:[ActivityDetailModel class] resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

- (AFHTTPRequestOperation *)getNextActivityDetailWithId:(NSInteger)activityId kind:(NSInteger)kind completion:(void (^)(ActivityDetailModel *, NSError *))completion
{
    NSDictionary *params = @{@"activityid": @(activityId),
                             @"kind": @(kind),
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    [_APIClient.requestSerializer setValue:[self userCookie] forHTTPHeaderField:cookieKey];
    return [_APIClient POST:@"activity/skip" parameters:params
                resultClass:[ActivityDetailModel class] resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

- (AFHTTPRequestOperation *)getSuperTotalWithTvId:(NSInteger)tvId completion:(void (^)(SuperTotalModel *, NSError *))completion
{
    NSDictionary *params;
    if (tvId < 0) {
        params = @{@"os": @"IOS",
                   @"ver": APP_BUILDVER};
    } else {
        params = @{@"tvid": @(tvId),
                   @"os": @"IOS",
                   @"ver": APP_BUILDVER};
    }
    [_APIClient.requestSerializer setValue:[self userCookie] forHTTPHeaderField:cookieKey];
    return [_APIClient POST:@"user/supertotal" parameters:params
                resultClass:[SuperTotalModel class] resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

- (AFHTTPRequestOperation *)getParticipantWithTvId:(NSInteger)tvId completion:(void (^)(ParticipantModel *, NSError *))completion
{
    NSDictionary *params = @{@"tvid": @(tvId),
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    [_APIClient.requestSerializer setValue:[self userCookie] forHTTPHeaderField:cookieKey];
    return [_APIClient POST:@"shake/currenttotal" parameters:params
                resultClass:[ParticipantModel class] resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

- (AFHTTPRequestOperation *)shakeRequestWithTvId:(NSInteger)tvId completion:(void (^)(ShakeModel *, NSError *))completion
{
    NSDictionary *params = @{@"tvid": @(tvId),
                             @"os": @"IOS",
                             @"ver": APP_BUILDVER};
    [_APIClient.requestSerializer setValue:[self userCookie] forHTTPHeaderField:cookieKey];
    return [_APIClient POST:@"shake/request" parameters:params
                resultClass:[ShakeModel class] resultKeyPath:nil completion:
            ^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
            {
                if (completion) {
                    completion(responseObject, error);
                }
            }];
}

@end
