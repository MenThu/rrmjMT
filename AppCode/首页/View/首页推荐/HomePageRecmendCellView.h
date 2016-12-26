//
//  HomePageRecmendCellView.h
//  rrmjMT
//
//  Created by MenThu on 2016/12/22.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageRecmendCellViewModel.h"

@interface HomePageRecmendCellView : UIView

+ (instancetype)loadView;

@property (nonatomic, weak) HomePageRecmendCellViewModel *model;

@end
