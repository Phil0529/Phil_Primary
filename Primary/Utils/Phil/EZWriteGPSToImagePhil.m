//
//  EZWriteGPSToImagePhil.m
//  EZTV
//
//  Created by 肖翰程 on 15/9/13.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "EZWriteGPSToImagePhil.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation EZWriteGPSToImagePhil

//*

- (UIImage *)philGetOrignalImageWithURL:(NSURL *)imgAssetURL{
    __block UIImage *orignalImage = [UIImage new];
    
    dispatch_semaphore_t getImg = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_queue_create("Phil_Get_Img_Data", DISPATCH_QUEUE_SERIAL);
    ALAssetsLibrary *lib = [ALAssetsLibrary new];
    dispatch_async(queue, ^{
        [lib assetForURL:imgAssetURL resultBlock:^(ALAsset *asset) {
            orignalImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
            dispatch_semaphore_signal(getImg);
            
        } failureBlock:^(NSError *error) {
            dispatch_semaphore_signal(getImg);
        }];
    });
    dispatch_semaphore_wait(getImg, DISPATCH_TIME_FOREVER);
    return orignalImage;
}

// */

- (NSData *)philGetImgDataWithURL:(NSURL *)imgAssetURL andLocation:(NSDictionary *)locationDict{
    
    __block NSData *imgData = [NSData new];
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_queue_create("Phil_Modify_GPS_Information", DISPATCH_QUEUE_SERIAL);
    ALAssetsLibrary *lib = [[ALAssetsLibrary alloc]init];
    //    [self getGPSLocation];
    dispatch_async(queue, ^{
        [lib assetForURL:imgAssetURL resultBlock:^(ALAsset *asset) {
            ALAssetRepresentation *assetRep = [asset defaultRepresentation];
            CGImageRef imgRef = [assetRep fullScreenImage];
            UIImage *editedImage = [UIImage imageWithCGImage:imgRef];
            if (!locationDict || [locationDict allKeys].count == 0){
                imgData = UIImageJPEGRepresentation(editedImage, 0.5);
            }
            else{
                NSData *imageNSData = UIImageJPEGRepresentation(editedImage,0.5);
                CGImageSourceRef imgSource = CGImageSourceCreateWithData(( CFDataRef)imageNSData, NULL);
                NSDictionary *metadata = ( NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(imgSource, 0, NULL));
                
                //make the metadata dictionary mutable so we can add properties to it
                NSMutableDictionary *metadataAsMutable = [metadata mutableCopy];
                NSMutableDictionary *EXIFDictionary = [[metadataAsMutable objectForKey:(NSString *)kCGImagePropertyExifDictionary]mutableCopy];
                NSMutableDictionary *GPSDictionary = [[metadataAsMutable objectForKey:(NSString *)kCGImagePropertyGPSDictionary]mutableCopy];
                NSMutableDictionary *RAWDictionary = [[metadataAsMutable objectForKey:(NSString *)kCGImagePropertyRawDictionary]mutableCopy];
                
                if(!EXIFDictionary)
                    EXIFDictionary = [[NSMutableDictionary dictionary] init];
                
                if(!GPSDictionary)
                    GPSDictionary = [[NSMutableDictionary dictionary] init];
                
                if(!RAWDictionary)
                    RAWDictionary = [[NSMutableDictionary dictionary] init];
                
                [GPSDictionary setObject:[NSNumber numberWithDouble:[[locationDict objectForKey:@"Latitude"] floatValue]]
                                  forKey:(NSString*)kCGImagePropertyGPSLatitude];
                
                [GPSDictionary setObject:[locationDict objectForKey:@"LatitudeRef"] forKey:(NSString*)kCGImagePropertyGPSLatitudeRef];
                
                [GPSDictionary setObject:[NSNumber numberWithDouble:[[locationDict objectForKey:@"Longitude"] floatValue]]
                                  forKey:(NSString*)kCGImagePropertyGPSLongitude];
                
                [GPSDictionary setObject:[locationDict objectForKey:@"LongitudeRef"] forKey:(NSString*)kCGImagePropertyGPSLongitudeRef];
                
                [GPSDictionary setObject:[NSString stringWithFormat:@"%@ %@",[locationDict objectForKey:@"DateStamp"],[locationDict objectForKey:@"TimeStamp"]]
                                  forKey:(NSString*)kCGImagePropertyGPSDateStamp];
                
                [GPSDictionary setObject:[NSNumber numberWithFloat:300]
                                  forKey:(NSString*)kCGImagePropertyGPSImgDirection];
                
                [GPSDictionary setObject:[NSNumber numberWithFloat:37.795]
                                  forKey:(NSString*)kCGImagePropertyGPSDestLatitude];
                
                [GPSDictionary setObject:[locationDict objectForKey:@"LatitudeRef"] forKey:(NSString*)kCGImagePropertyGPSDestLatitudeRef];
                
                [GPSDictionary setObject:[NSNumber numberWithFloat:122.410]
                                  forKey:(NSString*)kCGImagePropertyGPSDestLongitude];
                
                [GPSDictionary setObject:[locationDict objectForKey:@"LongitudeRef"] forKey:(NSString*)kCGImagePropertyGPSDestLongitudeRef];
                
                [EXIFDictionary setObject:@"[S.D.] kCGImagePropertyExifUserComment"
                                   forKey:(NSString *)kCGImagePropertyExifUserComment];
                [EXIFDictionary setObject:@"1" forKey:(NSString *)kCGImagePropertyOrientation];
                
                [EXIFDictionary setObject:[NSNumber numberWithFloat:69.999]
                                   forKey:(NSString*)kCGImagePropertyExifSubjectDistance];
                
                
                //Add the modified Data back into the image’s metadata
                [metadataAsMutable setObject:EXIFDictionary forKey:(NSString *)kCGImagePropertyExifDictionary];
                [metadataAsMutable setObject:GPSDictionary forKey:(NSString *)kCGImagePropertyGPSDictionary];
                [metadataAsMutable setObject:RAWDictionary forKey:(NSString *)kCGImagePropertyRawDictionary];
                
                
                CFStringRef UTI = CGImageSourceGetType(imgSource); //this is the type of image (e.g., public.jpeg)
                
                //this will be the data CGImageDestinationRef will write into
                NSMutableData *newImageData = [NSMutableData data];
                
                CGImageDestinationRef destination = CGImageDestinationCreateWithData(( CFMutableDataRef)newImageData, UTI, 1, NULL);
                
                if(!destination)
                    NSLog(@"***Could not create image destination ***");
                
                //add the image contained in the image source to the destination, overidding the old metadata with our modified metadata
                CGImageDestinationAddImageFromSource(destination, imgSource, 0, ( CFDictionaryRef) metadataAsMutable);
                
                //tell the destination to write the image data and metadata into our data object.
                //It will return false if something goes wrong
                BOOL success = NO;
                success = CGImageDestinationFinalize(destination);
                
                if(!success)
                    NSLog(@"***Could not create data from image destination ***");
                
                imgData = newImageData;
            }
            //发出已完成的信号
            dispatch_semaphore_signal(sema);
        }
         
            failureBlock:^(NSError *error) {
                NSLog(@"error = %@",error.description);
                dispatch_semaphore_signal(sema);
            }];
        
    });
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    return imgData;
    
}

