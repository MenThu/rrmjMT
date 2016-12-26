//
//  HomePageTableHeadViewLayout.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/13.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "HomePageTableHeadViewLayout.h"

@implementation HomePageTableHeadViewLayout

const CGFloat MKJMinZoomScale = 0.5f;

// 该方法会自动重载
- (void)prepareLayout
{
    [super prepareLayout];
}

// 重载第一个方法
// 返回可见区域的的内容尺寸
- (CGSize)collectionViewContentSize
{
    return [super collectionViewContentSize];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSArray * original   = [super layoutAttributesForElementsInRect:rect];
    NSArray <UICollectionViewLayoutAttributes *> *layoutAttributesArray = [[NSArray alloc] initWithArray:original copyItems:YES];
    
    for (UICollectionViewLayoutAttributes *attributes in layoutAttributesArray)
    {
        //1. 获取每个item距离可见区域左侧边框的距离 有正负
        CGFloat leftMargin = attributes.center.x - self.collectionView.contentOffset.x;
        //2. 获取边框距离屏幕中心的距离（固定的）
        CGFloat halfCenterX = self.collectionView.frame.size.width / 2;
        //3. 获取距离中心的的偏移量，需要绝对值
        CGFloat absOffset = fabs(halfCenterX - leftMargin);
        //4. 获取的实际的缩放比例 距离中心越多，这个值就越小，也就是item的scale越小 中心是方法最大的
        CGFloat scale = 1 - absOffset / halfCenterX;
        scale = MAX(0, scale);
        scale = MIN(1, scale);
        //5. 缩放
        attributes.transform3D = CATransform3DMakeScale(1 + scale * MKJMinZoomScale, 1 + scale * MKJMinZoomScale, 1);
    }
    
    return layoutAttributesArray;
}

// 重载第四个属性，item自动中心对齐
// 该方法可写可不写，主要是让滚动的item根据距离中心的值，确定哪个必须展示在中心，不会像普通的那样滚动到哪里就停到哪里
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
//{
//    NSLog(@"before:[%@]", NSStringFromCGPoint(proposedContentOffset));
//    // ProposeContentOffset是本来应该停下的位子
//    // 1. 先给一个字段存储最小的偏移量 那么默认就是无限大
//    CGFloat minOffset = CGFLOAT_MAX;
//    // 2. 获取到可见区域的centerX
//    CGFloat horizontalCenter = proposedContentOffset.x + self.collectionView.bounds.size.width / 2;
//    // 3. 拿到可见区域的rect
//    CGRect visibleRec = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
//    // 4. 获取到所有可见区域内的item数组
//    NSArray *visibleAttributes = [super layoutAttributesForElementsInRect:visibleRec];
//    
//    // 遍历数组，找到距离中心最近偏移量是多少
//    for (UICollectionViewLayoutAttributes *atts in visibleAttributes)
//    {
//        // 可见区域内每个item对应的中心X坐标
//        CGFloat itemCenterX = atts.center.x;
//        // 比较是否有更小的，有的话赋值给minOffset
//        if (fabs(itemCenterX - horizontalCenter) <= fabs(minOffset)) {
//            minOffset = itemCenterX - horizontalCenter;
//        }
//        
//    }
//    // 这里需要注意的是  上面获取到的minOffset有可能是负数，那么代表左边的item还没到中心，如果确定这种情况下左边的item是距离最近的，那么需要左边的item居中，意思就是collectionView的偏移量需要比原本更小才是，例如原先是1000的偏移，但是需要展示前一个item，所以需要1000减去某个偏移量，因此不需要更改偏移的正负
//    
//    // 但是当propose小于0的时候或者大于contentSize（除掉左侧和右侧偏移以及单个cell宽度）  、
//    // 防止当第一个或者最后一个的时候不会有居中（偏移量超过了本身的宽度），直接卡在推荐的停留位置
//    CGFloat centerOffsetX = proposedContentOffset.x + minOffset;
////    if (centerOffsetX < 0) {
////        centerOffsetX = 0;
////    }
////    
////    if (centerOffsetX > self.collectionView.contentSize.width -(self.sectionInset.left + self.sectionInset.right + self.itemSize.width)) {
////        centerOffsetX = floor(centerOffsetX);
////    }
//    
//    CGPoint afterPoint = CGPointMake(centerOffsetX, proposedContentOffset.y);
//    
//    NSLog(@"after:[%@]", NSStringFromCGPoint(afterPoint));
//
//    return afterPoint;
//}

@end
