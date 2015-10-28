//
//  ShakeModel.h
//  EZTV
//
//  Created by Sunni on 15/7/9.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "MTLModel.h"

typedef NS_ENUM(NSUInteger, ShakeType)
{
    ShakeType_NotInTime = 0,    //未在时段
    ShakeType_Money = 1,        //红包
    ShakeType_Goods = 2,        //商品
    ShakeType_Questions = 3,    //问卷
    ShakeType_Coupon = 4,      //代金券
    ShakeType_Coin = 5,         //宝贝
    ShakeType_Lottery = 6,      //彩票
    ShakeType_Late = 9,         //领完
    ShakeType_Sorry = 10,       //未中
    ShakeType_Limited = 11,     //中奖次数太多
};

@interface CoinShake : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger tvId;
@property (nonatomic, copy) NSString* tvName;
@property (nonatomic, copy) NSString* coinmoney;

@end

@interface DiscountShake : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString* discountName;
@property (nonatomic, copy) NSString* discountNo;
@property (nonatomic, copy) NSString* beginDate;
@property (nonatomic, copy) NSString* endDate;
@property (nonatomic, copy) NSString* endDays;
@property (nonatomic, copy) NSString* discountMoney;

@end

@interface ShakeModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString* kind;
@property (nonatomic, strong) CoinShake* coin;
@property (nonatomic, strong) DiscountShake* discount;

@end
