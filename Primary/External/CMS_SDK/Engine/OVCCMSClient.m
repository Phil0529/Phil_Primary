//
//  OVCCMSClient.m
//  EZTV
//
//  Created by Sunni on 15/7/15.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "OVCCMSClient.h"

@implementation OVCCMSClient

+ (instancetype)sharedClient {
    static OVCCMSClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [self clientWithBaseURL:[NSURL URLWithString:CMSBaseURLString] account:nil];
        NSSet *newContentTypes = [_sharedClient.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        [_sharedClient.responseSerializer setAcceptableContentTypes:newContentTypes];
        [_sharedClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
    });
    
    return _sharedClient;
}


@end
