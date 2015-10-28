//
//  UploadManager.m
//  EZTV
//
//  Created by Lee, Bo on 15/5/8.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "UploadManager.h"
#import "UserCenter.h"
#import "AFCMSClient.h"

@implementation UploadManager

+ (void)getMyUploadArraybyMpnoPhil:(NSString *)mpno completion:(void (^)(NSArray *))completion{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            mpno, @"mpno",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    [[AFCMSClient sharedClient].requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    [[AFCMSClient sharedClient] GET:ACTION_GET_MYUPLOADS parameters:params success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
             NSArray *list = [(NSDictionary *)responseObject objectForKey:@"list"];
             if (list) {
                 NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[list count]];
                 for (NSDictionary *jsonItem in list) {
                     UploadItem *item = [[UploadItem alloc] initWithJsonData:jsonItem];
//                     PhilModel *item = [PhilModel customWithDictionary:jsonItem];
                     [result addObject:item];
                 }
                 if (completion) {
                     completion(result);
                 }
                 return;
             }
         }
         if (completion) {
             completion(nil);
         }
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         if (completion) {
             completion(nil);
         }
     }];


}
+ (void)getMyUploadArraybyMpno:(NSString *)mpno completion:(void (^)(NSArray *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            mpno, @"mpno",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    [[AFCMSClient sharedClient].requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    [[AFCMSClient sharedClient] GET:ACTION_GET_MYUPLOADS parameters:params success:^(NSURLSessionDataTask *task, id responseObject)
    {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *list = [(NSDictionary *)responseObject objectForKey:@"list"];
            if (list) {
                NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[list count]];
                for (NSDictionary *jsonItem in list) {
                    UploadItem *item = [[UploadItem alloc] initWithJsonData:jsonItem];
                    [result addObject:item];
                }
                if (completion) {
                    completion(result);
                }
                return;
            }
        }
        if (completion) {
            completion(nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        if (completion) {
            completion(nil);
        }
    }];
}


+ (void)uploadNewsItemWithColumnId:(NSInteger)columnId item:(UploadItem *)item completion:(void(^)(BOOL success))completion{
    
    if (ISEMPTYSTR([[UserCenter defaultCenter] userCookie])) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    NSDictionary *params = @{
                             @"lon":item.lon,
                             @"lat":item.lat,
                             @"address":item.address,
                             //PhilChange
                             @"title": item.title,
                             @"content": item.content,
                             @"type": [NSString stringWithFormat:@"%ld", (long)item.type],
                             @"path": item.path,
                             @"mpno": item.mpno,
                             @"status":@"1",
                             @"columnid": [NSString stringWithFormat:@"%ld", (long)columnId]};
    
    
    [[AFCMSClient sharedClient].requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    [[AFCMSClient sharedClient] POST:ACTION_SET_POSTS
                          parameters:params
                             success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
             id code = [(NSDictionary *)responseObject objectForKey:@"code"];
             if (code && [code integerValue] == 1) {
                 if (completion) {
                     completion(YES);
                 }
                 return;
             }
         }
         if (completion) {
             completion(NO);
         }
     }
                             failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         if (completion) {
             completion(NO);
         }
     }];


}

+ (void)uploadNewsItemWithColumnIdPhil:(NSInteger)columnId item:(UploadItem *)item completion:(void(^)(BOOL success))completion{
    if (ISEMPTYSTR([[UserCenter defaultCenter] userCookie])) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    NSDictionary *params = @{@"title": item.title,
                             @"content": item.content,
                             @"type": [NSString stringWithFormat:@"%ld", (long)item.type],
                             @"status":@"1",
                             @"lon":item.lon,
                             @"lat":item.lat,
                             @"address":item.address,
                             @"columnid": [NSString stringWithFormat:@"%ld", (long)columnId],
                             @"mpno": item.mpno,
//                             @"ver":,
                             @"os":@"2",
                             @"project":@""};
    
    [[AFCMSClient sharedClient].requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    [[AFCMSClient sharedClient] POST:ACTION_SET_POSTS
                          parameters:params
                             success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
             id code = [(NSDictionary *)responseObject objectForKey:@"code"];
             if (code && [code integerValue] == 1) {
                 if (completion) {
                     completion(YES);
                 }
                 return;
             }
         }
         if (completion) {
             completion(NO);
         }
     }
                             failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         if (completion) {
             completion(NO);
         }
     }];


}

