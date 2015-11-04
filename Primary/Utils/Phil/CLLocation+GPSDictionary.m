//
//  CLLocation+GPSDictionary.m
//  TravelNote
//
//  Created by liu  on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CLLocation+GPSDictionary.h"

@implementation CLLocation (GPSDictionary)

-(NSDictionary*)GPSDictionary{
    NSTimeZone    *timeZone   = [NSTimeZone timeZoneWithName:@"CCT"];
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init]; 
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"HH:mm:ss.SS"];
    
    NSTimeZone *dateZone = [NSTimeZone timeZoneWithName:@"CCT"];
    NSDateFormatter *dateFormtter=[[NSDateFormatter alloc] init];
    [dateFormtter setTimeZone:dateZone];
    [dateFormtter setDateFormat:@"yyyy-MM-dd"];
    
    CLLocation *location=self;
    NSDictionary *gpsDict   = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithDouble:fabs(location.coordinate.latitude)], kCGImagePropertyGPSLatitude,
                               ((location.coordinate.latitude >= 0) ? @"N" : @"S"), kCGImagePropertyGPSLatitudeRef,
                               [NSNumber numberWithDouble:fabs(location.coordinate.longitude)], kCGImagePropertyGPSLongitude,
                               ((location.coordinate.longitude >= 0) ? @"E" : @"W"), kCGImagePropertyGPSLongitudeRef,
                               [formatter stringFromDate:[location timestamp]], kCGImagePropertyGPSTimeStamp,
                               [dateFormtter stringFromDate:[location timestamp]],kCGImagePropertyGPSDateStamp,
                               
                               nil];
    return gpsDict;
}




@end
