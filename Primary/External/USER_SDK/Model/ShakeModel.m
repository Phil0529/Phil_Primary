//
//  ShakeModel.m
//  EZTV
//
//  Created by Sunni on 15/7/9.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "ShakeModel.h"

@implementation CoinShake

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"tvId": @"tvid",
             @"tvName": @"tvname",
             @"coinmoney": @"coinmoney"};
}

@end

@implementation DiscountShake

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"discountName": @"discountname",
             @"discountNo": @"discountno",
             @"beginDate": @"begindate",
             @"endDate": @"enddate",
             @"endDays": @"enddays",
             @"discountMoney": @"discountmoney"};
}

@end

@implementation ShakeModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"success": @"result",
             @"message": @"message",
             @"kind": @"kind",
             @"discount": @"kind4",
             @"coin": @"kind5"};
}

+ (NSValueTransformer *)discountJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:DiscountShake.class];
}

+ (NSValueTransformer *)coinJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:CoinShake.class];
}

@end
