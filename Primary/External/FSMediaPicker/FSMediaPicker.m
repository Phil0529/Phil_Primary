//
//  FSMediaPicker.m
//  Pods
//
//  Created by Wenchao Ding on 2/3/15.
//  f33chobits@gmail.com
//

#import "FSMediaPicker.h"
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <objc/runtime.h>
//#import "MLSelectPhotoPickerViewController.h"
#import "JKImagePickerController.h"
#import "JKUtil.h"


#define kIsIPad [[[UIDevice currentDevice] model] hasPrefix:@"iPad"]

//#define kTakePhotoString LBLocalized(@"Take photo")
//#define kSelectPhotoFromLibraryString LBLocalized(@"Select photo from photo library")
//#define kRecordVideoString LBLocalized(@"Record video")
//#define kSelectVideoFromLibraryString LBLocalized(@"Select video from photo library")
//#define kCancelString LBLocalized(@"cancel")

#define kTakePhotoString @"拍照"
#define kSelectPhotoFromLibraryString @"从相册选取"
#define kRecordVideoString @"拍视频"
#define kSelectVideoFromLibraryString @"从相册取视频"
#define kCancelString @"取消"


NSString const * UIImagePickerControllerCircularEditedImage = @" UIImagePickerControllerCircularEditedImage;";
NSString const * UIImagePickerControllerMultiImages = @" UIImagePickerControllerMultiImages;";
NSString *const FSMediaInfoTakePhoto = @"FSMediaInfoTakePhoto";
NSString *const FSMediaInfoTypePhotoAlbum = @"FSMediaInfoTypePhotoAlbum";
NSString *const FSMediaInfoTypeVedio = @"FSMediaInfoTypeVedio";



//NSString const * UIImagePickerControllerMediaMetadata = @"UIImagePickerControllerMediaMetadata;";

@interface FSMediaPicker ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, JKImagePickerControllerDelegate>{
    NSInteger _imagesCount;
    
}

- (UIWindow *)currentVisibleWindow;
- (UIViewController *)currentVisibleController;

- (void)delegatePerformFinishWithMediaInfo:(NSDictionary *)mediaInfo;
- (void)delegatePerformWillPresentImagePicker:(UIImagePickerController *)imagePicker;
- (void)delegatePerformCancel;

- (void)showAlertController:(UIView *)view;
- (void)showActionSheet:(UIView *)view;

- (void)takePhotoFromCamera;
- (void)takePhotoFromPhotoLibrary;
- (void)takeVideoFromCamera;
- (void)takeVideoFromPhotoLibrary;

@end

@implementation FSMediaPicker



#pragma mark - Life Cycle

- (instancetype)initWithDelegate:(id<FSMediaPickerDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

#pragma mark - Public

- (void)show
{
    [self showFromView:self.currentVisibleController.view];
}

//
- (void)showFromView:(UIView *)view
{
    //ios 8中提示框-->使用UIAlertController class;
    if ([UIAlertController class]) {
        [self showAlertController:view];
    } else {
        [self showActionSheet:view];
    }
}

#pragma mark - UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    switch (buttonIndex) {
        case 0:
        {
            if (self.mediaType == FSMediaTypePhoto || self.mediaType == FSMediaTypeAll) {
                [self takePhotoFromCamera];
            } else if (self.mediaType == FSMediaTypeVideo) {
                [self takeVideoFromCamera];
            }
            break;
        }
        case 1:
        {
            if (self.mediaType == FSMediaTypePhoto || self.mediaType == FSMediaTypeAll) {
                [self takePhotoFromPhotoLibrary];
            } else if (self.mediaType == FSMediaTypeVideo) {
                [self takeVideoFromPhotoLibrary];
            }
            break;
        }
        case 2:
        {
            if (self.mediaType == FSMediaTypeAll) {
                [self takeVideoFromCamera];
            }
            break;
        }
        case 3:
        {
            if (self.mediaType == FSMediaTypeAll) {
                [self takeVideoFromPhotoLibrary];
            }
            break;
        }
        default:
            break;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        [self delegatePerformCancel];
    }
}

