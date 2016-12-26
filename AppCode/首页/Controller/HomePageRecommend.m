//
//  HomePageRecommend.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/22.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "HomePageRecommend.h"
#import "HomePageRecommendCellModel.h"
#import "HomePagePageControllerView.h"
#import "HomePagePageControllerCellModel.h"
#import "HomePageCycleCellModel.h"
#import "HomePageCommonView.h"
#import "RecommendHotEpisodeCellModel.h"

@interface HomePageRecommend ()
{
    CGFloat _offsetY;
    //头部轮播视图
    HomePagePageControllerView *_tableHeadBannerView;
    
    //定时向上滚动视图
    MTPageControlView *_cycleUpView;
    
    //全区热播视图
    HomePageCommonView *_allCommunityHotEpisode;
    
    //全区排行榜
    UIView *_allCommunityRankView;
    
    //合辑推荐
    HomePageCommonView *_recommendedCollectionView;
    
    //最新投稿
    HomePageCommonView *_recentContributeView;
    
    //整体的头部视图
    CGFloat _totalTableHeadHeight;
    UIView *_totalTableHeadView;
}

@end

@implementation HomePageRecommend

#pragma mark - 初始化
- (void)initVaribles{
    self.cellClassName = @"HomePageRecommendCell";
    self.refreshBlock = nil;
    _offsetY = 0.f;
}

