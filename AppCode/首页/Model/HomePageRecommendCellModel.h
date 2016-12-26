//
//  HomePageRecommendCellModel.h
//  rrmjMT
//
//  Created by MenThu on 2016/12/22.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "MTBaseCellModel.h"
#import "HomePageRecmendCellViewModel.h"

@interface HomePageRecommendCellModel : MTBaseCellModel

@property (nonatomic, assign) CGFloat topHeight;
@property (nonatomic, assign) CGFloat contentMaxHeight;
@property (nonatomic, strong) NSArray <HomePageRecmendCellViewModel *> *contentArray;


@end
