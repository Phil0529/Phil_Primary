//
//  PicAdListModel.m
//  EZTV
//
//  Created by Sunni on 15/7/9.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "PicAdListModel.h"

@implementation PicAdModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"activityId": @"activityid",
             @"tvId": @"tvid",
             @"title": @"title",
             @"picUrl": @"picurl",
             @"hasChatRoom": @"isjoinchatroom"};
}

@end

@implementation PicAdListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"success": @"result",
             @"message": @"message",
             @"list": @"list"};
}

+ (NSValueTransformer *)listJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:PicAdModel.class];
}

@end