- (void)configView{
    [super configView];
    MJWeakSelf
    self.mtBaseTableView.backgroundColor = [UIColor colorWithHexString:@"#2e313c"];
    
    _totalTableHeadView = [[UIView alloc] init];
    _tableHeadBannerView.backgroundColor = [UIColor clearColor];
    _totalTableHeadHeight = 0.f;
    
    //头部轮播视图
    _tableHeadBannerView = [[HomePagePageControllerView alloc] initWithFrame:CGRectMake(0, 0, YYScreenSize().width, 1000)];
    _tableHeadBannerView.collectionView.pagingEnabled = NO;
    [_totalTableHeadView addSubview:_tableHeadBannerView];
    [_tableHeadBannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_totalTableHeadView).offset(5);
        make.left.right.equalTo(_totalTableHeadView);
        make.height.mas_equalTo(1000);
    }];
    
    //定时器向上滚动视图
    _cycleUpView = [[MTPageControlView alloc] initWithFrame:CGRectMake(0, 0, YYScreenSize().width, 1000)];
    _cycleUpView.pageView.hidden = YES;
    _cycleUpView.collectionView.userInteractionEnabled = NO;
    _cycleUpView.isScrollDirectionHorizon = NO;
    _cycleUpView.cellClassName = @"HomePageCycleCell";
    _cycleUpView.numofLine = 1;
    _cycleUpView.numInaLine = 1;
    _cycleUpView.itemHeight = 50.f;
    _cycleUpView.collectionView.pagingEnabled = YES;
    _cycleUpView.marginArray = @[@(0),@(10),@(0),@(10)];
    _cycleUpView.collectionView.backgroundColor = [UIColor colorWithHexString:@"#37404e"];
    [_cycleUpView startLayout];
    [_totalTableHeadView addSubview:_cycleUpView];
    [_cycleUpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableHeadBannerView.mas_bottom).offset(5);
        make.left.right.equalTo(_totalTableHeadView);
        make.height.mas_equalTo(1000);
    }];
    
    //全区热播
    _allCommunityHotEpisode = [HomePageCommonView loadView];
    [_totalTableHeadView addSubview:_allCommunityHotEpisode];
    [_allCommunityHotEpisode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cycleUpView.mas_bottom).offset(5);
        make.left.right.equalTo(_totalTableHeadView);
        make.height.mas_equalTo(1000);
    }];
    
    _allCommunityHotEpisode.selectAct = ^(NSIndexPath *indexPath){
        if (weakSelf.push2Video) {
            weakSelf.push2Video();
        }
    };
    
    //全区排行
    _allCommunityRankView = [[NSBundle mainBundle] loadNibNamed:@"AllCommunityView" owner:self options:nil].lastObject;
    [_totalTableHeadView addSubview:_allCommunityRankView];
    [_allCommunityRankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_allCommunityHotEpisode.mas_bottom).offset(5);
        make.left.right.equalTo(_totalTableHeadView);
        make.height.mas_equalTo(1000);
    }];
    
    //合辑推荐
    _recommendedCollectionView = [HomePageCommonView loadView];
    [_totalTableHeadView addSubview:_recommendedCollectionView];
    [_recommendedCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_allCommunityRankView.mas_bottom).offset(5);
        make.left.right.equalTo(_totalTableHeadView);
        make.height.mas_equalTo(1000);
    }];
    
    //最新投稿
    _recentContributeView = [HomePageCommonView loadView];
    [_totalTableHeadView addSubview:_recentContributeView];
    [_recentContributeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_recommendedCollectionView.mas_bottom).offset(5);
        make.left.right.equalTo(_totalTableHeadView);
        make.height.mas_equalTo(1000);
    }];
    
    //全区排行
    
    //添加数据源
    NSMutableArray *tempArray = [NSMutableArray array];
    CGFloat topWidth = YYScreenSize().width-20;
    CGFloat subWidth = (YYScreenSize().width-30)/2;
    
    UIFont *bigFont = [UIFont systemFontOfSize:15];
    UIFont *smallFont = [UIFont systemFontOfSize:13];
    
    for (NSInteger index = 0; index < 1; index ++) {
        NSMutableArray *subArray = [NSMutableArray array];
        
        HomePageRecmendCellViewModel *topModel = [HomePageRecmendCellViewModel new];
        topModel.imageName = @"HomePage1.jpg";
        NSInteger temp = arc4random_uniform(5)+1;
        NSMutableString *tempString = [NSMutableString string];
        for (NSInteger stringIndex = 0; stringIndex < temp; stringIndex ++) {
            [tempString appendString:@"这是一个测试"];
        }
        topModel.des = tempString;
        topModel.recmendPerson = @"UP住推荐";
        [subArray addObject:topModel];
        
        CGFloat topHeight = topWidth/2 + 15 + [topModel.des heightForFont:bigFont width:topWidth] + [topModel.recmendPerson heightForFont:smallFont width:topWidth];
        
        
        CGFloat maxSubHeight = 0.f;
        for (NSInteger subIndex = 0; subIndex < 4; subIndex ++) {
            HomePageRecmendCellViewModel *subModel = [HomePageRecmendCellViewModel new];
            subModel.imageName = [NSString stringWithFormat:@"HomePage%ld.jpg",(long)subIndex%3+1];
            NSInteger temp = arc4random_uniform(5)+1;
            NSMutableString *tempString = [NSMutableString string];
            for (NSInteger stringIndex = 0; stringIndex < temp; stringIndex ++) {
                [tempString appendString:@"这是一个测试"];
            }
            subModel.des = tempString;
            subModel.recmendPerson = @"UP住推荐";
            [subArray addObject:subModel];
            
            CGFloat tempHeight = subWidth/2 + 15 + [subModel.des heightForFont:bigFont width:subWidth] + [subModel.recmendPerson heightForFont:smallFont width:subWidth];
            if (tempHeight > maxSubHeight) {
                maxSubHeight = tempHeight;
            }
        }
        
        HomePageRecommendCellModel *model = [HomePageRecommendCellModel new];
        model.contentArray = subArray;
        model.topHeight = topHeight;
        model.contentMaxHeight = maxSubHeight;
        model.cellHeight = topHeight + maxSubHeight*2 + 60;
        [tempArray addObject:model];
    }
    self.tableSource = tempArray;
    
    //请求网络数据
    [self getData];
}

- (void)startHttpRequest{
    
}


