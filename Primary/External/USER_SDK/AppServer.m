////
////  AppServer.m
////  EZTV
////
////  Created by Sunni on 15/7/6.
////  Copyright (c) 2015年 Joygo. All rights reserved.
////
//
//#import "AppServer.h"
//
//static OVCClient *_APIClient;
//
//@implementation AppServer
//{
//    NSMutableDictionary *_dataMap;
//}
//
//+ (AppServer *)sharedServer
//{
//    static AppServer *_sharedClient = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _sharedClient = [[AppServer alloc] init];
//        _APIClient = [OVCClient clientWithBaseURL:[NSURL URLWithString:APPSBaseURLString] account:nil];
//        NSSet *newContentTypes = [_APIClient.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//        [_APIClient.responseSerializer setAcceptableContentTypes:newContentTypes];
//        [_APIClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
//    });
//    return _sharedClient;
//}
//
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        
//        _dataMap = [[NSMutableDictionary alloc] init];
//    }
//    return self;
//}
//
//- (void)getUserTokenWithId:(NSString *)userId name:(NSString *)name picurl:(NSString *)picurl completion:(void (^)(TokenModel *, NSError *))completion
//{
//    TokenModel *result;
//    if (userId) {
//        result = [_dataMap objectForKey:userId];
//    }
//    
//    if (result) {
//        if (completion) {
//            completion(result, nil);
//        }
//    } else {
//        [self queryUserTokenWithId:userId name:name picurl:picurl completion:completion];
//    }
//}
//
//- (AFHTTPRequestOperation *)queryUserTokenWithId:(NSString *)userId name:(NSString *)name picurl:(NSString *)picurl completion:(void (^)(TokenModel *, NSError *))completion
//{
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            userId, @"userid",
//                            name, @"name",
//                            picurl, @"picurl", nil];
//    return [_APIClient GET:@"chatroomapi/gettoken" parameters:params
//              resultClass:[TokenModel class] resultKeyPath:nil
//                completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
//    {
//        if ([responseObject isKindOfClass:[TokenModel class]]) {
//            [_dataMap setObject:responseObject forKey:userId];
//        }
//         if (completion) {
//             completion(responseObject, error);
//         }
//    }];
//}
//
//- (AFHTTPRequestOperation *)getUserListWithRoomId:(NSString *)roomId completion:(void (^)(NSArray *, NSError *))completion
//{
//    [_APIClient.requestSerializer setValue:[[UserCenter defaultCenter] userCookie]
//                        forHTTPHeaderField:cookieKey];
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            roomId, @"chatroomId",
//                            @"IOS", @"os",
//                            APP_BUILDVER, @"ver", nil];
//    return [_APIClient GET:@"chatroomapi/getuserlist" parameters:params
//               resultClass:[AudienceModel class] resultKeyPath:@"users"
//                completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error)
//    {
//        if (completion) {
//            completion(responseObject, error);
//        }
//    }];
//}
//
//- (AFHTTPRequestOperation *)saveVipConversationWithRoomId:(NSString *)roomId userId:(NSString *)userId nickName:(NSString *)nickName headImg:(NSString *)headImg content:(NSString *)content completion:(void (^)(ResponseModel *, NSError *))completion
//{
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            roomId, @"roomid",
//                            userId, @"userid",
//                            nickName, @"nickname",
//                            headImg, @"headurl",
//                            content, @"content",
//                            @([[NSDate date] timeIntervalSince1970]), @"sendtime",nil];
//    return [_APIClient POST:@"customservice/chatroomcontentsave" parameters:params
//                resultClass:[ResponseModel class] resultKeyPath:nil
//                 completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
//                     if (completion) {
//                         completion(responseObject, error);
//                     }
//                }];
//}
//
//- (AFHTTPRequestOperation *)getMessageListWithRoomId:(NSString *)roomId pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize completion:(void (^)(MessageListModel *, NSError *))completion
//{
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            roomId, @"roomid",
//                            @(pageIndex), @"pageindex",
//                            @(pageSize), @"pagesize", nil];
//    return [_APIClient POST:@"customservice/chatroomcontentlist" parameters:params
//                resultClass:[MessageListModel class] resultKeyPath:nil
//                 completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
//                     if (completion) {
//                         completion(responseObject, error);
//                     }
//                 }];
//}
//
//@end
