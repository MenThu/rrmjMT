//
//  HomePageCommonCell.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/15.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "HomePageCommonCell.h"
#import "HomePageCommonViewCellModel.h"

@interface HomePageCommonCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *episodeName;

@property (weak, nonatomic) IBOutlet UILabel *updateTime;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageMarginBottom;


@end

@implementation HomePageCommonCell

- (void)updateCustomView{
    HomePageCommonViewCellModel *model = (HomePageCommonViewCellModel *)self.cellModel;
    self.image.image = [UIImage imageNamed:model.imageSring];
    self.episodeName.text = model.episodeName;
    self.updateTime.text = model.currentUpdate;
    self.imageMarginBottom.constant = model.imageMarginBottom;
}

- (void)customView{
    self.episodeName.adjustsFontSizeToFitWidth = self.updateTime.adjustsFontSizeToFitWidth = YES;
}

@end
