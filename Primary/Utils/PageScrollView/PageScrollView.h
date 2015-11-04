//
//  PageScrollView.h
//  Primary
//
//  Created by Phil Xhc on 15/10/29.
//  Copyright © 2015年 Xhc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentPage.h"
@class PageScrollView;

@protocol PageScrollViewDelegate <NSObject>

@required

- (void)pageScrollView:(PageScrollView *)pageScrollView scrollToPage:(NSInteger)page;

@end

@protocol PageScrollViewDataSource <NSObject>

- (NSInteger )numberOfContentPages;

- (UIView<ContentPageView> *)contentPageViewAtIndex:(NSInteger)pageIndex;

@end

@interface PageScrollView : UIView

@property (nonatomic, assign) id<PageScrollViewDelegate> delegate;
@property (nonatomic, assign) id<PageScrollViewDataSource> dataSource;

//刷新ScrollView的contentPage;
- (void)reloadPageScrollView;

//刷新某个页面
- (void)refreshPageScrollViewAtIndex:(NSInteger)pageIndex;

//滑动到某个页面
- (void)scrollViewToPage:(NSInteger)pageIndex;

//
- (UIView<ContentPageView> *)contentPageViewAtPageIndex:(NSInteger)pageIndex;

@end
















