//
//  EZColumnItem.h
//  HuaXia
//
//  Created by Lee, Bo on 15/3/25.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"

typedef NS_ENUM(NSUInteger, ListType) {
    ListTypeNews = 1,           //平铺
    ListTypeBlock = 2,          //方块
    ListTypeHtml = 3,           //网页
    ListTypeAnnounce = 4,    //无图列表
    ListTypeActivity = 5,     //活动列表
    ListTypeLive = 6,       //微直播
    ListTypeTable = 7,      //模仿网易新闻
    ListTypeWaterflow = 8,  //瀑布流图片集
    ListTypeBroadCast = 9,  //广播
    ListTypeTv = 10,        //直播
    ListTypeMovie = 11,     //点播
};

@interface EZColumnItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, assign) NSInteger pid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) ListType listtype;
@property (nonatomic, strong) NSString *pics;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) NSUInteger upstatus;
@property (nonatomic, assign) NSUInteger adstatus;
@property (nonatomic, assign) NSUInteger commentstatus;
@property (nonatomic, assign) NSUInteger isselect;
@property (nonatomic, assign) NSUInteger haschild;
@property (nonatomic, assign) double sortNum;
@property (nonatomic, weak) NSArray *subArray;

@end


