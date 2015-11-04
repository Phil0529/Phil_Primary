//
//  ContentPage.h
//  Primary
//
//  Created by Phil Xhc on 15/10/29.
//  Copyright © 2015年 Xhc. All rights reserved.
//

#ifndef ContentPage_h
#define ContentPage_h

@protocol ContentPageView <NSObject>

@property (nonatomic, weak) UINavigationController *navigationController;

- (void)refreshContentPage;

@end

#endif /* ContentPage_h */
