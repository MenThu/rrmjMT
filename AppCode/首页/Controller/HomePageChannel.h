//
//  HomePageChannel.h
//  rrmjMT
//
//  Created by MenThu on 2016/12/26.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "MTBaseCollectionVC.h"

@interface HomePageChannel : MTBaseCollectionVC

@property (nonatomic, copy) void (^letNaviBarHidden) (BOOL isHidden);

@end