+ (void)uploadItemWithColumnId:(NSInteger)columnId item:(UploadItem *)item completion:(void (^)(BOOL))completion
{
    if (ISEMPTYSTR([[UserCenter defaultCenter] userCookie])) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    NSDictionary *params = @{@"title": item.title,
                             @"content": item.content,
                             @"type": [NSString stringWithFormat:@"%ld", (long)item.type],
                             @"path": item.path,
                             @"mpno": item.mpno,
                             @"status":@"1",
                             @"columnid": [NSString stringWithFormat:@"%ld", (long)columnId]};
    
    [[AFCMSClient sharedClient].requestSerializer setValue:[[UserCenter defaultCenter] userCookie] forHTTPHeaderField:cookieKey];
    [[AFCMSClient sharedClient] POST:ACTION_SET_POSTS
                          parameters:params
                             success:^(NSURLSessionDataTask *task, id responseObject)
    {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            id code = [(NSDictionary *)responseObject objectForKey:@"code"];
            if (code && [code integerValue] == 1) {
                if (completion) {
                    completion(YES);
                }
                return;
            }
        }
        if (completion) {
            completion(NO);
        }
    }
                             failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        if (completion) {
            completion(NO);
        }
    }];
}




+ (AFHTTPRequestOperation *)uploadFileWithColumnId:(NSInteger)columnId imagesArr:(NSArray *)imagesArr type:(UploadType)type uploadProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))block completion:(void(^)(NSString *filePath))completion;{
    NSString *cookie = [[UserCenter defaultCenter] userCookie];
    
    
    if (ISEMPTYSTR(cookie)) {
        if (completion) {
            completion(nil);
        }
        return nil;
    }
    
    // 1. Create `AFHTTPRequestSerializer` which will create your request.
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    // 2. Create an `NSMutableURLRequest`.
    NSError *error;
    NSMutableURLRequest *request =
    [serializer multipartFormRequestWithMethod:@"POST"
                                     URLString:[CMSBaseURLString stringByAppendingString:ACTION_SET_UPLOAD]
                                    parameters:nil
                     constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         //上传时使用当前的系统事件作为文件名
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         formatter.dateFormat = @"yyyyMMddHHmmss";
         NSString *str = [formatter stringFromDate:[NSDate date]];
         
         NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
         NSString *mimeType = @"image/jpg";
         if (type == UploadType_Video) {
             fileName = [NSString stringWithFormat:@"%@.mov", str];
             mimeType = @"video/mp4";
         }
         
         /*
          此方法参数
          1. 要上传的[二进制数据]
          2. 对应网站上[upload.php中]处理文件的[字段"file"]
          3. 要保存在服务器上的[文件名]
          4. 上传文件的[mimeType]
          */
         //服务器上传文件的字段和类型
         for (int i = 0; i < imagesArr.count; i++) {
             NSData *data;
             UIImage *image = imagesArr[i];
             if (UIImagePNGRepresentation(image)) {
                 data = UIImagePNGRepresentation(image);
             }else {
                 data = UIImageJPEGRepresentation(image, 0.5);
                 
             }
             
             [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"%@file%i",str,i] fileName:[NSString stringWithFormat:@"%@file%i.jpg",str,i] mimeType:mimeType];
             
         }
         

         

     }
                                         error:&error];
    [request setValue:cookie forHTTPHeaderField:cookieKey];
    
    // 3. Create and use `AFHTTPRequestOperationManager` to create an `AFHTTPRequestOperation` from the `NSMutableURLRequest` that we just created.
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *operation =
    [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject && [responseObject isKindOfClass:[NSDictionary class]])
         {
             id code = [(NSDictionary *)responseObject objectForKey:@"code"];
             if (code && [code integerValue] == 1)
             {
                 NSDictionary *data = [(NSDictionary *)responseObject objectForKey:@"data"];
                 NSString *filePath = [data objectForKey:@"path"];
                 if (completion) {
                     completion(filePath);
                 }
                 return;
             }
         }
         if (completion) {
             completion(nil);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (completion) {
             completion(nil);
         }
     }];
    
    // 4. Set the progress block of the operation.
    [operation setUploadProgressBlock:block];
    
    // 5. Begin!
    [[AFCMSClient sharedClient].operationQueue addOperation:operation];
    return operation;
    
    
}

