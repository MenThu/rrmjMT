//
//  PageControlView.h
//  rrmjMT
//
//  Created by MenThu on 2016/12/20.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "MTBaseCollectionView.h"

@interface MTPageControlView : MTBaseCollectionView

/**
    外界可以对pageView的属性进行修改
 **/
@property (nonatomic,strong) UIPageControl *pageView;

/**
    外界传入的，轮播的真实个数数据源
 **/
@property (nonatomic, strong) NSArray *carouselSource;

/**
    轮播图的当前位置
 **/
@property (nonatomic, assign) NSInteger innerCarouseIndex;

/**
    定时器开始
 **/
- (void)beiginCycle;

/**
    定时器暂时
 **/
- (void)pauseCyle;

/**
    定时器结束
 **/
- (void)endCycle;

/**
    HomePageControllerView
 **/
- (void)nextPage;

@end
