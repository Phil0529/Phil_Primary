//
//  ResponseModel.m
//  EZTV
//
//  Created by Sunni on 15/7/9.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "ResponseModel.h"

@implementation ResponseModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"success": @"result",
             @"message": @"message",
             @"code": @"code"};
}

@end
