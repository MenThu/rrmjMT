//
//  HomePageChannel.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/26.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "HomePageChannel.h"
#import "RecommendHotEpisodeCellModel.h"

@interface HomePageChannel ()
{
    CGFloat _offsetY;
}

@end

@implementation HomePageChannel

- (void)initVariable{
    self.cellClassName = @"ChannelCollectionCell";
    self.numInaLine = 3;
    self.horizonSpace = 0;
    self.isScrollDirectionHorizon = NO;
    self.outsideItemWidth = YYScreenSize().width / 3;
    self.itemHeight = self.outsideItemWidth*0.8 + 5 + 20 + 5;
    self.collectionViewMarginArray = @[@(10),@(0),@(10),@(0)];
    self.verticalSpace = 5.f;
//    NSLog(@"[%f] [%f]", self.outsideItemWidth, self.itemHeight);
}

- (void)configView{
    [super configView];
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#2e313c"];
}

- (void)startHttpRequest{
    //准备测试数据
    [self pullDataFromServer];
}

- (void)pullDataFromServer{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSInteger index = 0; index < 20; index ++) {
        RecommendHotEpisodeCellModel *model = [RecommendHotEpisodeCellModel new];
        model.imageName = [NSString stringWithFormat:@"HomePage%ld", (long)(index%3+1)];
        model.labelName = [NSString stringWithFormat:@"第[%ld]个Item", (long)index+1];
        [tempArray addObject:model];
    }
    self.collectionViewSource = tempArray;
    [self endHttpRequest];
}

#pragma mark - 滚动代理
- (void)scrollViewMove:(CGPoint)contentOffset view:(UICollectionView *)scrollView{
    if (scrollView.isDragging && self.letNaviBarHidden) {
        if (_offsetY > scrollView.contentOffset.y) {
            //下拉
            self.letNaviBarHidden(NO);
        }else if(_offsetY < scrollView.contentOffset.y) {
            //上拉
            self.letNaviBarHidden(YES);
        }
        _offsetY = scrollView.contentOffset.y;
        if (_offsetY < 0) {
            _offsetY = 0 ;
        }else if (_offsetY > self.collectionView.contentSize.height){
            _offsetY = self.collectionView.contentSize.height;
        }
    }
}

@end
