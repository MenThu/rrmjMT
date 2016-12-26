//
//  HomePageTitleCell.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/10.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "HomePageTitleCell.h"
#import "HomePageTitleCellModel.h"

@interface HomePageTitleCell ()

@property (weak, nonatomic) IBOutlet UILabel *selectLabel;

@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;

@end

@implementation HomePageTitleCell

- (void)updateCustomView{
    HomePageTitleCellModel *model = (HomePageTitleCellModel *)self.cellModel;
    self.selectLabel.text = model.titleString;
    self.defaultLabel.text = model.titleString;
    self.selectLabel.alpha = model.selectPercent;
}

- (void)customView{
    self.defaultLabel.font = [UIFont systemFontOfSize:16];
    self.selectLabel.font = [UIFont systemFontOfSize:16];
}

@end