+ (NSData *)philGetImgDataWithImage:(UIImage *)editedImage andLocation:(NSDictionary *)locationDict{
    
    if (!locationDict || [locationDict allKeys].count == 0){
        return  UIImageJPEGRepresentation(editedImage, 0.5);
    }
    else{
        NSData *imageNSData = UIImageJPEGRepresentation(editedImage,0.5);
        CGImageSourceRef imgSource = CGImageSourceCreateWithData(( CFDataRef)imageNSData, NULL);
        NSDictionary *metadata = ( NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(imgSource, 0, NULL));
        
        //make the metadata dictionary mutable so we can add properties to it
        NSMutableDictionary *metadataAsMutable = [metadata mutableCopy];
        NSMutableDictionary *EXIFDictionary = [[metadataAsMutable objectForKey:(NSString *)kCGImagePropertyExifDictionary]mutableCopy];
        NSMutableDictionary *GPSDictionary = [[metadataAsMutable objectForKey:(NSString *)kCGImagePropertyGPSDictionary]mutableCopy];
        NSMutableDictionary *RAWDictionary = [[metadataAsMutable objectForKey:(NSString *)kCGImagePropertyRawDictionary]mutableCopy];
        
        if(!EXIFDictionary)
            EXIFDictionary = [[NSMutableDictionary dictionary] init];
        
        if(!GPSDictionary)
            GPSDictionary = [[NSMutableDictionary dictionary] init];
        
        if(!RAWDictionary)
            RAWDictionary = [[NSMutableDictionary dictionary] init];
        
        [GPSDictionary setObject:[NSNumber numberWithDouble:[[locationDict objectForKey:@"Latitude"] floatValue]]
                          forKey:(NSString*)kCGImagePropertyGPSLatitude];
        
        [GPSDictionary setObject:[locationDict objectForKey:@"LatitudeRef"] forKey:(NSString*)kCGImagePropertyGPSLatitudeRef];
        
        [GPSDictionary setObject:[NSNumber numberWithDouble:[[locationDict objectForKey:@"Longitude"] floatValue]]
                          forKey:(NSString*)kCGImagePropertyGPSLongitude];
        
        [GPSDictionary setObject:[locationDict objectForKey:@"LongitudeRef"] forKey:(NSString*)kCGImagePropertyGPSLongitudeRef];
        
        [GPSDictionary setObject:[NSString stringWithFormat:@"%@ %@",[locationDict objectForKey:@"DateStamp"],[locationDict objectForKey:@"TimeStamp"]]
                          forKey:(NSString*)kCGImagePropertyGPSDateStamp];
        
        [GPSDictionary setObject:[NSNumber numberWithFloat:300]
                          forKey:(NSString*)kCGImagePropertyGPSImgDirection];
        
        [GPSDictionary setObject:[NSNumber numberWithFloat:37.795]
                          forKey:(NSString*)kCGImagePropertyGPSDestLatitude];
        
        [GPSDictionary setObject:[locationDict objectForKey:@"LatitudeRef"] forKey:(NSString*)kCGImagePropertyGPSDestLatitudeRef];
        
        [GPSDictionary setObject:[NSNumber numberWithFloat:122.410]
                          forKey:(NSString*)kCGImagePropertyGPSDestLongitude];
        
        [GPSDictionary setObject:[locationDict objectForKey:@"LongitudeRef"] forKey:(NSString*)kCGImagePropertyGPSDestLongitudeRef];
        
        [EXIFDictionary setObject:@"[S.D.] kCGImagePropertyExifUserComment"
                           forKey:(NSString *)kCGImagePropertyExifUserComment];
        [EXIFDictionary setObject:@"1" forKey:(NSString *)kCGImagePropertyOrientation];
        
        [EXIFDictionary setObject:[NSNumber numberWithFloat:69.999]
                           forKey:(NSString*)kCGImagePropertyExifSubjectDistance];
        
        
        //Add the modified Data back into the image’s metadata
        [metadataAsMutable setObject:EXIFDictionary forKey:(NSString *)kCGImagePropertyExifDictionary];
        [metadataAsMutable setObject:GPSDictionary forKey:(NSString *)kCGImagePropertyGPSDictionary];
        [metadataAsMutable setObject:RAWDictionary forKey:(NSString *)kCGImagePropertyRawDictionary];
        
        
        CFStringRef UTI = CGImageSourceGetType(imgSource); //this is the type of image (e.g., public.jpeg)
        
        //this will be the data CGImageDestinationRef will write into
        NSMutableData *newImageData = [NSMutableData data];
        
        CGImageDestinationRef destination = CGImageDestinationCreateWithData(( CFMutableDataRef)newImageData, UTI, 1, NULL);
        
        if(!destination)
            NSLog(@"***Could not create image destination ***");
        
        //add the image contained in the image source to the destination, overidding the old metadata with our modified metadata
        CGImageDestinationAddImageFromSource(destination, imgSource, 0, ( CFDictionaryRef) metadataAsMutable);
        
        //tell the destination to write the image data and metadata into our data object.
        //It will return false if something goes wrong
        BOOL success = NO;
        success = CGImageDestinationFinalize(destination);
        
        if(!success)
            NSLog(@"***Could not create data from image destination ***");
        
        
        return  newImageData;
    }
    
}
//- (NSString *)getTimeNow
//{
//    NSString* date;
//
//    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
//    //[formatter setDateFormat:@"YYYY.MM.dd.hh.mm.ss"];
//    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
//    date = [formatter stringFromDate:[NSDate date]];
//    NSString*timeNow = [[NSString alloc] initWithFormat:@"%@", date];
//    return timeNow;
//}

@end
