//
//  SuperTotalModel.h
//  EZTV
//
//  Created by Sunni on 15/7/9.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "MTLModel.h"

@interface CoinModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *validNum;//当前有效宝贝（除去已用）
@property (nonatomic, copy) NSString *totalNum;//累计宝贝

@end

@interface DisCountModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *validNum;//当前有效代券张数
@property (nonatomic, copy) NSString *totalNum;//累计摇中代券金额数

@end

@interface SuperTotalModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) CoinModel *coin;
@property (nonatomic, strong) DisCountModel *discount;

@end
