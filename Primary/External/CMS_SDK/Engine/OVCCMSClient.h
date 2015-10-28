//
//  OVCCMSClient.h
//  EZTV
//
//  Created by Sunni on 15/7/15.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OVCClient.h>

#define ACTION_GET_MEDIAS   @"get_medias"
#define ACTION_GET_DETAIL   @"get_detail"
#define ACTION_GET_SLIDES   @"get_slides"
#define ACTION_GET_SPECIALS @"get_specials"
#define ACTION_GET_COMMENTS @"get_comments"
#define ACTION_GET_COLUMNS  @"get_columns"
#define ACTION_SET_COMMENTS @"set_comments"
#define ACTION_SET_ASSIST   @"set_assist"
#define ACTION_GET_AREAS    @"get_areas"
#define ACTION_GET_HANGYES  @"get_hangyes"

#define ACTION_SET_FAVORITES    @"set_favorites"

#define ACTION_GET_FAVORITES    @"get_favorites"


@interface OVCCMSClient : OVCClient

+ (instancetype)sharedClient;

@end
