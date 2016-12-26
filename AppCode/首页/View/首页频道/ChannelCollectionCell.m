//
//  ChannelCollectionCell.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/26.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "ChannelCollectionCell.h"
#import "RecommendHotEpisodeCellModel.h"

@interface ChannelCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;


@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@implementation ChannelCollectionCell

- (void)customView{
    self.label.adjustsFontSizeToFitWidth = YES;
}

- (void)updateCustomView{
    RecommendHotEpisodeCellModel *model = (RecommendHotEpisodeCellModel *)self.cellModel;
    self.cellImage.image = [UIImage imageNamed:model.imageName];
    self.label.text = model.labelName;
}

@end
