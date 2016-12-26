//
//  HomePageEpisode.h
//  rrmjMT
//
//  Created by MenThu on 2016/12/10.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "MTBaseTableVC.h"

@interface HomePageEpisode : MTBaseTableVC

@property (nonatomic, copy) void (^letNaviBarHidden) (BOOL isHidden);

@end
