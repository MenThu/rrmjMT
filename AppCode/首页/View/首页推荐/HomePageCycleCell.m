//
//  HomePageCycleCell.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/22.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "HomePageCycleCell.h"
#import "HomePageCycleCellModel.h"

@interface HomePageCycleCell ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end

@implementation HomePageCycleCell

- (void)updateCustomView{
    HomePageCycleCellModel *model = (HomePageCycleCellModel *)self.cellModel;
    self.contentLabel.text = model.labelName;
}

@end
