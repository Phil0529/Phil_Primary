//
//  AppServer.h
//  EZTV
//
//  Created by Sunni on 15/7/6.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserCenter.h"
#import "TokenModel.h"
#import "AudienceModel.h"
#import "OVCClient.h"
#import "ResponseModel.h"
#import "MessageListModel.h"

@interface AppServer : NSObject

/**
 *  单例方法
 *
 *  @return 单例实例
 */
+ (AppServer *)sharedServer;

/**
 *  获取融云交互token
 *
 *  @param userId     用户id
 *  @param name       用户昵称
 *  @param picurl     用户头像
 *  @param completion 数据返回block
 */
- (void)getUserTokenWithId:(NSString *)userId name:(NSString *)name picurl:(NSString *)picurl completion:(void(^)(TokenModel *token, NSError *error))completion;

/**
 *  获取聊天室用户列表
 *
 *  @param roomId     聊天室Id
 *  @param completion 数据返回
 *
 *  @return AFHTTPRequestOperation
 */
- (AFHTTPRequestOperation *)getUserListWithRoomId:(NSString *)roomId completion:(void(^)(NSArray *userList, NSError *error))completion;

/**
 *  保存嘉宾聊天记录
 *
 *  @param roomId     房间Id号
 *  @param userId     用户Id
 *  @param nickName   用户昵称
 *  @param headImg    头像Url
 *  @param content    消息内容
 *  @param completion 数据返回
 *
 *  @return AFHTTPRequestOperation
 */
- (AFHTTPRequestOperation *)saveVipConversationWithRoomId:(NSString *)roomId userId:(NSString *)userId nickName:(NSString *)nickName headImg:(NSString *)headImg content:(NSString *)content completion:(void(^)(ResponseModel *respone, NSError *error))completion;

/**
 *  获取聊天列表
 *
 *  @param roomId     房间Id
 *  @param pageIndex  分页号
 *  @param pageSize   页大小
 *  @param completion 数据返回
 *
 *  @return AFHTTPRequestOperation
 */
- (AFHTTPRequestOperation *)getMessageListWithRoomId:(NSString *)roomId pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize completion:(void(^)(MessageListModel *messageList, NSError *error))completion;

//- (AFHTTPRequestOperation *)createChatRoomWithId:(NSString *)chatId name:(NSString *)name completion:(void(^)(BOOL success))completion;

@end
