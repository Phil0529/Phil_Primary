//
//  JKAssets.m
//  JKImagePicker
//
//  Created by Jecky on 15/1/13.
//  Copyright (c) 2015年 Jecky. All rights reserved.
//

#import "JKAssets.h"

NSString *const kJKPickerGroupPropertyID    = @"kJKPickerGroupPropertyID";
NSString *const kJKPickerGroupPropertyURL   = @"kJKPickerGroupPropertyURL";
NSString *const kJKPickerAssetPropertyURL   = @"kJKPickerAssetPropertyURL";
NSString *const KJKPickerThumbImg           = @"kJKPickerThumbImg";
NSString *const KJKPickerRealImg            = @"kJKPickerRealImg";
NSString *const KJKPickerMetadataDict       = @"kJKPickerMetadaDict";
//NSString *const KJKPickerEventuallyImgData  = @"kJKPickerEvetuallyImgData";

@implementation JKAssets


//NSCoding协议.
#pragma mark - NSCoding


-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.groupPropertyID    = [aDecoder decodeObjectForKey:kJKPickerGroupPropertyID];
        self.groupPropertyURL   = [aDecoder decodeObjectForKey:kJKPickerGroupPropertyURL];
        self.assetPropertyURL   = [aDecoder decodeObjectForKey:kJKPickerAssetPropertyURL];
        self.thumbImg           = [aDecoder decodeObjectForKey:KJKPickerThumbImg];
        self.metaDict           = [aDecoder decodeObjectForKey:KJKPickerMetadataDict];
//        self.realImg            = [aDecoder decodeObjectForKey:KJKPickerRealImg];
//        self.imgData            = [aDecoder decodeObjectForKey:KJKPickerEventuallyImgData];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_groupPropertyID forKey:kJKPickerGroupPropertyID];
    [aCoder encodeObject:_groupPropertyURL forKey:kJKPickerGroupPropertyURL];
    [aCoder encodeObject:_assetPropertyURL forKey:kJKPickerAssetPropertyURL];
    [aCoder encodeObject:_thumbImg forKey:KJKPickerThumbImg];
    [aCoder encodeObject:_metaDict forKey:KJKPickerMetadataDict];
//    [aCoder encodeObject:_realImg forKey:KJKPickerRealImg];
//    [aCoder encodeObject:_imgData forKey:KJKPickerEventuallyImgData];
}


@end
