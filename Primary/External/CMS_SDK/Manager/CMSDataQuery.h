//
//  CMSDataQuery.h
//  Primary
//
//  Created by Phil Xhc on 15/11/17.
//  Copyright © 2015年 Xhc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;
@interface CMSDataQuery : NSObject

- (AFHTTPRequestOperation *)uploadPicsByLocationDict:(NSDictionary *)locationDict imagesArr:(NSArray *)imagesArr completion:(void(^)(NSArray *result))completion;

- (AFHTTPRequestOperation *)uploadVideoByMpno:(NSString *)mpno videoData:(NSData *)videoData completion:(void(^)(NSArray *result))completion;


//+ (AFHTTPRequestOperation *)uploadFileWithColumnIdPhil:(NSInteger)columnId item:(UploadItem *)item imagesDataArr:(NSArray *)imagesDataArr type:(UploadType)type uploadProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))block completion:(void(^)(NSString *filePath))completion;
//
//+ (AFHTTPRequestOperation *)uploadFileWithColumnIdPhil:(NSInteger)columnId item:(UploadItem *)item imagesDataArr:(NSArray *)imagesDataArr type:(UploadType)type uploadProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))block completion:(void(^)(NSString *filePath))completion;



@end
