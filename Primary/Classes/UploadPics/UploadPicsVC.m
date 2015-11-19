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

//Util
#import "EZUtils.h"
#import "PhilWriteGPSToImage.h"
#import <MBProgressHUD.h>
#import "UserCenter.h"
#import "UploadItem.h"
#import "UploadManager.h"

#define MaxImageCount 8


@interface UploadPicsVC ()<MKMapViewDelegate,CLLocationManagerDelegate,UploadPicsVCDelegate,FSMediaPickerDelegate>
{
    EZColumnItem *_columnItem;
    MKPlacemark *_placeMark;
    NSInteger _selectImgCount;
    UploadType _uploadType;
    AFHTTPRequestOperation *_uploadOperation;
    
}
@property (nonatomic, strong) NSMutableDictionary *locationDict;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) MBProgressHUD *mbProgressView;
@property (nonatomic, strong) UploadPicsView *mainView;
@property (nonatomic, strong) NSMutableArray *imagesArr;

@end

@implementation UploadPicsVC

- (instancetype)initWithColumnItem:(EZColumnItem *)columnItem
{
    if (self = [super init]) {
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

}
- (void)philInitUIUPVC{
    self.mainView.backgroundColor = BACKGROUND_COLOR;
    _mainView.delegate = self;
    [self.view addSubview:_mainView];

    [self.navigationController.view addSubview:self.mbProgressView];
    _mbProgressView.mode = MBProgressHUDModeAnnularDeterminate;
    _mbProgressView.labelText = LBLocalized(@"Uploading");
}

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

- (void)selectAgreement:(UIButton *)btn{
    
}

- (void)removeImage:(NSInteger )imageTag{
    [self.imagesArr removeObjectAtIndex:imageTag];
    [_mainView refreshView:self.imagesArr.count andImageData:self.imagesArr];
}

- (void)uploadPics:(UIButton *)btn{
//    if (_imagesArr.count == 0) {
//        [EZUtils showNotifyMsg:LBLocalized(@"Reminder_Select_Photo") inView:self.view dismissed:nil];
//    }
//    else if (ISEMPTYSTR(_mainView.textDescView.text)) {
//        [EZUtils showNotifyMsg:LBLocalized(@"Reminder_Add_Introduction") inView:self.view dismissed:nil];
//    }
//    else if(_mainView.textDescView.text.length < 5){
//        [EZUtils showNotifyMsg:LBLocalized(@"Reminder_Introduction_Content") inView:self.view dismissed:nil];
//    }
//    else if (!_mainView.checkBtn.selected) {
//        [EZUtils showNotifyMsg:LBLocalized(@"Reminder_Agree_Accord") inView:self.view dismissed:nil];
//    }
    if (NO) {
    }
    else if (_uploadType == UploadType_Image) {
        NSMutableArray *imageDataArr = [NSMutableArray arrayWithCapacity:MaxImageCount];
        for (NSDictionary *dict in _imagesArr) {
            if (dict[@"mediaInfoType"] == FSMediaInfoTypePhotoAlbum) {
                [imageDataArr addObject:[PhilWriteGPSToImage getImgDataWithURL:[dict objectForKey:@"imageURL"] andLocation:self.locationDict]];
            }
            if (dict[@"mediaInfoType"] == FSMediaInfoTakePhoto) {
                [imageDataArr addObject:[PhilWriteGPSToImage getImgDataWithImage:[dict objectForKey:@"originalImage"] andLocation:self.locationDict]];
            }
        }
        [self uploadImages:imageDataArr];
    }
    else if(_uploadType == UploadType_Video){
        NSData *dataToUpload = [NSData dataWithContentsOfURL:[[_imagesArr firstObject] objectForKey:@"videoURL"]];
        [self uploadDataVideo:dataToUpload];
    }
}

- (void)uploadImages:(NSArray *)imagesArr{
    [_mbProgressView show:YES];
    [_mainView.uploadBtn setEnabled:NO];
    [_mainView.addBtn setEnabled:NO];
//    NSString *mpno = [UserCenter defaultCenter].currentUser.mpno;
    NSString *mpno = @"15201594312";
    UploadItem *uItem = [UploadItem itemWithTitle:@" "
                                             mpno:mpno
                                             path:@""
                                             type:_uploadType
                                          content:_mainView.textDescView.text
                                              lon:[self.locationDict objectForKey:@"Longitude"]
                                              lat:[self.locationDict objectForKey:@"Latitude"]
                                          address:[self.locationDict objectForKey:@"Name"]];
    _uploadOperation =
    [UploadManager uploadFileWithColumnIdPhil:7000  //_columnItem.cid
                                         item:uItem
                                imagesDataArr:imagesArr
                                         type:_uploadType
                          uploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite)
     {
         float progress = (float)totalBytesWritten/totalBytesExpectedToWrite;
         _mbProgressView.progress = progress;
     }
                                   completion:^(NSString *status)
     {
          _mbProgressView.hidden = YES;
         if ([status isEqualToString:@"1"]) {
             __weak __typeof(self) weakSelf = self;
             [EZUtils showNotifyMsg:LBLocalized(@"upload_success") inView:self.view dismissed:^{
                 if (weakSelf) {
                     [weakSelf clickOnBack:nil];
                 }
             }];
         }
         else if(!status || [status isEqualToString:@"0"]){
             [EZUtils showNotifyMsg:LBLocalized(@"upload_failed") inView:self.view dismissed:nil];
             [_mainView.uploadBtn setEnabled:YES];
             [_mainView.addBtn setEnabled:YES];
         }
     }];

    
}
- (void)clickOnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)uploadDataVideo:(NSData *)data{
    [_mbProgressView show:YES];
    [_mainView.uploadBtn setEnabled:NO];
    [_mainView.addBtn setEnabled:NO];
    NSString *mpno = [UserCenter defaultCenter].currentUser.mpno;
    UploadItem *uItem = [UploadItem itemWithTitle:@" "
                                             mpno:mpno
                                             path:@""
                                             type:_uploadType
                                          content:_mainView.textDescView.text
                                              lon:[self.locationDict objectForKey:@"Longitude"]
                                              lat:[self.locationDict objectForKey:@"Latitude"]
                                          address:[self.locationDict objectForKey:@"Name"]];
    __weak __typeof(self) weakSelf = self;
    
    _uploadOperation =
    [UploadManager uploadFileWithColumnIdPhil:_columnItem.cid
                                         item:uItem
                                         data:data
                                         type:_uploadType
                          uploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite)
     {
         _mbProgressView.progress = (float)totalBytesWritten/totalBytesExpectedToWrite;
     }completion:^(NSString *status)
     {
         _mbProgressView.hidden = YES;
         if (weakSelf) {
             if ([status isEqualToString:@"1"]) {
                 [EZUtils showNotifyMsg:LBLocalized(@"upload_success") inView:self.view dismissed:^{
                     [weakSelf clickOnBack:nil];
                 }];
             } else {
                 [EZUtils showNotifyMsg:LBLocalized(@"upload_failed") inView:self.view dismissed:nil];
                 [_mainView.uploadBtn setEnabled:YES];
                 [_mainView.addBtn setEnabled:YES];
             }
         }
     }];
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
        [self.mainView.secondBgView.subviews  makeObjectsPerformSelector:@selector(removeFromSuperview)];
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
    _selectImgCount = self.imagesArr.count; 
    [_mainView refreshView:self.imagesArr.count andImageData:self.imagesArr];
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
- (MBProgressHUD *)mbProgressView{
    if (!_mbProgressView) {
        _mbProgressView = [[MBProgressHUD alloc] init];
        [_mbProgressView setCenter:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
    }
    return _mbProgressView;
}

- (NSMutableDictionary *)locationDict{
    if (!_locationDict) {
        _locationDict = [[NSMutableDictionary alloc]initWithCapacity:20];
    }
    return _locationDict;
}
- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}
- (MKMapView *)mapView{
    if (_mapView) {
        _mapView = [[MKMapView alloc] init];
    }
    return _mapView;
}


- (void)getGPSLocationUPVC{
    
    [self.mapView setFrame:self.view.bounds];
    [self.mapView setDelegate:self];
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setHidden:YES];

    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager startUpdatingLocation];
    if (IS_OS_8_OR_LATER) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.geocoder = [[CLGeocoder alloc] init];
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    [self.locationManager stopUpdatingLocation];
    
    [self.locationDict addEntriesFromDictionary:[newLocation GPSDictionary]];
    
    [self.geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        _placeMark = [placemarks objectAtIndex:0];
        self.mainView.locaLabel.text = [_placeMark.addressDictionary objectForKey:@"Name"];
        [self.locationDict addEntriesFromDictionary:_placeMark.addressDictionary];
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