+ (AFHTTPRequestOperation *)uploadFileWithColumnIdPhil:(NSInteger)columnId item:(UploadItem *)item imagesDataArr:(NSArray *)imagesDataArr type:(UploadType)type uploadProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))block completion:(void(^)(NSString *filePath))completion{
    NSString *cookie = [[UserCenter defaultCenter] userCookie];
    if (ISEMPTYSTR(cookie)) {
        if (completion) {
            completion(nil);
        }
        return nil;
    }
    
    NSDictionary *params;
    if (!item.lon) {
        params = @{@"title":item.content,
                   @"content": item.content,
                   @"type": [NSString stringWithFormat:@"%ld", (long)item.type],
                   @"status":@"1",
                   @"lon":@"0",
                   @"lat":@"0",
                   @"address":@"0",
                   @"columnid": [NSString stringWithFormat:@"%ld", (long)columnId],
                   @"mpno": item.mpno,
                   //                             @"ver":,
                   @"os":@"2",
                   @"project":@""};
    }
    else{
        params = @{@"title":item.content,
                   @"content": item.content,
                   @"type": [NSString stringWithFormat:@"%ld", (long)item.type],
                   @"status":@"1",
                   @"lon":item.lon,
                   @"lat":item.lat,
                   @"address":item.address,
                   @"columnid": [NSString stringWithFormat:@"%ld", (long)columnId],
                   @"mpno": item.mpno,
                   //                             @"ver":,
                   @"os":@"2",
                   @"project":@""};
    }
    
    
    // 1. Create `AFHTTPRequestSerializer` which will create your request.
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    // 2. Create an `NSMutableURLRequest`.
    NSError *error;
    NSMutableURLRequest *request =
    [serializer multipartFormRequestWithMethod:@"POST"
                                     URLString:[CMSBaseURLString stringByAppendingString:ACTION_SET_ATTACHS]
                                    parameters:params
                     constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         //上传时使用当前的系统事件作为文件名
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         formatter.dateFormat = @"yyyyMMddHHmmss";
         NSString *str = [formatter stringFromDate:[NSDate date]];
         NSString *mimeType = @"image/jpg";
         
         /*
          此方法参数
          1. 要上传的[二进制数据]
          2. 对应网站上[upload.php中]处理文件的[字段"file"]
          3. 要保存在服务器上的[文件名]
          4. 上传文件的[mimeType]
          */
         //服务器上传文件的字段和类型
         for (int i = 0; i < imagesDataArr.count; i++) {
             [formData appendPartWithFileData:imagesDataArr[i] name:[NSString stringWithFormat:@"%@file%i",str,i] fileName:[NSString stringWithFormat:@"%@file%i.jpg",str,i] mimeType:mimeType];
         }
         
     }
                                         error:&error];
    [request setValue:cookie forHTTPHeaderField:cookieKey];
    
    // 3. Create and use `AFHTTPRequestOperationManager` to create an `AFHTTPRequestOperation` from the `NSMutableURLRequest` that we just created.
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *operation =
    [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject && [responseObject isKindOfClass:[NSDictionary class]])
         {
             id code = [(NSDictionary *)responseObject objectForKey:@"code"];
             if (code && [code integerValue] == 1){
                 completion(@"1");
             }
             else{
                 completion(@"0");
             }
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         completion(error.description);
     }];
    
    // 4. Set the progress block of the operation.
    [operation setUploadProgressBlock:block];
    
    // 5. Begin!
    [[AFCMSClient sharedClient].operationQueue addOperation:operation];
    return operation;
    
}


