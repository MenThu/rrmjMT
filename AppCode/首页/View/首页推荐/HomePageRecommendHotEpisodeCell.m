//
//  HomePageRecommendHotEpisodeCell.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/22.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "HomePageRecommendHotEpisodeCell.h"
#import "RecommendHotEpisodeCellModel.h"

@interface HomePageRecommendHotEpisodeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *titleImage;


@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation HomePageRecommendHotEpisodeCell

- (void)updateCustomView{
    RecommendHotEpisodeCellModel *model = (RecommendHotEpisodeCellModel *)self.cellModel;
    self.titleImage.image = [UIImage imageNamed:model.imageName];
    self.label.text = model.labelName;
}

@end
