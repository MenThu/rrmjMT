//
//  HomePageCommonView.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/15.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "HomePageCommonView.h"
#import "MTPageControlView.h"

@interface HomePageCommonView ()
{
    CGFloat _viewHeight;
}

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet MTBaseCollectionView *contentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;

@end



@implementation HomePageCommonView

+ (instancetype)loadView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
}

- (void)setViewModel:(HomePageCommonViewModel *)viewModel{
    _viewModel = viewModel;
    self.label.text = viewModel.titleLabelText;

    self.contentView.itemWidth = viewModel.cellWidth;
    self.contentView.itemHeight = viewModel.cellHeight;
    self.contentView.horizonSpace = viewModel.horizonSpace;
    self.contentView.verticalSpace = viewModel.verticalSpace;
    self.contentView.cellClassName = viewModel.cellClassName;
    self.contentView.isFromXib = viewModel.isFromXib;
    self.contentView.numofLine = viewModel.howManyLine;
    [self.contentView startLayout];
    
    self.contentViewHeight.constant = [self.contentView getmtBaseHeight]+0.5;
    self.contentView.collectionViewSource = viewModel.homePageViewCellArray;
    _viewHeight = self.contentViewHeight.constant + 50.f;
}

- (void)setSelectAct:(void (^)(NSIndexPath *))selectAct{
    _selectAct = selectAct;
    self.contentView.selectItem = ^(NSIndexPath *indexPath, UICollectionView *selectView){
        selectAct(indexPath);
    };
}

- (CGFloat)getViewHeight{
    return _viewHeight;
}

@end