+ (AFHTTPRequestOperation *)uploadFileWithColumnIdPhil:(NSInteger)columnId item:(UploadItem *)item imagesArr:(NSArray *)imagesArr type:(UploadType)type uploadProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))block completion:(void(^)(NSString *filePath))completion{
    NSString *cookie = [[UserCenter defaultCenter] userCookie];
    if (ISEMPTYSTR(cookie)) {
        if (completion) {
            completion(nil);
        }
        return nil;
    }
    
    NSDictionary *params = @{@"title":item.content,
                             @"content": item.content,
                             @"type": [NSString stringWithFormat:@"%ld", (long)item.type],
                             @"status":@"1",
                             @"lon":item.lon,
                             @"lat":item.lat,
                             @"address":item.address,
                             @"columnid": [NSString stringWithFormat:@"%ld", (long)columnId],
                             @"mpno": item.mpno,
                             //                             @"ver":,
                             @"os":@"2",
                             @"project":@""};
    
    
    // 1. Create `AFHTTPRequestSerializer` which will create your request.
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    // 2. Create an `NSMutableURLRequest`.
    NSError *error;
    NSMutableURLRequest *request =
    [serializer multipartFormRequestWithMethod:@"POST"
                                     URLString:[CMSBaseURLString stringByAppendingString:ACTION_SET_ATTACHS]
                                    parameters:params
                     constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         //上传时使用当前的系统事件作为文件名
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         formatter.dateFormat = @"yyyyMMddHHmmss";
         NSString *str = [formatter stringFromDate:[NSDate date]];
         NSString *mimeType = @"image/jpg";
         
         /*
          此方法参数
          1. 要上传的[二进制数据]
          2. 对应网站上[upload.php中]处理文件的[字段"file"]
          3. 要保存在服务器上的[文件名]
          4. 上传文件的[mimeType]
          */
         //服务器上传文件的字段和类型
         for (int i = 0; i < imagesArr.count; i++) {
             NSData *data;
             UIImage *image = imagesArr[i];
             if (UIImagePNGRepresentation(image)) {
                 data = UIImagePNGRepresentation(image);
             }else {
                 data = UIImageJPEGRepresentation(image, 0.5);
                 
             }
             
             [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"%@file%i",str,i] fileName:[NSString stringWithFormat:@"%@file%i.jpg",str,i] mimeType:mimeType];
             
         }

     }
                                         error:&error];
    [request setValue:cookie forHTTPHeaderField:cookieKey];
    
    // 3. Create and use `AFHTTPRequestOperationManager` to create an `AFHTTPRequestOperation` from the `NSMutableURLRequest` that we just created.
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *operation =
    [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject && [responseObject isKindOfClass:[NSDictionary class]])
         {
             id code = [(NSDictionary *)responseObject objectForKey:@"code"];
             if (code && [code integerValue] == 1){
                 completion(@"1");
             }
             else{
                 completion(@"0");
             }
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         completion(error.description);
     }];
    
    // 4. Set the progress block of the operation.
    [operation setUploadProgressBlock:block];
    
    // 5. Begin!
    [[AFCMSClient sharedClient].operationQueue addOperation:operation];
    return operation;

}
+ (AFHTTPRequestOperation *)uploadFileWithColumnIdPhil:(NSInteger)columnId item:(UploadItem *)item data:(NSData *)data type:(UploadType)type uploadProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))block completion:(void(^)(NSString *philTest))completion{
    
    NSString *cookie = [[UserCenter defaultCenter] userCookie];
    if (ISEMPTYSTR(cookie)) {
        if (completion) {
            completion(nil);
        }
        return nil;
    }
    NSDictionary *params;
    if (!item.lon) {
        params = @{@"title":item.content,
                   @"content": item.content,
                   @"type": [NSString stringWithFormat:@"%ld", (long)item.type],
                   @"status":@"1",
                   @"lon":@"0",
                   @"lat":@"0",
                   @"address":@"0",
                   @"columnid": [NSString stringWithFormat:@"%ld", (long)columnId],
                   @"mpno": item.mpno,
                   //                             @"ver":,
                   @"os":@"2",
                   @"project":@""};
    }
    else{
        params = @{@"title":item.content,
                   @"content": item.content,
                   @"type": [NSString stringWithFormat:@"%ld", (long)item.type],
                   @"status":@"1",
                   @"lon":item.lon,
                   @"lat":item.lat,
                   @"address":item.address,
                   @"columnid": [NSString stringWithFormat:@"%ld", (long)columnId],
                   @"mpno": item.mpno,
                   //                             @"ver":,
                   @"os":@"2",
                   @"project":@""};
    }
    
    // 1. Create `AFHTTPRequestSerializer` which will create your request.
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    // 2. Create an `NSMutableURLRequest`.
    
    NSError *error;
    NSMutableURLRequest *request =
    [serializer multipartFormRequestWithMethod:@"POST"
                                     URLString:[CMSBaseURLString stringByAppendingString:ACTION_SET_ATTACHS]
                                    parameters:params
                     constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         //上传时使用当前的系统事件作为文件名
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         formatter.dateFormat = @"yyyyMMddHHmmss";
         NSString *str = [formatter stringFromDate:[NSDate date]];
         
         NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
         NSString *mimeType = @"image/jpg";
         if (type == UploadType_Video) {
             fileName = [NSString stringWithFormat:@"%@.mov", str];
             mimeType = @"video/mp4";
         }
         
         /*
          此方法参数
          1. 要上传的[二进制数据]
          2. 对应网站上[upload.php中]处理文件的[字段"file"]
          3. 要保存在服务器上的[文件名]
          4. 上传文件的[mimeType]
          */
         //服务器上传文件的字段和类型
         
         [formData appendPartWithFileData:data name:str fileName:fileName mimeType:mimeType];
     }
                                         error:&error];
    [request setValue:cookie forHTTPHeaderField:cookieKey];
    
    // 3. Create and use `AFHTTPRequestOperationManager` to create an `AFHTTPRequestOperation` from the `NSMutableURLRequest` that we just created.
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *operation =
    [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject && [responseObject isKindOfClass:[NSDictionary class]])
         {
             id code = [(NSDictionary *)responseObject objectForKey:@"code"];
             if (code && [code integerValue] == 1){
                 completion(@"1");
             }
             else{
                 completion(@"0");
             }
         }

     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"error = %@",error.description);
     }];
    
    // 4. Set the progress block of the operation.
    [operation setUploadProgressBlock:block];
    
    // 5. Begin!
    [[AFCMSClient sharedClient].operationQueue addOperation:operation];
    return operation;
    
    
}