#pragma mark - 利用数据更新视图
- (void)getData{
    [self updateCarouseContent];
    [self updateTimerContent];
    [self updateAllCommuityContent];
    [self updateCollectionRecmmendViewContent];
    [self updateRecentContent];
    
    //获取轮播图的高度
    CGFloat tableHeadBannerHeight = [_tableHeadBannerView getmtBaseHeight];
    [_tableHeadBannerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(tableHeadBannerHeight);
    }];
    
    //获取向上轮播视图的高度
    CGFloat cycleViewHeight = [_cycleUpView getmtBaseHeight];
    [_cycleUpView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(cycleViewHeight);
    }];
    
    //全区热播的高度
    CGFloat allCommutiyHeight = [_allCommunityHotEpisode getViewHeight];
    [_allCommunityHotEpisode mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(allCommutiyHeight);
    }];
    
    //全区排行榜视图高度
    CGFloat allCommunityRankHeight = 50.f;
    [_allCommunityRankView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(allCommunityRankHeight);
    }];
    
    //合辑推荐高度
    CGFloat collectionRecmendViewHeight = [_recommendedCollectionView getViewHeight];
    [_recommendedCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(collectionRecmendViewHeight);
    }];
    
    //最新投稿
    CGFloat recentViewHeight = [_recentContributeView getViewHeight];
    [_recentContributeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(recentViewHeight);
    }];
    
    _totalTableHeadHeight = 5+tableHeadBannerHeight+5+cycleViewHeight+5+allCommutiyHeight+5+allCommunityRankHeight+5+collectionRecmendViewHeight+5+recentViewHeight+5;
}

- (void)updateCarouseContent{
    //tableHead 的 轮播图数据
    HomePagePageControllerCellModel *model1 = [HomePagePageControllerCellModel new];
    model1.cellImageName = @"HomePage1.jpg";
    HomePagePageControllerCellModel *model2 = [HomePagePageControllerCellModel new];
    model2.cellImageName = @"HomePage2.jpg";
    HomePagePageControllerCellModel *model3 = [HomePagePageControllerCellModel new];
    model3.cellImageName = @"HomePage3.jpg";
    NSArray *tempArray = @[model1, model2, model3];
    _tableHeadBannerView.carouselSource = tempArray;
}

- (void)updateTimerContent{
    //定时器视图的数据源
    NSMutableArray *cycleArray = [NSMutableArray array];
    for (NSInteger index = 0; index < 10; index ++) {
        HomePageCycleCellModel *cycleModel = [HomePageCycleCellModel new];
        cycleModel.labelName = [NSString stringWithFormat:@"[%ld]",(long)index];
        [cycleArray addObject:cycleModel];
    }
    _cycleUpView.carouselSource = cycleArray;
}

- (void)updateAllCommuityContent{
    //全区热播的数据源
    HomePageCommonViewModel *model = [HomePageCommonViewModel new];
    model.titleLabelText = @"全区热播";
    //最近更新 2行 每行2个
    NSInteger line = 2;
    NSInteger noInLine = 2;
    model.isPageControlShow = NO;
    model.cellClassName = @"HomePageRecommendHotEpisodeCell";
    model.horizonSpace = 8.f;
    model.verticalSpace = 8.f;
    model.cellImageProportion = 1.5;
    model.howManyLine = line;
    //根据每行的cell数和空隙算cell的cellwidth
    model.cellWidth = (YYScreenSize().width - 20 - (noInLine-1)*model.horizonSpace)/noInLine;
    
    RecommendHotEpisodeCellModel *cellModel1 = [RecommendHotEpisodeCellModel new];
    cellModel1.labelName = @"这是一个测试1";
    cellModel1.imageName = @"HomePage1.jpg";
    
    RecommendHotEpisodeCellModel *cellModel2 = [RecommendHotEpisodeCellModel new];
    cellModel2.labelName = @"这是一个测试2这是一个测试2这是一个测试2";
    cellModel2.imageName = @"HomePage2.jpg";
    
    RecommendHotEpisodeCellModel *cellModel3 = [RecommendHotEpisodeCellModel new];
    cellModel3.labelName = @"这是一个测试3这是一个测试3";
    cellModel3.imageName = @"HomePage3.jpg";
    
    RecommendHotEpisodeCellModel *cellModel4 = [RecommendHotEpisodeCellModel new];
    cellModel4.labelName = @"这是一个测试4哈哈哈哈哈哈";
    cellModel4.imageName = @"HomePage1.jpg";
    
    model.homePageViewCellArray = @[cellModel1, cellModel2, cellModel3, cellModel4];
    
    CGFloat maxLabelHeight = 0.f;
    UIFont *lableFont = [UIFont systemFontOfSize:15];
    for (RecommendHotEpisodeCellModel *hotModel in model.homePageViewCellArray) {
        CGFloat temp = [hotModel.labelName heightForFont:lableFont width:model.cellWidth-10];
        if (maxLabelHeight < temp) {
            maxLabelHeight = temp;
        }
    }
    model.cellHeight = model.cellWidth / model.cellImageProportion + maxLabelHeight + 10;
    _allCommunityHotEpisode.viewModel = model;
}

