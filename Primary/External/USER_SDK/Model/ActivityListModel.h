//
//  ActivityListModel.h
//  EZTV
//
//  Created by Sunni on 15/7/9.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "MTLModel.h"

@interface ActivityModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger tvId;
@property (nonatomic, copy) NSString* tvName;
@property (nonatomic, assign) NSInteger activityId;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* adescription;
@property (nonatomic, copy) NSString* publishDate;
@property (nonatomic, assign) NSInteger hasChatroom;
@property (nonatomic, copy) NSString* chatroomId;
@property (nonatomic, copy) NSString* chatroomName;

@end

@interface ActivityListModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSArray *list;

@end
