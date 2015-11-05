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

#import "FSMediaPicker.h"
#import "UIImage+Function.h"
#import "JKAssets.h"

//Location
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CLLocation+GPSDictionary.h"

typedef NS_ENUM(NSUInteger, UploadType)
{
    UploadType_Image = 1,
    UploadType_Video = 2,
};


@interface UploadPicsVC ()<MKMapViewDelegate,CLLocationManagerDelegate,UploadPicsVCDelegate,FSMediaPickerDelegate>
{
    EZColumnItem *_columnItem;
    MKMapView *_mapView;
    CLGeocoder *_geocoder;
    CLLocationManager *_locationManager;
    MKPlacemark *_placeMark;
    NSMutableDictionary *_locationDict;
    
    
    NSInteger _selectImgCount;
    NSInteger _uplpoadType;
    
    UploadType _uploadType;
}

@property (nonatomic, strong) UploadPicsView *mainView;
@property (nonatomic, strong) NSMutableArray *imagesArr;

@end



@implementation UploadPicsVC

- (instancetype)initWithColumnItem:(EZColumnItem *)columnItem
{
    self = [super init];
    if (self) {
        _columnItem = columnItem;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getGPSLocationUPVC];
    [self philInitPageUPVC];
    [self philInitUIUPVC];
}

- (void)philInitPageUPVC{
    [self.view setBackgroundColor:BACKGROUND_COLOR];
    [self setTitle:LBLocalized(@"upload")];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets =NO;
    }
    
    //    _imagesArr = [NSMutableArray arrayWithCapacity:8];
    
    _locationDict = [NSMutableDictionary new];
}
- (void)philInitUIUPVC{
//    self.mainView.frame = CGRectMake(0.f, NAVBAR_HEIGHT + STATUSBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT);
    self.mainView.backgroundColor = BACKGROUND_COLOR;
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
}
//




#pragma mark UploadPicsViewDelegate
- (void)addPics:(UIButton *)btn{
    FSMediaPicker *mediaPicker = [[FSMediaPicker alloc]init];
    mediaPicker.imageCount = _selectImgCount;
    mediaPicker.mediaType = FSMediaTypeAll;
    mediaPicker.imagePickerMax = MaxImageCount;
    mediaPicker.editMode = FSEditModeStandard;
    mediaPicker.upLoadMultiImageStatus = YES;
    mediaPicker.delegate = self;
    [mediaPicker showFromView:btn];

}
- (void)uploadPics:(UIButton *)btn{
    
}
- (void)selectAgreement:(UIButton *)btn{
    
}

- (void)removeImage:(NSInteger )imageTag{
    [self.imagesArr removeObjectAtIndex:imageTag];
    [_mainView refreshView:self.imagesArr.count andImageData:self.imagesArr];
    
    
}


#pragma mark FSMediaPickerDelegate
- (void)mediaPicker:(FSMediaPicker *)mediaPicker didFinishWithMediaInfo:(NSDictionary *)mediaInfo{
    if ([[mediaInfo objectForKey:@"mediaInfoType"] isEqualToString:FSMediaInfoTakePhoto]) {
        UIImage *thumbImg = [self getOriginImage:[mediaInfo originalImage] scaleToSize:CGSizeMake(157.f, 157.f)];
        _uploadType = UploadType_Image;
        NSDictionary *dictTakePhoto = @{@"originalImage":[mediaInfo originalImage],
                                        @"thumbImage":thumbImg,
                                        @"mediaInfoType":FSMediaInfoTakePhoto};
        [self.imagesArr addObject:dictTakePhoto];
        
    }
    if ([[mediaInfo objectForKey:@"mediaInfoType"] isEqualToString:FSMediaInfoTypePhotoAlbum]) {
        _uploadType = UploadType_Image;
        for (JKAssets *asset in [mediaInfo objectForKey:UIImagePickerControllerMultiImages]) {
            NSDictionary *dict =  @{@"thumbImage":asset.thumbImg,
                                    @"imageURL":asset.assetPropertyURL,
                                    @"mediaInfoType":FSMediaInfoTypePhotoAlbum};
            [self.imagesArr addObject:dict];
        }
        
    }
    if ([[mediaInfo objectForKey:@"mediaInfoType"] isEqualToString:FSMediaInfoTypeVedio]) {
        [_imagesArr removeAllObjects];
        [self.mainView.thumBgView.subviews  makeObjectsPerformSelector:@selector(removeFromSuperview)];
        _uploadType = UploadType_Video;
        UIImageView *playIcon = [[UIImageView alloc] initWithImage:IMAGE(@"video_icon")];
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(THUMBSPACING, THUMBSPACING, BTNADD_WIDITH, BTNADD_WIDITH)];
        [playIcon setCenter:CGPointMake(CGRectGetWidth(imgView.frame)/2, CGRectGetHeight(imgView.frame)/2)];
        [imgView setImage:[UIImage thumbnailImageForVideo:[mediaInfo mediaURL]]];
        [imgView addSubview:playIcon];
        imgView.userInteractionEnabled = YES;
        NSDictionary *dictVideo = @{@"videoURL":[mediaInfo mediaURL],
                                    @"thumbImage":[UIImage thumbnailImageForVideo:[mediaInfo mediaURL]],
                                    @"mediaInfoType":FSMediaInfoTypeVedio};
        [self.imagesArr addObject:dictVideo];

    }
    [_mainView refreshView:self.imagesArr.count andImageData:self.imagesArr] ;
    
}












- (UploadPicsView *)mainView{
    if (!_mainView) {
        _mainView = [[UploadPicsView alloc] initWithFrame:CGRectMake(0.f, NAVBAR_HEIGHT + STATUSBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT)];
    }
    return _mainView;
}
- (NSMutableArray *)imagesArr{
    if (!_imagesArr) {
        _imagesArr = [NSMutableArray arrayWithCapacity:MaxImageCount];
    }
    return _imagesArr;
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
        _mainView.locaLabel.text = [_placeMark.addressDictionary objectForKey:@"Name"];
        [_locationDict addEntriesFromDictionary:_placeMark.addressDictionary];
    }];
}


#pragma mark 按尺寸获取所需要的图片.
-(UIImage *)getOriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;   //返回的就是已经改变的图片
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