#pragma mark - UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:info];
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.movie"]) {
        [dict setValue:FSMediaInfoTypeVedio forKey:@"mediaInfoType"];
    }
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
        [dict setValue:FSMediaInfoTakePhoto forKey:@"mediaInfoType"];
    }
    [self delegatePerformFinishWithMediaInfo:dict];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self delegatePerformCancel];
}

#pragma mark JKimagePickerdelegate
//这是jkImagePicker的delegate->call
- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAssets:(NSArray *)assets isSource:(BOOL)source
{
    [imagePicker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    NSMutableDictionary *mediaInfo = [[NSMutableDictionary alloc] init ];
    [mediaInfo setObject:assets forKey:UIImagePickerControllerMultiImages];
    [mediaInfo setObject:FSMediaInfoTypePhotoAlbum forKey:@"mediaInfoType"];
    [self delegatePerformFinishWithMediaInfo:mediaInfo];
}

- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAsset:(JKAssets *)asset isSource:(BOOL)source{
    
    
}

//点击导航 取消选择调用的方法-->
- (void)jkImagePickerControllerDidCancel:(JKImagePickerController *)imagePicker
{
    //
    [imagePicker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self delegatePerformCancel];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:NSClassFromString(@"PLUIImageViewController")] && self.editMode && [navigationController.viewControllers count] == 3) {
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        
        UIView *plCropOverlay = [[viewController.view.subviews objectAtIndex:1] subviews][0];
        
        plCropOverlay.hidden = YES;
        
        int position = 0;
        
        if (screenHeight >= 568){
            position = 124;
        } else {
            position = 80;
        }
        
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        
        CGFloat diameter = kIsIPad ? MAX(plCropOverlay.frame.size.width, plCropOverlay.frame.size.height) : MIN(plCropOverlay.frame.size.width, plCropOverlay.frame.size.height);
        
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:
                                    CGRectMake(0.0f, position, diameter, diameter)];
        [circlePath setUsesEvenOddFillRule:YES];
        [circleLayer setPath:[circlePath CGPath]];
        [circleLayer setFillColor:[[UIColor clearColor] CGColor]];
        
        CGFloat bottomBarHeight = kIsIPad ? 51 : 72;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, diameter, screenHeight - bottomBarHeight) cornerRadius:0];
        [path appendPath:circlePath];
        [path setUsesEvenOddFillRule:YES];
        
        CAShapeLayer *fillLayer = [CAShapeLayer layer];
        fillLayer.name = @"fillLayer";
        fillLayer.path = path.CGPath;
        fillLayer.fillRule = kCAFillRuleEvenOdd;
        fillLayer.fillColor = [UIColor blackColor].CGColor;
        fillLayer.opacity = 0.5;
        [viewController.view.layer addSublayer:fillLayer];
        
        
        if (!kIsIPad) {
            UILabel *moveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 320, 50)];
            [moveLabel setText:@"Move and Scale"];
            [moveLabel setTextAlignment:NSTextAlignmentCenter];
            [moveLabel setTextColor:[UIColor whiteColor]];
            [viewController.view addSubview:moveLabel];
        }
        
    }
}

#pragma mark - Setter & Getter

//当前的窗体.
- (UIWindow *)currentVisibleWindow
{
    //当前的窗体...-->倒叙遍历.
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    
    for (UIWindow *window in frontToBackWindows){
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            return window;
        }
    }
    return [[[UIApplication sharedApplication] delegate] window];
    
}
//
- (UIViewController *)currentVisibleController
{
    UIViewController *topController = self.currentVisibleWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    return topController;
}

