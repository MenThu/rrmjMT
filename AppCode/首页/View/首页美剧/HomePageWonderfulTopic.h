//
//  HomePageWonderfulTopic.h
//  rrmjMT
//
//  Created by MenThu on 2016/12/24.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageCommonViewModel.h"

@interface HomePageWonderfulTopic : UIView

@property (nonatomic, strong) HomePageCommonViewModel *viewModel;

@property (nonatomic, strong, readonly) MTPageControlView *carouseView;

- (CGFloat)getViewHeight;

@end
