//
//  PageControlView.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/20.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "MTPageControlView.h"

@interface MTPageControlView ()
{
    NSMutableArray *_innerCarouseArray;
    MyTimer *_cycleTimer;
}
@end

@implementation MTPageControlView


- (void)customView{
    //添加UIPageControl
    _pageView = [[UIPageControl alloc] init];
    [self addSubview:_pageView];
    _pageView.pageIndicatorTintColor = [UIColor colorWithHexString:@"#858784"];
    _pageView.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#00b4f4"];
    @weakify(self);
    [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-5);
        make.height.mas_equalTo(15.f);
        make.width.mas_equalTo(120.f);
    }];
    
    self.collectionView.pagingEnabled = YES;
    
    _cycleTimer = [MyTimer customTimeInterval:3.f WithBlock:^(NSInteger timeCount) {
        @strongify(self);
        [self nextPage];
    }];
}

- (void)setCarouselSource:(NSArray *)carouselSource{
    //先对pageView赋真实个数的值
    [self setPageCount:carouselSource.count];
    
    _innerCarouseArray = [NSMutableArray array];
    NSInteger repeatCount = 1000;
    for (NSInteger index = 0; index < repeatCount; index ++) {
        [_innerCarouseArray addObjectsFromArray:carouselSource];
    }
    _innerCarouseIndex = repeatCount/2 * carouselSource.count;
    self.collectionViewSource = _innerCarouseArray;
}

- (void)nextPage{
    _innerCarouseIndex += 1;
    if (_innerCarouseIndex > self.collectionViewSource.count-1) {
        _innerCarouseIndex = 0;
    }
    if (self.isScrollDirectionHorizon) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_innerCarouseIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }else{
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_innerCarouseIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
    }
}

- (void)willDrag:(UICollectionView *)collectionView{
    //定时器停止
    [self pauseCyle];
    //取消之前的延迟计划
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beiginCycle) object:nil];
}

- (void)willEndDrag:(UICollectionView *)collectionView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    //定制下一个延迟计划
    [self performSelector:@selector(beiginCycle) withObject:nil afterDelay:3.f];
}

- (void)scrollView:(UICollectionView *)collectionView{
    NSInteger currentIndex = (NSInteger)(collectionView.contentOffset.x / collectionView.width + 0.5);
    self.pageView.currentPage = currentIndex % self.pageView.numberOfPages;
    _innerCarouseIndex = currentIndex;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.isScrollDirectionHorizon) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_innerCarouseIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }else{
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_innerCarouseIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
    }
}

- (void)setPageCount:(NSInteger)pageCount{
    _pageView.numberOfPages = pageCount;
    _pageView.currentPage = 0;
}

#pragma mark - 定时器
- (void)beiginCycle{
    [_cycleTimer startTimer];
}

- (void)pauseCyle{
    [_cycleTimer pauseTimer];
}

- (void)endCycle{
    [_cycleTimer endTimer];
}

- (void)dealloc{
    [_cycleTimer endTimer];
}

@end