#pragma mark - Private
//NextStep-->delegatePerformFinish
- (void)delegatePerformFinishWithMediaInfo:(NSDictionary *)mediaInfo
{

    if ([[mediaInfo objectForKey:@"mediaInfoType"] isEqualToString:FSMediaInfoTypeVedio]) {
        
    }
    if ([[mediaInfo objectForKey:@"mediaInfoType"] isEqualToString:FSMediaInfoTypePhotoAlbum]) {
        
    }
    if ([[mediaInfo objectForKey:@"mediaInfoType"] isEqualToString:FSMediaInfoTakePhoto]) {
        
    }

    
    if ([[mediaInfo allKeys] containsObject:UIImagePickerControllerEditedImage]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:mediaInfo];
        dic[UIImagePickerControllerCircularEditedImage] = [dic[UIImagePickerControllerEditedImage] circularImage];
        mediaInfo = [NSDictionary dictionaryWithDictionary:dic];
        
    }
    if (_finishBlock) {
        //block call-->
        _finishBlock(self,mediaInfo);
        
    }//
    else if (_delegate && [_delegate respondsToSelector:@selector(mediaPicker:didFinishWithMediaInfo:)]) {
        [_delegate mediaPicker:self didFinishWithMediaInfo:mediaInfo];
        
    }
    
}

//代理展示当前的图像选择器--->
- (void)delegatePerformWillPresentImagePicker:(UIImagePickerController *)imagePicker
{
    if (_willPresentImagePickerBlock) {
        //block
        _willPresentImagePickerBlock(self,imagePicker);
        //ezUpViewController.delegate--->执行协议中的回调.
    } else if (_delegate && [_delegate respondsToSelector:@selector(mediaPicker:willPresentImagePickerController:)]) {
        [_delegate mediaPicker:self willPresentImagePickerController:imagePicker];
        NSLog(@"执行-->");
        
    }
}

//FSMediaPicker-->执行取消方法-->
- (void)delegatePerformCancel
{
    if (_cancelBlock) {
        _cancelBlock(self);
        
    }
    //
    else if (_delegate && [_delegate respondsToSelector:@selector(mediaPickerDidCancel:)]) {
        [_delegate mediaPickerDidCancel:self];
    }
}

- (void)showActionSheet:(UIView *)view
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    actionSheet.mediaPicker = self;
    switch (self.mediaType) {
        case FSMediaTypePhoto:
        {
            [actionSheet addButtonWithTitle:kTakePhotoString];
            [actionSheet addButtonWithTitle:kSelectPhotoFromLibraryString];
            [actionSheet addButtonWithTitle:kCancelString];
            actionSheet.cancelButtonIndex = 2;
            break;
        }
        case FSMediaTypeVideo:
        {
            [actionSheet addButtonWithTitle:kRecordVideoString];
            [actionSheet addButtonWithTitle:kSelectVideoFromLibraryString];
            [actionSheet addButtonWithTitle:kCancelString];
            actionSheet.cancelButtonIndex = 2;
            break;
        }
        case FSMediaTypeAll:
        {
            [actionSheet addButtonWithTitle:kTakePhotoString];
            [actionSheet addButtonWithTitle:kSelectPhotoFromLibraryString];
            [actionSheet addButtonWithTitle:kRecordVideoString];
            [actionSheet addButtonWithTitle:kSelectVideoFromLibraryString];
            [actionSheet addButtonWithTitle:kCancelString];
            actionSheet.cancelButtonIndex = 4;
            break;
        }
        default:
            break;
    }
    actionSheet.delegate = self;
    [actionSheet showFromRect:view.bounds inView:view animated:YES];
}

//- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
//{
//    for (UIView *subViwe in actionSheet.subviews) {
//        if ([subViwe isKindOfClass:[UIButton class]]) {
//            UIButton *button = (UIButton*)subViwe;
//            [button setTitleColor:[JKUtil getColor:@"#BCOOOE"] forState:UIControlStateNormal];
//        }
//    }
//}



