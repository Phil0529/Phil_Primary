//
//  CMSDataQuery.m
//  Primary
//
//  Created by Phil Xhc on 15/11/17.
//  Copyright © 2015年 Xhc. All rights reserved.
//

#import "CMSDataQuery.h"
#import "OVCCMSClient.h"
#import "UserCenter.h"

@implementation CMSDataQuery

- (AFHTTPRequestOperation *)uploadPicsByLocationDict:(NSDictionary *)locationDict imagesArr:(NSArray *)imagesArr completion:(void(^)(NSArray *result))completion{
    
    
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            [UserCenter defaultCenter].currentUser.mpno, @"mpno",
//                            REVIEW_VER, VER_KEY,
//                            OS_VERSION, OS_KEY,
//                            PROJECT_ID, PROJECT_KEY, nil];
//    
//    [[OVCCMSClient sharedClient].requestSerializer setValue:[UserCenter defaultCenter].userCookie forHTTPHeaderField:cookieKey];
//    return [[OVCCMSClient sharedClient] POST:@"delete_myuploads" parameters:params resultClass:[ResponseModel class] resultKeyPath:nil completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
//        if (completion) {
//            completion(responseObject);
//        }
//    }];
    
//    NSDictionary *params;
//    if (![locationDict objectForKey:@"lon"]) {
//        params = @{@"title":item.content,
//                   @"content": item.content,
//                   @"type": [NSString stringWithFormat:@"%ld", (long)item.type],
//                   @"status":@"1",
//                   @"lon":@"0",
//                   @"lat":@"0",
//                   @"address":@"0",
//                   @"columnid": [NSString stringWithFormat:@"%ld", (long)columnId],
//                   @"mpno": item.mpno,
//                   //                             @"ver":,
//                   @"os":@"2",
//                   @"project":@""};
//    }
//    else{
//        params = @{@"title":item.content,
//                   @"content": item.content,
//                   @"type": [NSString stringWithFormat:@"%ld", (long)item.type],
//                   @"status":@"1",
//                   @"lon":item.lon,
//                   @"lat":item.lat,
//                   @"address":item.address,
//                   @"columnid": [NSString stringWithFormat:@"%ld", (long)columnId],
//                   @"mpno": item.mpno,
//                   //                             @"ver":,
//                   @"os":@"2",
//                   @"project":@""};
//    }
    return nil;

}

- (AFHTTPRequestOperation *)uploadVideoByMpno:(NSString *)mpno videoData:(NSData *)videoData completion:(void(^)(NSArray *result))completion{
    return nil;
}



@end
