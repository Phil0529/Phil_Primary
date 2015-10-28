//
//  UploadPicsVC.m
//  Primary
//
//  Created by Phil Xhc on 15/10/27.
//  Copyright © 2015年 Xhc. All rights reserved.
//

#import "UploadPicsVC.h"
#import "UploadPicsView.h"
#import "EZColumnItem.h"

//Location
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CLLocation+GPSDictionary.h"

@interface UploadPicsVC ()<MKMapViewDelegate,CLLocationManagerDelegate>
{
    EZColumnItem *_columnItem;
    MKMapView *_mapView;
    CLGeocoder *_geocoder;
    CLLocationManager *_locationManager;
    MKPlacemark *_placeMark;
    NSMutableDictionary *_locationDict;
    
    UploadPicsView *_view;

}

@end



@implementation UploadPicsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getGPSLocationUPVC];
    NSArray *arr = [UIFont familyNames];
    
    [self philInitPageUPVC];
    [self philInitUIUPVC];
}

- (void)philInitPageUPVC{
    [self.view setBackgroundColor:BACKGROUND_COLOR];
//    [self setTitle:LBLocalized(@"live_upload")];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets =NO;
    }
    
//    _imagesArr = [NSMutableArray arrayWithCapacity:8];
    _locationDict = [NSMutableDictionary new];
}
- (void)philInitUIUPVC{
    _view = [[UploadPicsView alloc]initWithFrame:CGRectMake(0.f, NAVBAR_HEIGHT + STATUSBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT)];
    _view.backgroundColor = BACKGROUND_COLOR;
    [self.view addSubview:_view];
}

- (instancetype)initWithColumnItem:(EZColumnItem *)columnItem
{
    self = [super init];
    if (self) {
        _columnItem = columnItem;
    }
    return self;
}










- (void)getGPSLocationUPVC{
    _mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    [_mapView setShowsUserLocation:YES];
    [_mapView setHidden:YES];
    
    _locationManager = [[CLLocationManager alloc] init];
    if (IS_OS_8_OR_LATER) {
        [_locationManager requestWhenInUseAuthorization];
    }
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager startUpdatingLocation];
    _geocoder = [[CLGeocoder alloc] init];
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    [_locationManager stopUpdatingLocation];
    
    [_locationDict addEntriesFromDictionary:[newLocation GPSDictionary]];
    
    [_geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        _placeMark = [placemarks objectAtIndex:0];
//        _locaLabel.text = [_placeMark.addressDictionary objectForKey:@"Name"];
        [_locationDict addEntriesFromDictionary:_placeMark.addressDictionary];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
