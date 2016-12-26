//
//  HomePageTitle.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/10.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "HomePageTitle.h"
#import "HomePageTitleCellModel.h"

@interface HomePageTitle ()
{
    UIView *_underLine;
    CGFloat _lineWidth;
    CGFloat _lineHeight;
}

@property (nonatomic, strong) UIView *underLine;

@end

@implementation HomePageTitle

- (void)customView{
    UIView *underLine = [[UIView alloc] init];
    underLine.backgroundColor = [UIColor colorWithHexString:@"#00719a"];
    [self addSubview:(_underLine = underLine)];
    self.backgroundColor = LineColor;
}

- (void)initVariable{
    self.cellClassName = @"HomePageTitleCell";
    self.horizonSpace = 0;
    self.verticalSpace = 0;
    self.isFromXib = YES;
    self.numInaLine = 3;
    self.itemHeight = 47;
    self.marginArray = @[@(0),@(0),@(3),@(0)];
    _lineHeight = 3;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _lineWidth = self.width / self.collectionViewSource.count;
    _underLine.frame = CGRectMake(0, self.height-_lineHeight-0.5, _lineWidth, _lineHeight);
    _underLine.layer.cornerRadius = 3.f;
}

- (void)setLineFrame:(CGFloat)originX{
    @weakify(self);
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self);
        self.underLine.x = originX*self.underLine.width;
    }];
}

- (void)updateUnderLineFrame:(CGPoint)cotentOffset{
    _underLine.x = cotentOffset.x/YYScreenSize().width*_lineWidth;
    NSInteger leftIndex = floorf((cotentOffset.x/YYScreenSize().width));
    NSLog(@"%ld", (long)leftIndex);
    if (leftIndex < self.collectionViewSource.count-1) {
        HomePageTitleCellModel *leftModel = self.collectionViewSource[leftIndex];
        HomePageTitleCellModel *rightModel = self.collectionViewSource[leftIndex+1];;
        CGFloat leftOffset = leftIndex * YYScreenSize().width;
        leftModel.selectPercent = 1 - (cotentOffset.x - leftOffset)/YYScreenSize().width;
        rightModel.selectPercent = 1 - leftModel.selectPercent;
        NSLog(@"selectPercent : %f",leftModel.selectPercent);
        NSIndexPath *leftIndexPath = [NSIndexPath indexPathForItem:leftIndex inSection:0];
        NSIndexPath *rightIndexPath = [NSIndexPath indexPathForItem:leftIndex+1 inSection:0];
        [self.collectionView reloadItemsAtIndexPaths:@[leftIndexPath,rightIndexPath]];
    }
}

@end
