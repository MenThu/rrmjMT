//
//  HomePageVC.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/9.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "HomePageVC.h"
#import "MTBaseNavigationVC.h"
#import "HomePageTitle.h"
#import "HomePageEpisode.h"
#import "HomePageTitleCell.h"
#import "HomePageTitleCellModel.h"
#import "HomePageRecommend.h"

@interface HomePageVC ()

{
    NSArray *_homePageTitle;
    NSArray *_homePageContent;
    CGFloat _itemHeight;
    HomePageTitle *_titleView;
    NSArray <HomePageTitleCell *> *_titleCellArray;
}

@end

@implementation HomePageVC

- (void)configNavigationItem{
    self.navigationItem.title = @"首页";
    //如果需要调整右侧距离，则调用父类方法
    [super configNavigationItem];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!_titleCellArray) {
        [self getTitleCells];
    }
}

- (void)initVariable{
    self.collectionViewMarginArray = @[@(50),@(0),@(0),@(0)];
    _itemHeight = YYScreenSize().height - 50 -49;
    self.itemHeight = _itemHeight;
    self.cellClassName = @"HomePageContentCell";
    self.isFromXib = NO;
}

- (void)showOrHideNavibar:(BOOL)isHidden{
    if (isHidden) {
        //设置隐藏
        if (self.navigationController.navigationBar.hidden == NO) {
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }
    }else{
        //设置显示
        if (self.navigationController.navigationBar.hidden == YES) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
    }
}

- (void)configView{
    [super configView];

    MJWeakSelf;
    //美剧内容控制器
    HomePageEpisode *episodeVC = [[HomePageEpisode alloc] init];
    episodeVC.letNaviBarHidden = ^(BOOL isHidden){
        [weakSelf showOrHideNavibar:isHidden];
    };
    [self addChildViewController:episodeVC];
    
    //推荐内容控制器
    HomePageRecommend *recommendVC = [[HomePageRecommend alloc] init];
    recommendVC.letNaviBarHidden = ^(BOOL isHidden){
        [weakSelf showOrHideNavibar:isHidden];
    };
    
    recommendVC.push2Video = ^(){
        
    };
    
    [self addChildViewController:recommendVC];
    _homePageContent = self.childViewControllers;
    
    //添加title
    CGFloat titleHeight = 50.f;
    HomePageTitle *titleView = [[HomePageTitle alloc] initWithFrame:CGRectMake(0, 0, YYScreenSize().width, 0)];
    
    HomePageTitleCellModel *model1 = [HomePageTitleCellModel new];
    model1.titleString = @"美剧";
    model1.selectPercent = 0;
    
    HomePageTitleCellModel *model2 = [HomePageTitleCellModel new];
    model2.titleString = @"推荐";
    model2.selectPercent = 0;
    
    HomePageTitleCellModel *model3 = [HomePageTitleCellModel new];
    model3.titleString = @"频道";
    model3.selectPercent = 0;
    
    _homePageTitle = @[model1, model2, model3];
    [self.view addSubview:(_titleView = titleView)];
     _titleView.height = [_titleView getmtBaseHeight];
    _titleView.collectionViewSource = _homePageTitle;
    
    self.collectionView.pagingEnabled = YES;
    //刷新内容区域
    self.collectionViewSource = _homePageContent;
    @weakify(self);
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.view).offset(titleHeight);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(_itemHeight);
    }];
}

- (void)startHttpRequest{
    
}

- (void)scrollViewMove:(CGPoint)contentOffset view:(UICollectionView *)scrollView{
    CGFloat offsetX = contentOffset.x;
    if (offsetX>self.collectionView.contentSize.width-YYScreenSize().width) {
        offsetX = self.collectionView.contentSize.width-YYScreenSize().width;
    }else if (offsetX < 0){
        offsetX = 0;
    }
    CGPoint inContentSizeOffset = CGPointMake(offsetX, 0);
    [_titleView updateUnderLineFrame:inContentSizeOffset];
}


#pragma mark - 内部方法
//获取title
- (void)getTitleCells{
    return;
    NSMutableArray *tempCell = [NSMutableArray array];
    for (NSInteger index = 0; index < 3; index ++) {
        HomePageTitleCell *cell = (HomePageTitleCell *)[_titleView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        [tempCell addObject:cell];
    }
    _titleCellArray = [NSArray arrayWithArray:tempCell];
}

@end
