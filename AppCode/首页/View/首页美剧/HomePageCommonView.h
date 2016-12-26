//
//  HomePageCommonView.h
//  rrmjMT
//
//  Created by MenThu on 2016/12/15.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageCommonViewModel.h"

@interface HomePageCommonView : UIView

@property (nonatomic, strong) HomePageCommonViewModel *viewModel;

@property (nonatomic, copy) void (^selectAct) (NSIndexPath *indexPath);

+ (instancetype)loadView;

- (CGFloat)getViewHeight;



@end
