//
//  UploadItem.h
//  EZTV
//
//  Created by Lee, Bo on 15/5/9.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, UploadType)
{
    UploadType_Image = 1,
    UploadType_Video = 2,
};

@interface UploadItem : NSObject

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *mpno;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, assign) UploadType type;
@property (nonatomic, assign) NSTimeInterval createtime;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *pics;
@property (nonatomic, strong) NSString *video;
@property (nonatomic, strong) NSString *url;

//PhilChange
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *address;



- (instancetype)initWithJsonData:(NSDictionary *)data;
+ (UploadItem *)itemWithTitle:(NSString *)title mpno:(NSString *)mpno path:(NSString *)path type:(UploadType)type content:(NSString *)content;

+ (UploadItem *)itemWithTitle:(NSString *)title mpno:(NSString *)mpno path:(NSString *)path type:(UploadType)type content:(NSString *)content lon:(NSString *)lon lat:(NSString *)lat address:(NSString *)address;

@end
