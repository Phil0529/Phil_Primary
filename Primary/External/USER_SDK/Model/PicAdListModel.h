//
//  PicAdListModel.h
//  EZTV
//
//  Created by Sunni on 15/7/9.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "MTLModel.h"

@interface PicAdModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger activityId;
@property (nonatomic, assign) NSInteger tvId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, assign) NSInteger hasChatRoom;

@end

@interface PicAdListModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSArray *list;

@end
