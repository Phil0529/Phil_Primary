//
//  PageScrollView.m
//  Primary
//
//  Created by Phil Xhc on 15/10/29.
//  Copyright © 2015年 Xhc. All rights reserved.
//

#import "PageScrollView.h"

@interface PageScrollView()<UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) BOOL needDelegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *pagesArray;


@end

@implementation PageScrollView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.scrollView.frame = self.bounds;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    return self;
}

#pragma mark 刷新所有的PageScrollView
- (void)reloadPageScrollView{
    for (UIView *pageview in self.pagesArray) {
        [pageview removeFromSuperview];
    }
    [self.pagesArray removeAllObjects];
    if (_dataSource) {
        NSInteger count = [_dataSource numberOfContentPages];
        for (NSInteger i = 0; i < count; i++) {
            UIView<ContentPageView> *contentPage = [_dataSource contentPageViewAtIndex:i];
            [_scrollView addSubview:contentPage];
            [_pagesArray addObject:contentPage];
        }
        [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.frame) * count, CGRectGetHeight(self.frame))];
    }
}

#pragma mark 刷新某个页面
- (void)refreshPageScrollViewAtIndex:(NSInteger)pageIndex{
    if (ISINDEXINRANGE(pageIndex, self.pagesArray)) {
        UIView<ContentPageView> *contentPage = [_pagesArray objectAtIndex:pageIndex];
        [contentPage refreshContentPage];
    }
}

- (UIView<ContentPageView> *)contentPageViewAtPageIndex:(NSInteger)pageIndex{
    if (ISINDEXINRANGE(pageIndex, self.pagesArray)) {
        UIView<ContentPageView> *contentPage = [_pagesArray objectAtIndex:pageIndex];
        return contentPage;
    }
    return nil;
}


#pragma mark 滚动都某个ScrollView到某个页面
- (void)scrollViewToPage:(NSInteger)pageIndex{
    _needDelegate = NO;
    _currentPage = pageIndex;
    [_scrollView scrollRectToVisible:CGRectMake(CGRectGetWidth(self.frame) * pageIndex, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) animated:YES];
    if ([_delegate respondsToSelector:@selector(pageScrollView:scrollToPage:)]) {
        [_delegate pageScrollView:self scrollToPage:pageIndex];
    }
    [self refreshPageScrollViewAtIndex:pageIndex];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _needDelegate = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = (_scrollView.contentOffset.x + CGRectGetWidth(self.frame)/2)/ CGRectGetWidth(self.frame);
    if (_currentPage != page) {
        _currentPage = page;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([_delegate respondsToSelector:@selector(pageScrollView:scrollToPage:)] && _needDelegate) {
        [_delegate pageScrollView:self scrollToPage:_currentPage];
    }
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}
- (NSMutableArray *)pagesArray{
    if (!_pagesArray) {
        _pagesArray = [NSMutableArray array];
    }
    return _pagesArray;
    
}



@end
