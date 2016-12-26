//
//  HomePagePageControllerCell.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/13.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "HomePagePageControllerCell.h"
#import "HomePagePageControllerCellModel.h"

@interface HomePagePageControllerCell ()


@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;

@end

@implementation HomePagePageControllerCell

- (void)updateCustomView{
    HomePagePageControllerCellModel *model = self.cellModel;
    self.cellImageView.image = [UIImage imageNamed:model.cellImageName];
}

@end
