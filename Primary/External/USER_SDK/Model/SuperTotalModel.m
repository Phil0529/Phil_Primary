//
//  SuperTotalModel.m
//  EZTV
//
//  Created by Sunni on 15/7/9.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "SuperTotalModel.h"

@implementation CoinModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"validNum": @"validnum",
             @"totalNum": @"total"};
}

@end

@implementation DisCountModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"validNum": @"validnum",
             @"totalNum": @"total"};
}

@end

@implementation SuperTotalModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"success": @"result",
             @"message": @"message",
             @"coin": @"coin",
             @"discount": @"discount"};
}

+ (NSValueTransformer *)coinJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:CoinModel.class];
}

+ (NSValueTransformer *)discountJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:DisCountModel.class];
}

@end