//
- (void)showAlertController:(UIView *)view
{
    UIAlertController *alertController = [[UIAlertController alloc] init];
    
    alertController.mediaPicker = self;
    NSLog(@"self.mediaType = %i",self.mediaType);
    switch (self.mediaType) {
        case FSMediaTypePhoto:
        {
            [alertController addAction:[UIAlertAction actionWithTitle:kTakePhotoString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self takePhotoFromCamera];
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:kSelectPhotoFromLibraryString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self takePhotoFromPhotoLibrary];
            }]];
            
            break;
        }
        case FSMediaTypeVideo:
        {
            [alertController addAction:[UIAlertAction actionWithTitle:kRecordVideoString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self takeVideoFromCamera];
                
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:kSelectVideoFromLibraryString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self takeVideoFromPhotoLibrary];
            }]];
            break;
        }
            
            //UIAlertController->展示的内容-->
        case FSMediaTypeAll:
        {
            [alertController addAction:[UIAlertAction actionWithTitle:kTakePhotoString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self takePhotoFromCamera];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:kSelectPhotoFromLibraryString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self takePhotoFromPhotoLibrary];
                
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:kRecordVideoString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self takeVideoFromCamera];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:kSelectVideoFromLibraryString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self takeVideoFromPhotoLibrary];
            }]];
            break;
        }
        default:
            break;
    }
    [alertController addAction:[UIAlertAction actionWithTitle:kCancelString style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self delegatePerformCancel];
    }]];
    
    //    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
    //        textField.textColor = [JKUtil getColor:@"#BCOOOE"];
    //    }];
    
    alertController.popoverPresentationController.sourceView = view;
    alertController.popoverPresentationController.sourceRect = view.bounds;
    [self.currentVisibleController presentViewController:alertController animated:YES completion:nil];
}

//从照相机获取照片
- (void)takePhotoFromCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.allowsEditing = _enableAssetEdit;
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
        imagePicker.mediaPicker = self;
        [self delegatePerformWillPresentImagePicker:imagePicker];
        [self.currentVisibleController presentViewController:imagePicker animated:YES completion:nil];
    }
}


//相册选择相片.
- (void)takePhotoFromPhotoLibrary
{
    
    //JKImagePickerController
    if (self.upLoadMultiImageStatus) {
        JKImagePickerController *jkImagePicker = [[JKImagePickerController alloc] init];
        jkImagePicker.imageCount = self.imageCount;
        [jkImagePicker setAllowsMultipleSelection:YES];
        [jkImagePicker setMinimumNumberOfSelection:1];
        [jkImagePicker setMaximumNumberOfSelection:self.imagePickerMax != 0?self.imagePickerMax:1];
        [jkImagePicker setShowsCancelButton:YES];
        [jkImagePicker setFilterType:JKImagePickerControllerFilterTypePhotos];
        jkImagePicker.delegate = self;
        //对象的关联.
        jkImagePicker.mediaPicker = self;
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:jkImagePicker];
        //    [self delegatePerformWillPresentImagePicker:jkImagePicker];
        [self.currentVisibleController presentViewController:navi animated:YES completion:nil];
    }
    //系统自带.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] && !self.upLoadMultiImageStatus) {
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.navigationBar.tintColor = [UIColor whiteColor];
        imagePicker.allowsEditing = _enableAssetEdit;
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
        imagePicker.mediaPicker = self;
        [self delegatePerformWillPresentImagePicker:imagePicker];
        [self.currentVisibleController presentViewController:imagePicker animated:YES completion:nil];
    }
    
    
    
}



- (void)takeVideoFromCamera
{
    if(self.reminder){
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reminderUserPhil" object:@"video"];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.allowsEditing = _enableAssetEdit;
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie];
        imagePicker.mediaPicker = self;
        [self delegatePerformWillPresentImagePicker:imagePicker];
        [self.currentVisibleController presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)takeVideoFromPhotoLibrary
{
    if(self.reminder){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reminderUserPhil" object:@"video"];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.navigationBar.tintColor = [UIColor whiteColor];
        imagePicker.allowsEditing = _enableAssetEdit;
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie];
        imagePicker.mediaPicker = self;
        [self delegatePerformWillPresentImagePicker:imagePicker];
        [self.currentVisibleController presentViewController:imagePicker animated:YES completion:nil];
    }
}

@end

@implementation NSDictionary (FSMediaPicker)

- (UIImage *)originalImage
{
    if ([self.allKeys containsObject:UIImagePickerControllerOriginalImage]) {
        return self[UIImagePickerControllerOriginalImage];
    }
    return nil;
}

