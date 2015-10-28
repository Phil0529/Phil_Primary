//
//  EZColumnItem.m
//  HuaXia
//
//  Created by Lee, Bo on 15/3/25.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "EZColumnItem.h"

@implementation EZColumnItem

@synthesize cid = _cid;
@synthesize pid = _pid;
@synthesize name = _name;
@synthesize listtype = _listtype;
@synthesize url = _url;
@synthesize upstatus = _upstatus;
@synthesize adstatus = _adstatus;
@synthesize commentstatus = _commentstatus;
@synthesize isselect = _isselect;
@synthesize haschild = _haschild;

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"cid": @"cid",
             @"pid": @"pid",
             @"name": @"name",
             @"listtype": @"listtype",
             @"url": @"url",
             @"pics": @"pics",
             @"icon": @"icon",
             @"upstatus": @"upstatus",
             @"adstatus": @"adstatus",
             @"commentstatus": @"commentstatus",
             @"isselect": @"isselect",
             @"haschild": @"haschild"};
}

@end