+ (AFHTTPRequestOperation *)uploadFileWithColumnId:(NSInteger)columnId data:(NSData *)data type:(UploadType)type uploadProgressBlock:(void (^)(NSUInteger, long long, long long))block completion:(void (^)(NSString *))completion
{
    NSString *cookie = [[UserCenter defaultCenter] userCookie];
    if (ISEMPTYSTR(cookie)) {
        if (completion) {
            completion(nil);
        }
        return nil;
    }
    
    // 1. Create `AFHTTPRequestSerializer` which will create your request.
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    // 2. Create an `NSMutableURLRequest`.
    NSError *error;
    NSMutableURLRequest *request =
    [serializer multipartFormRequestWithMethod:@"POST"
                                     URLString:[CMSBaseURLString stringByAppendingString:ACTION_SET_UPLOAD]
                                    parameters:nil
                     constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         //上传时使用当前的系统事件作为文件名
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         formatter.dateFormat = @"yyyyMMddHHmmss";
         NSString *str = [formatter stringFromDate:[NSDate date]];
         
         NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
         NSString *mimeType = @"image/jpg";
         if (type == UploadType_Video) {
             fileName = [NSString stringWithFormat:@"%@.mov", str];
             mimeType = @"video/mp4";
         }
         
         /*
          此方法参数
          1. 要上传的[二进制数据]
          2. 对应网站上[upload.php中]处理文件的[字段"file"]
          3. 要保存在服务器上的[文件名]
          4. 上传文件的[mimeType]
          */
         //服务器上传文件的字段和类型
         
         [formData appendPartWithFileData:data name:str fileName:fileName mimeType:mimeType];
     }
                                         error:&error];
    [request setValue:cookie forHTTPHeaderField:cookieKey];
    
    // 3. Create and use `AFHTTPRequestOperationManager` to create an `AFHTTPRequestOperation` from the `NSMutableURLRequest` that we just created.
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *operation =
    [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]])
        {
            id code = [(NSDictionary *)responseObject objectForKey:@"code"];
            if (code && [code integerValue] == 1)
            {
                NSDictionary *data = [(NSDictionary *)responseObject objectForKey:@"data"];
                NSString *filePath = [data objectForKey:@"path"];
                if (completion) {
                    completion(filePath);
                }
                return;
            }
        }
        if (completion) {
            completion(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            completion(nil);
        }
    }];
    
    // 4. Set the progress block of the operation.
    [operation setUploadProgressBlock:block];
    
    // 5. Begin!
    [[AFCMSClient sharedClient].operationQueue addOperation:operation];
    return operation;
}