- (void)updateCollectionRecmmendViewContent{
    //合辑推荐的数据源
    HomePageCommonViewModel *collecitonModel = [HomePageCommonViewModel new];
    collecitonModel.titleLabelText = @"合辑推荐";
    //最近更新 2行 每行2个
    collecitonModel.isPageControlShow = NO;
    collecitonModel.cellClassName = @"HomePageRecommendHotEpisodeCell";
    collecitonModel.horizonSpace = 8.f;
    collecitonModel.verticalSpace = 8.f;
    collecitonModel.cellImageProportion = 1.5;
    collecitonModel.howManyLine = 1;
    //根据每行的cell数和空隙算cell的cellwidth
    collecitonModel.cellWidth = (YYScreenSize().width - 20 - 2*collecitonModel.horizonSpace)/2.3;
    
    RecommendHotEpisodeCellModel *collectionViewCellModel1 = [RecommendHotEpisodeCellModel new];
    collectionViewCellModel1.labelName = @"一个机械舞的视屏";
    collectionViewCellModel1.imageName = @"HomePage1.jpg";
    
    RecommendHotEpisodeCellModel *collectionViewCellModel2 = [RecommendHotEpisodeCellModel new];
    collectionViewCellModel2.labelName = @"一个机械舞的视屏一个机械舞的视屏";
    collectionViewCellModel2.imageName = @"HomePage2.jpg";
    
    RecommendHotEpisodeCellModel *collectionViewCellModel3 = [RecommendHotEpisodeCellModel new];
    collectionViewCellModel3.labelName = @"一个机械舞的视屏一个机械舞的视屏一个机械舞的视屏";
    collectionViewCellModel3.imageName = @"HomePage3.jpg";
    
    RecommendHotEpisodeCellModel *collectionViewCellModel4 = [RecommendHotEpisodeCellModel new];
    collectionViewCellModel4.labelName = @"一个机械舞的视屏一个机械舞的视屏一个机械舞的视屏一个机械舞的视屏屏";
    collectionViewCellModel4.imageName = @"HomePage1.jpg";
    
    RecommendHotEpisodeCellModel *collectionViewCellModel5 = [RecommendHotEpisodeCellModel new];
    collectionViewCellModel5.labelName = @"这个是一个机械接卸五视屏，嘻嘻嘻花生豆腐";
    collectionViewCellModel5.imageName = @"HomePage2.jpg";
    
    RecommendHotEpisodeCellModel *collectionViewCellModel6 = [RecommendHotEpisodeCellModel new];
    collectionViewCellModel6.labelName = @"这个是一个机械舞接卸五的视屏";
    collectionViewCellModel6.imageName = @"HomePage3.jpg";
    
    collecitonModel.homePageViewCellArray = @[collectionViewCellModel1, collectionViewCellModel2, collectionViewCellModel3, collectionViewCellModel4, collectionViewCellModel5,collectionViewCellModel6];
    
    CGFloat maxLabelHeight = 0.f;
    UIFont *lableFont = [UIFont systemFontOfSize:15];
    for (RecommendHotEpisodeCellModel *hotModel in collecitonModel.homePageViewCellArray) {
        CGFloat temp = [hotModel.labelName heightForFont:lableFont width:collecitonModel.cellWidth-10];
        if (maxLabelHeight < temp) {
            maxLabelHeight = temp;
        }
    }
    collecitonModel.cellHeight = collecitonModel.cellWidth / collecitonModel.cellImageProportion + maxLabelHeight + 10.5;
    _recommendedCollectionView.viewModel = collecitonModel;
    
}

