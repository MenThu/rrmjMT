//
//  HomePagePageControllerView.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/13.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "HomePagePageControllerView.h"
#import "HomePageTableHeadViewLayout.h"

@interface HomePagePageControllerView ()
{
    NSInteger _startRow;
}

@end


@implementation HomePagePageControllerView

const CGFloat sectionSpace = 60.f;
- (void)customView{
    [super customView];
    //替换掉UICollectionveiwFlowLayout
    HomePageTableHeadViewLayout *layout = [[HomePageTableHeadViewLayout alloc] init];
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.pagingEnabled = NO;
    self.collectionView.decelerationRate = 0.5;
}

- (void)initVariable{
    self.numInaLine = 1;
    self.horizonSpace = self.width/7;
    self.marginArray = @[@(5),@(0),@(25),@(0)];
    self.itemHeight = 150.f;
    self.sectionInset = UIEdgeInsetsMake(0, self.width/4, 0, self.width/4);;
    self.cellClassName = @"HomePagePageControllerCell";
    self.itemWidth = self.width/2;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    HomePageTableHeadViewLayout *layout = (HomePageTableHeadViewLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(layout.itemSize.width, self.itemHeight*0.65);
    self.collectionView.collectionViewLayout = layout;
}

- (void)willEndDrag:(UICollectionView *)collectionView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@"%ld", (long)self.innerCarouseIndex);
    CGFloat direction = velocity.x;
    UICollectionViewCell *targetCell = nil;
    if (direction > 0) {
        //向左拖动
        if (self.innerCarouseIndex < self.collectionViewSource.count - 1) {
            //还未到最右边
            self.innerCarouseIndex++;
        }else{
            //从头开始
            self.innerCarouseIndex = 0;
        }
        NSLog(@"left   %ld", (long)self.innerCarouseIndex);
    }else if (direction < 0){
        //向右拖动
        if (self.innerCarouseIndex > 0) {
            //还未到最左边
            self.innerCarouseIndex--;
        }else{
            self.innerCarouseIndex = self.collectionViewSource.count - 1;
        }
        NSLog(@"right   %ld", (long)self.innerCarouseIndex);
    }else{
        //获取当前屏幕内的Cell
        NSArray <UICollectionViewCell *> *visibleArray = [self.collectionView visibleCells];
        CGPoint middlePoint = collectionView.contentOffset;
        CGFloat horizonSpace = MAXFLOAT;
        
        //选择中心距离屏幕中心最近的那个Cell，将其作为基准Cell
        NSIndexPath *middleCellIndexPath = nil;
        for (UICollectionViewCell *cell in visibleArray) {
            CGFloat temp = cell.centerX - middlePoint.x - self.collectionView.width/2;
            if (fabs(temp) < fabs(horizonSpace)) {
                middleCellIndexPath = [self.collectionView indexPathForCell:cell];
                horizonSpace = temp;
            }
        }
        self.innerCarouseIndex = middleCellIndexPath.row;
    }
    targetCell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.innerCarouseIndex inSection:0]];
    if (!targetCell) {
        NSLog(@"未获取到Cell");
        return;
    }
    *targetContentOffset = CGPointMake(targetCell.centerX - self.collectionView.width/2, 0);
    self.pageView.currentPage = self.innerCarouseIndex % self.pageView.numberOfPages;
    [super willEndDrag:collectionView withVelocity:velocity targetContentOffset:targetContentOffset];
}

- (void)nextPage{
    [super nextPage];
    self.pageView.currentPage = self.innerCarouseIndex % self.pageView.numberOfPages;
}

- (void)scrollView:(UICollectionView *)collectionView{
    //覆盖掉父类控制pageControl的方法
}

@end
