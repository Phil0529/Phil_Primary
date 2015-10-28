//
//  MTLModel+KTVNullableScalar.m
//  EZTV
//
//  Created by Sunni on 15/6/23.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "MTLModel+KTVNullableScalar.h"

@implementation MTLModel (KTVNullableScalar)

- (void)setNilValueForKey:(NSString *)key {
    [self setValue:@0 forKey:key];// For NSInteger/CGFloat/BOOL
}

@end
