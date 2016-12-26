//
//  HomePageEpisodeCell.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/10.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "HomePageEpisodeCell.h"
#import "HomeEpisodeModel.h"
#import "HomePageCellCustomContentView.h"

@interface HomePageEpisodeCell ()

@property (weak, nonatomic) IBOutlet HomePageCellCustomContentView *customContentView;

@end

@implementation HomePageEpisodeCell

- (void)updateCustomView{
    HomeEpisodeModel *model = (HomeEpisodeModel *)self.cellModel;
    self.customContentView.collectionViewSource = model.cellArray;
    
    self.customContentView.itemHeight = model.cellHeight-10;
    self.customContentView.itemWidth = model.cellWidth;
    [self.customContentView setNeedsLayout];
}

- (void)configCustomView{
    self.customContentView.cellClassName = @"HomePageCommonCell";
}

@end
