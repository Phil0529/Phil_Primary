//
//  UserModel.h
//  EZTV
//
//  Created by Sunni on 15/7/9.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//


@interface UserModel : MTLModel<MTLJSONSerializing>

//********unused fields**********//
//truename: “” ,//真实姓名
//cardid:””, // 身份证
//phone:“”, //电话
//email：“”, //Email
//city : “”, //居住地
@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *mpno;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, copy) NSString *imgId;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *birthday;

@end
