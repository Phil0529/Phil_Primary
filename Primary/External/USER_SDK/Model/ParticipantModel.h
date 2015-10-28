//
//  ParticipantModel.h
//  EZTV
//
//  Created by Sunni on 15/7/9.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "MTLModel.h"

@interface ParticipantModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSInteger totalCount;//总参与者
@property (nonatomic, assign) NSInteger winnerCount;//中奖人数

@end