+ (AFHTTPRequestOperation *)uploadLiveCoverWithLiveID:(NSString *)lid data:(NSData *)data uploadProgressBlock:(void (^)(NSUInteger, long long, long long))block completion:(void (^)(BOOL))completion
{
    NSString *cookie = [[UserCenter defaultCenter] userCookie];
    if (ISEMPTYSTR(cookie)) {
        if (completion) {
            completion(NO);
        }
        return nil;
    }
    
    // 1. Create `AFHTTPRequestSerializer` which will create your request.
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            lid, @"_id",
                            REVIEW_VER, VER_KEY,
                            OS_VERSION, OS_KEY,
                            PROJECT_ID, PROJECT_KEY, nil];
    
    // 2. Create an `NSMutableURLRequest`.
    NSString *path = [CMSBaseURLString stringByAppendingString:@"lives/set_lives_attachs"];
    NSError *error;
    NSMutableURLRequest *request =
    [serializer multipartFormRequestWithMethod:@"POST"
                                     URLString:path
                                    parameters:params
                     constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         //上传时使用当前的系统事件作为文件名
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         formatter.dateFormat = @"yyyyMMddHHmmss";
         NSString *str = [formatter stringFromDate:[NSDate date]];
         
         NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
         NSString *mimeType = @"image/jpg";
         /*
          此方法参数
          1. 要上传的[二进制数据]
          2. 对应网站上[upload.php中]处理文件的[字段"file"]
          3. 要保存在服务器上的[文件名]
          4. 上传文件的[mimeType]
          */
         //服务器上传文件的字段和类型
         
         [formData appendPartWithFileData:data name:str fileName:fileName mimeType:mimeType];
     }
                                         error:&error];
    [request setValue:cookie forHTTPHeaderField:cookieKey];
    
    // 3. Create and use `AFHTTPRequestOperationManager` to create an `AFHTTPRequestOperation` from the `NSMutableURLRequest` that we just created.
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *operation =
    [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]])
        {
            id code = [(NSDictionary *)responseObject objectForKey:@"code"];
            if (code && [code integerValue] == 1)
            {
                if (completion) {
                    completion(YES);
                }
                return;
            }
        }
        if (completion) {
            completion(NO);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (completion) {
            completion(NO);
        }
    }];
    
    // 4. Set the progress block of the operation.
    [operation setUploadProgressBlock:block];
    
    // 5. Begin!
    [[AFCMSClient sharedClient].operationQueue addOperation:operation];
    return operation;
}

