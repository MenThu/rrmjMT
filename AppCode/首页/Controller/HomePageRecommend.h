//
//  HomePageRecommend.h
//  rrmjMT
//
//  Created by MenThu on 2016/12/22.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "MTBaseVC.h"

@interface HomePageRecommend : MTBaseTableVC

@property (nonatomic, copy) void (^letNaviBarHidden) (BOOL isHidden);

@property (nonatomic, copy) void (^push2Video)(void);

@end
