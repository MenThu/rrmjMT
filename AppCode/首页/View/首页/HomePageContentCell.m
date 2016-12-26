//
//  HomePageContentCell.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/10.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "HomePageContentCell.h"

@implementation HomePageContentCell

- (void)updateCustomView{
    [self.contentView removeAllSubviews];
    UIViewController *childViewController = (UIViewController *)self.cellModel;
    childViewController.view.frame = self.contentView.bounds;
    [self.contentView addSubview:childViewController.view];
}

@end
