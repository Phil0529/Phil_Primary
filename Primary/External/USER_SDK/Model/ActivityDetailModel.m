//
//  ActivityDetailModel.m
//  EZTV
//
//  Created by Sunni on 15/7/9.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "ActivityDetailModel.h"

@implementation GuestModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"userId": @"userid",
             @"mpno": @"mpno",
             @"nickName": @"nickname"};
}

@end

@implementation ActivityDetailModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"success": @"result",
             @"message": @"message",
             @"tvId": @"tvid",
             @"tvName": @"tvname",
             @"activityId": @"activityid",
             @"title": @"title",
             @"content": @"content",
             @"adescription": @"description",
             @"publishDate": @"pubdate",
             @"hasChatroom": @"isjoinchatroom",
             @"chatroomId": @"chatroomid",
             @"chatroomName": @"chatroomname",
             @"guests": @"guests"};
}

+ (NSValueTransformer *)guestsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:GuestModel.class];
}


@end
