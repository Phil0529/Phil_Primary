//
//  UploadItem.m
//  EZTV
//
//  Created by Lee, Bo on 15/5/9.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "UploadItem.h"
//#import "UIImage+Function.h"

@implementation UploadItem

@synthesize _id = __id;
@synthesize title = _title;
@synthesize mpno = _mpno;
@synthesize path = _path;
@synthesize type = _type;
@synthesize createtime = _createtime;
@synthesize content = _content;
@synthesize pics = _pics;
@synthesize video = _video;

// PhilChange
@synthesize lon = _lon;
@synthesize lat = _lat;
@synthesize address = _address;
@synthesize url = _url;

+ (UploadItem *)itemWithTitle:(NSString *)title mpno:(NSString *)mpno path:(NSString *)path type:(UploadType)type content:(NSString *)content
{
    UploadItem *newItem = [[UploadItem alloc] init];
    newItem.title = title;
    newItem.mpno = mpno;
    newItem.path = path;
    newItem.type = type;
    newItem.content = content;
    newItem.createtime = [[NSDate date] timeIntervalSince1970];
    
    //PhilChange
    return newItem;
}

// PhilChange
+ (UploadItem *)itemWithTitle:(NSString *)title mpno:(NSString *)mpno path:(NSString *)path type:(UploadType)type content:(NSString *)content lon:(NSString *)lon lat:(NSString *)lat address:(NSString *)address{
    UploadItem *newItem = [[UploadItem alloc] init];
    newItem.title = title;
    newItem.mpno = mpno;
    newItem.path = path;
    newItem.type = type;
    newItem.content = content;
    newItem.lon = lon;
    newItem.lat = lat;
    newItem.address = address;
    newItem.createtime = [[NSDate date] timeIntervalSince1970];
    //PhilChange
    return newItem;

    
}

- (instancetype)initWithJsonData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        if (data && [data isKindOfClass:[NSDictionary class]]) {
            OBJ2STR([data objectForKey:@"_id"], __id);
            OBJ2STR([data objectForKey:@"mpno"], _mpno);
            OBJ2STR([data objectForKey:@"title"], _title);
            OBJ2STR([data objectForKey:@"path"], _path);
            OBJ2STR([data objectForKey:@"pics"], _pics);
            OBJ2STR([data objectForKey:@"video"], _video);
            OBJ2INT([data objectForKey:@"type"], _type);
            OBJ2FLOAT([data objectForKey:@"createtime"], _createtime);
            OBJ2STR([data objectForKey:@"content"], _content);
            // PhilChange
            OBJ2STR([data objectForKey:@"url"], _url);
            OBJ2STR([data objectForKey:@"lon"], _lon);
            OBJ2STR([data objectForKey:@"lat"], _lat);
            OBJ2STR([data objectForKey:@"address"], _address);

            
            
            _content = [_content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }
    }
    return self;
}

@end