+ (AFHTTPRequestOperation *)uploadLiveWithLiveID:(NSString *)lid title:(NSString *)title description:(NSString *)description tagName:(NSString *)tagName tagType:(NSInteger)tagType cover:(NSString *)cover vodData:(NSData *)vodData uploadProgressBlock:(void (^)(NSUInteger, long long, long long))block completion:(void (^)(BOOL))completion
{
    NSString *cookie = [[UserCenter defaultCenter] userCookie];
    if (ISEMPTYSTR(cookie)) {
        if (completion) {
            completion(NO);
        }
        return nil;
    }
    
    // 1. Create `AFHTTPRequestSerializer` which will create your request.
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [UserCenter defaultCenter].currentUser.mpno, @"mpno",
                                   [UserCenter defaultCenter].currentUser.headImgUri, @"face",
                                   [UserCenter defaultCenter].currentUser.nickName, @"nickname",
                                   title, @"title",
                                   description, @"desc",
                                   tagName, @"columnsname",
                                   @(tagType), @"columnstype",
                                   cover, @"pics",
                                   REVIEW_VER, VER_KEY,
                                   OS_VERSION, OS_KEY,
                                   PROJECT_ID, PROJECT_KEY, nil];
    if (!ISEMPTYSTR(lid)) {
        [params setObject:lid forKey:@"_id"];
    }
    
    // 2. Create an `NSMutableURLRequest`.
    NSString *path = [CMSBaseURLString stringByAppendingString:@"lives/set_vod"];
    NSError *error;
    NSMutableURLRequest *request =
    [serializer multipartFormRequestWithMethod:@"POST"
                                     URLString:path
                                    parameters:params
                     constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         //上传时使用当前的系统事件作为文件名
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         formatter.dateFormat = @"yyyyMMddHHmmss";
         NSString *str = [formatter stringFromDate:[NSDate date]];
         
         NSString *fileName = [NSString stringWithFormat:@"%@.mov", str];
         NSString *mimeType = @"video/mp4";
         
         /*
          此方法参数
          1. 要上传的[二进制数据]
          2. 对应网站上[upload.php中]处理文件的[字段"file"]
          3. 要保存在服务器上的[文件名]
          4. 上传文件的[mimeType]
          */
         //服务器上传文件的字段和类型
         
         [formData appendPartWithFileData:vodData name:str fileName:fileName mimeType:mimeType];
     }
                                         error:&error];
    [request setValue:cookie forHTTPHeaderField:cookieKey];
    
    // 3. Create and use `AFHTTPRequestOperationManager` to create an `AFHTTPRequestOperation` from the `NSMutableURLRequest` that we just created.
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *operation =
    [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject && [responseObject isKindOfClass:[NSDictionary class]])
         {
             id code = [(NSDictionary *)responseObject objectForKey:@"code"];
             if (code && [code integerValue] == 1)
             {
                 if (completion) {
                     completion(YES);
                 }
                 return;
             }
         }
         if (completion) {
             completion(NO);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         if (completion) {
             completion(NO);
         }
     }];
    
    // 4. Set the progress block of the operation.
    [operation setUploadProgressBlock:block];
    
    // 5. Begin!
    [[AFCMSClient sharedClient].operationQueue addOperation:operation];
    return operation;
}

@end
