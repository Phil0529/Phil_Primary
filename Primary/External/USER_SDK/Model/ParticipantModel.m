//
//  ParticipantModel.m
//  EZTV
//
//  Created by Sunni on 15/7/9.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "ParticipantModel.h"

@implementation ParticipantModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"success": @"result",
             @"message": @"message",
             @"totalCount": @"totals",
             @"winnerCount": @"winning"};
}

@end
