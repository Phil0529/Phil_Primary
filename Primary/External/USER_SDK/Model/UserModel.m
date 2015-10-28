//
//  UserModel.m
//  EZTV
//
//  Created by Sunni on 15/7/9.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"success": @"result",
             @"message": @"message",
             @"mpno": @"mpno",
             @"nickName": @"nickname",
             @"gender": @"gender",
             @"phone": @"phone",
             @"birthday": @"birthday",
             @"imgId": @"img"};
}

@end
