//
//  ActivityListModel.m
//  EZTV
//
//  Created by Sunni on 15/7/9.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "ActivityListModel.h"

@implementation ActivityModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"tvId": @"tvid",
             @"tvName": @"tvname",
             @"activityId": @"activityid",
             @"title": @"title",
             @"adescription": @"description",
             @"publishDate": @"pubdate",
             @"hasChatroom": @"isjoinchatroom",
             @"chatroomId": @"chatroomid",
             @"chatroomName": @"chatroomname"};
}

@end

@implementation ActivityListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"success": @"result",
             @"message": @"message",
             @"list": @"lists"};
}

+ (NSValueTransformer *)listJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:ActivityModel.class];
}

@end