- (void)updateRecentContent{
    //最新投稿的数据源
    HomePageCommonViewModel *recentModel = [HomePageCommonViewModel new];
    recentModel.titleLabelText = @"最新投稿";
    //最近更新 2行 每行2个
    recentModel.isPageControlShow = NO;
    recentModel.cellClassName = @"HomePageRecommendHotEpisodeCell";
    recentModel.horizonSpace = 8.f;
    recentModel.verticalSpace = 8.f;
    recentModel.cellImageProportion = 1.5;
    recentModel.howManyLine = 2;
    //根据每行的cell数和空隙算cell的cellwidth
    recentModel.cellWidth = (YYScreenSize().width - 20 - (2-1)*recentModel.horizonSpace)/2;
    
    RecommendHotEpisodeCellModel *recentCellModel1 = [RecommendHotEpisodeCellModel new];
    recentCellModel1.labelName = @"这是一个测试1";
    recentCellModel1.imageName = @"HomePage1.jpg";
    
    RecommendHotEpisodeCellModel *recentCellModel2 = [RecommendHotEpisodeCellModel new];
    recentCellModel2.labelName = @"这是一个测试2这是一个测试2这是一个测试2";
    recentCellModel2.imageName = @"HomePage2.jpg";
    
    RecommendHotEpisodeCellModel *recentCellModel3 = [RecommendHotEpisodeCellModel new];
    recentCellModel3.labelName = @"这是一个测试3这是一个测试3";
    recentCellModel3.imageName = @"HomePage3.jpg";
    
    RecommendHotEpisodeCellModel *recentCellModel4 = [RecommendHotEpisodeCellModel new];
    recentCellModel4.labelName = @"这是一个测试4哈哈哈哈哈哈";
    recentCellModel4.imageName = @"HomePage1.jpg";
    
    recentModel.homePageViewCellArray = @[recentCellModel1, recentCellModel2, recentCellModel3, recentCellModel4];
    
    CGFloat maxLabelHeight = 0.f;
    UIFont *lableFont = [UIFont systemFontOfSize:15];
    for (RecommendHotEpisodeCellModel *hotModel in recentModel.homePageViewCellArray) {
        CGFloat temp = [hotModel.labelName heightForFont:lableFont width:recentModel.cellWidth-10];
        if (maxLabelHeight < temp) {
            maxLabelHeight = temp;
        }
    }
    recentModel.cellHeight = recentModel.cellWidth / recentModel.cellImageProportion + maxLabelHeight + 10;
    _recentContributeView.viewModel = recentModel;
}


#pragma mark - 系统调用
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _totalTableHeadView.height = _totalTableHeadHeight;
    self.mtBaseTableView.tableHeaderView = _totalTableHeadView;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_tableHeadBannerView beiginCycle];
    [_cycleUpView beiginCycle];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_cycleUpView pauseCyle];
}

#pragma mark - 滚动代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
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
        }else if (_offsetY > self.mtBaseTableView.contentSize.height){
            _offsetY = self.mtBaseTableView.contentSize.height;
        }
    }
}

@end
