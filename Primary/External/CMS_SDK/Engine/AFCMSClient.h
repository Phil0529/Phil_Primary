//
//  AFJsonAPIClient.h
//  HuaXia
//
//  Created by Lee, Bo on 15/3/30.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "AFHTTPSessionManager.h"

#define ACTION_GET_SYS_CONFIG   @"get_system_config"
#define ACTION_GET_INIT_CONFIG   @"get_init_config"
#define ACTION_SET_COIN    @"set_coin"
#define ACTION_GET_SIGNST  @"get_sign_status"
#define ACTION_GET_MYUPLOADS    @"get_myuploads"
#define ACTION_SET_POSTS    @"set_posts"
#define ACTION_SET_UPLOAD  @"set_upload"
#define ACTION_SET_ATTACHS  @"set_attachs"
#define ACTION_DELETE_FAVORITES @"delete_favorites"

#define ACTION_GET_BROADCAST_DETAIL @"get_broadprograms"
#define ACTION_GET_BROADCASTLIST @"get_broadcasts"
#define ACTION_GET_UTC_TIME @"get_utc_time"
#define ACTION_PRAISE_POST @"set_broadcasts_assist"
#define ACTION_GET_BROADCAS_CHANNEL_DETAIL @"get_broadcasts_detail"

@interface AFCMSClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