- (UIImage *)editedImage
{
    if ([self.allKeys containsObject:UIImagePickerControllerEditedImage]) {
        return self[UIImagePickerControllerEditedImage];
    }
    return nil;
}

- (UIImage *)circularEditedImage
{
    if ([self.allKeys containsObject:UIImagePickerControllerCircularEditedImage]) {
        return self[UIImagePickerControllerCircularEditedImage];
    }
    return nil;
}

- (NSURL *)mediaURL
{
    if ([self.allKeys containsObject:UIImagePickerControllerMediaURL]) {
        return self[UIImagePickerControllerMediaURL];
    }
    return nil;
}

- (NSDictionary *)mediaMetadata
{
    if ([self.allKeys containsObject:UIImagePickerControllerMediaMetadata]) {
        return self[UIImagePickerControllerMediaMetadata];
    }
    return nil;
}

- (FSMediaType)mediaType
{
    if ([self.allKeys containsObject:UIImagePickerControllerMediaType]) {
        NSString *type = self[UIImagePickerControllerMediaType];
        if ([type isEqualToString:(NSString *)kUTTypeImage]) {
            return FSMediaTypePhoto;
        } else if ([type isEqualToString:(NSString *)kUTTypeMovie]) {
            return FSMediaTypeVideo;
        }
    }
    return FSMediaTypePhoto;
}

@end


@implementation UIImage (FSMediaPicker)

- (UIImage *)circularImage
{
    // This function returns a newImage, based on image, that has been:
    // - scaled to fit in (CGRect) rect
    // - and cropped within a circle of radius: rectWidth/2
    
    //Create the bitmap graphics context
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.width, self.size.height), NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Get the width and heights
    CGFloat imageWidth = self.size.width;
    CGFloat imageHeight = self.size.height;
    CGFloat rectWidth = self.size.width;
    CGFloat rectHeight = self.size.height;
    
    //Calculate the scale factor
    CGFloat scaleFactorX = rectWidth/imageWidth;
    CGFloat scaleFactorY = rectHeight/imageHeight;
    
    //Calculate the centre of the circle
    CGFloat imageCentreX = rectWidth/2;
    CGFloat imageCentreY = rectHeight/2;
    
    // Create and CLIP to a CIRCULAR Path
    // (This could be replaced with any closed path if you want a different shaped clip)
    CGFloat radius = rectWidth/2;
    CGContextBeginPath (context);
    CGContextAddArc (context, imageCentreX, imageCentreY, radius, 0, 2*M_PI, 0);
    CGContextClosePath (context);
    CGContextClip (context);
    
    //Set the SCALE factor for the graphics context
    //All future draw calls will be scaled by this factor
    CGContextScaleCTM (context, scaleFactorX, scaleFactorY);
    
    // Draw the IMAGE
    CGRect myRect = CGRectMake(0, 0, imageWidth, imageHeight);
    [self drawInRect:myRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end

const char * mediaPickerKey;

@implementation UIActionSheet (FSMediaPicker)

- (void)setMediaPicker:(FSMediaPicker *)mediaPicker
{
    objc_setAssociatedObject(self, &mediaPickerKey, mediaPicker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FSMediaPicker *)mediaPicker
{
    return objc_getAssociatedObject(self, &mediaPickerKey);
}

@end

@implementation UIAlertController (FSMediaPicker)

- (void)setMediaPicker:(FSMediaPicker *)mediaPicker
{
    objc_setAssociatedObject(self, &mediaPickerKey, mediaPicker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FSMediaPicker *)mediaPicker
{
    return objc_getAssociatedObject(self, &mediaPickerKey);
}


@end


//对象关联.
@implementation UIViewController (FSMediaPicker)

- (void)setMediaPicker:(FSMediaPicker *)mediaPicker
{
    objc_setAssociatedObject(self, &mediaPickerKey, mediaPicker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FSMediaPicker *)mediaPicker
{
    return objc_getAssociatedObject(self, &mediaPickerKey);
}


@end

