//
//  UserInfo.h
//  EZTV
//
//  Created by Sunni on 15/7/10.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface UserInfo : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSString *mpno;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, strong) NSString *imgId;
@property (nonatomic, strong) NSString *headImgUri;
@property (nonatomic, strong) NSString *userCookie;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *birthday;

- (instancetype)initWithMpno:(NSString *)mpno;

- (void)fillWithUser:(id)userModel;

@end
