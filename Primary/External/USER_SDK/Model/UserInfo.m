//
//  UserInfo.m
//  EZTV
//
//  Created by Sunni on 15/7/10.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

@synthesize userId = _userId;
@synthesize mpno = _mpno;
@synthesize nickName = _nickName;
@synthesize gender = _gender;
@synthesize imgId = _imgId;
@synthesize headImgUri = _headImgUri;
@synthesize userCookie = _userCookie;
@synthesize phone = _phone;
@synthesize birthday = _birthday;

- (instancetype)initWithMpno:(NSString *)mpno
{
    self = [super init];
    if (self) {
        _mpno = mpno;
    }
    return self;
}

- (void)fillWithUser:(id)userModel
{
    if([userModel isKindOfClass:[UserModel class]]){
        UserModel *user = (UserModel *)userModel;
        _mpno = user.mpno;
        _nickName = user.nickName;
        _gender = user.gender;
        _imgId = user.imgId;
        _phone = user.phone;
        if (ISEMPTYSTR(user.birthday)) {
            _birthday = @"1990-1-1";
        } else {
            _birthday = user.birthday;
        }
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_userCookie forKey:@"userCookie"];
    [aCoder encodeInteger:_userId forKey:@"userId"];
    [aCoder encodeObject:_headImgUri forKey:@"userHeadImg"];
    [aCoder encodeObject:_nickName forKey:@"usernickname"];
    [aCoder encodeObject:_mpno forKey:@"usermpno"];
    [aCoder encodeObject:_imgId forKey:@"userimgId"];
    [aCoder encodeInteger:_gender forKey:@"usergender"];
    [aCoder encodeObject:_phone forKey:@"userphone"];
    [aCoder encodeObject:_birthday forKey:@"userbirthday"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _userCookie = [aDecoder decodeObjectForKey:@"userCookie"];
        _userId = [aDecoder decodeIntegerForKey:@"userId"];
        _imgId = [aDecoder decodeObjectForKey:@"userimgId"];
        _headImgUri = [aDecoder decodeObjectForKey:@"userHeadImg"];
        _nickName = [aDecoder decodeObjectForKey:@"usernickname"];
        _mpno = [aDecoder decodeObjectForKey:@"usermpno"];
        _gender = [aDecoder decodeIntegerForKey:@"usergender"];
        _phone = [aDecoder decodeObjectForKey:@"userphone"];
        _birthday = [aDecoder decodeObjectForKey:@"userbirthday"];
    }
    return self;
}
@end
