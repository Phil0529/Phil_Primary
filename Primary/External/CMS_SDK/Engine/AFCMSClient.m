//
//  AFJsonAPIClient.m
//  HuaXia
//
//  Created by Lee, Bo on 15/3/30.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "AFCMSClient.h"

@implementation AFCMSClient

+ (instancetype)sharedClient {
    static AFCMSClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFCMSClient alloc] initWithBaseURL:[NSURL URLWithString:CMSBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        NSSet *newContentTypes = [_sharedClient.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        _sharedClient.responseSerializer.acceptableContentTypes = newContentTypes;
    });
    
    return _sharedClient;
}

@end
