//
//  HomePageEpisode.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/10.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "HomePageEpisode.h"
#import "HomeEpisodeModel.h"
#import "HomePagePageControllerView.h"
#import "HomePagePageControllerCellModel.h"
#import "HomePageCommonView.h"
#import "HomePageWonderfulTopic.h"

@interface HomePageEpisode ()
{
    CGFloat _offsetY;

    //首页 美剧，推荐 特效轮播视图
    HomePagePageControllerView *_tableHeadBannerView;
    
    //排期表 剧集分类
    UIView *_scheduleSortView;
    
    //最近更新的视图
    HomePageCommonView *_recentlyUpdateView;
    
    //精彩专题的视图
    HomePageWonderfulTopic *_brilliantTopicView;
    
    //本季新剧
    HomePageCommonView *_seasonNewEpisode;
    
    //UITableView的整体视图及其高度
    UIView *_totalTableHeadView;
    CGFloat _totalTableHeadHeight;
}
@end

@implementation HomePageEpisode

- (void)configView{
    [super configView];
    
    self.mtBaseTableView.backgroundColor = [UIColor colorWithHexString:@"#2e313c"];
    
    _totalTableHeadHeight = 0.f;
    _totalTableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YYScreenSize().width, 0)];
    
    //加载首页轮播图
    _tableHeadBannerView = [[HomePagePageControllerView alloc] initWithFrame:CGRectMake(0, 5, YYScreenSize().width, 1000)];
    [_totalTableHeadView addSubview:_tableHeadBannerView];
    
    //排期表 剧集分类
    _scheduleSortView = [[NSBundle mainBundle] loadNibNamed:@"HomePageTableHeadSortView" owner:self options:nil].lastObject;
    [_totalTableHeadView addSubview:_scheduleSortView];
    [_scheduleSortView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableHeadBannerView.mas_bottom).offset(5);
        make.height.mas_equalTo(80);
        make.left.right.equalTo(_totalTableHeadView);
    }];
    
    //添加最近更新视图
    _recentlyUpdateView = [HomePageCommonView loadView];
    [_totalTableHeadView addSubview:_recentlyUpdateView];
    [_recentlyUpdateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scheduleSortView.mas_bottom).offset(5);
        make.left.right.equalTo(_totalTableHeadView);
        make.height.mas_equalTo(1000);
    }];
    
    //精彩专题
    _brilliantTopicView = [[HomePageWonderfulTopic alloc] initWithFrame:CGRectMake(0, 0, 1000, 1000)];
    [_totalTableHeadView addSubview:_brilliantTopicView];
    [_brilliantTopicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_recentlyUpdateView.mas_bottom).offset(5);
        make.left.right.equalTo(_totalTableHeadView);
        make.height.mas_equalTo(1500);
    }];
    
    //本季新剧
    _seasonNewEpisode = [HomePageCommonView loadView];
    [_totalTableHeadView addSubview:_seasonNewEpisode];
    [_seasonNewEpisode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_brilliantTopicView.mas_bottom).offset(5);
        make.left.right.equalTo(_totalTableHeadView);
        make.height.mas_equalTo(1000);
    }];
    
    UILabel *mostHotEpisode = [UILabel new];
    mostHotEpisode.text = @"最热剧集";
    mostHotEpisode.font = [UIFont systemFontOfSize:15];
    mostHotEpisode.textColor = [UIColor whiteColor];
    [_totalTableHeadView addSubview:mostHotEpisode];
    [mostHotEpisode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_seasonNewEpisode.mas_bottom).offset(5);
        make.left.equalTo(_totalTableHeadView).offset(10);
        make.height.mas_equalTo(20);
    }];

    //准备测试数据
    [self getData];
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

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_tableHeadBannerView beiginCycle];
    [_brilliantTopicView.carouseView beiginCycle];
}

- (void)updateRecentViewContent{
    //最近更新
    //数据源
    HomePageCommonViewModel *model = [HomePageCommonViewModel new];
    model.titleLabelText = @"最近更新";
    //最近更新 2行 每行3个
    model.isPageControlShow = NO;
    model.cellClassName = @"HomePageCommonCell";
    model.horizonSpace = 8.f;
    model.verticalSpace = 8.f;
    model.cellImageProportion = 0.7;
    model.howManyLine = 2;
    //根据每行的cell数和空隙算cell的cellwidth
    model.cellWidth = (YYScreenSize().width - 20 - (3-1)*model.horizonSpace)/3;
    
    HomePageCommonViewCellModel *cellModel1 = [HomePageCommonViewCellModel new];
    cellModel1.episodeName = @"吸血鬼故事";
    cellModel1.currentUpdate = @"更新至第一季第15集";
    cellModel1.imageSring = @"HomePage1.jpg";
    //计算episodeName currentUpdate所需要的高度
    CGFloat episodeNameHeight = [cellModel1.episodeName heightForFont:[UIFont systemFontOfSize:16] width:model.cellWidth];
    CGFloat currentUpdateHeight = [cellModel1.currentUpdate heightForFont:[UIFont systemFontOfSize:13] width:model.cellWidth];
    cellModel1.imageMarginBottom = episodeNameHeight + currentUpdateHeight + 15;
    model.cellHeight = (model.cellWidth / model.cellImageProportion) + cellModel1.imageMarginBottom;
    model.homePageViewCellArray = @[cellModel1, cellModel1, cellModel1, cellModel1, cellModel1, cellModel1];
    _recentlyUpdateView.viewModel = model;
}

- (void)updateWonderfulViewContent{
    //精彩专题数据源
    HomePagePageControllerCellModel *homePageModel1 = [HomePagePageControllerCellModel new];
    homePageModel1.cellImageName = @"HomePage1.jpg";
    HomePagePageControllerCellModel *homePageModel2 = [HomePagePageControllerCellModel new];
    homePageModel2.cellImageName = @"HomePage2.jpg";
    HomePagePageControllerCellModel *homePageModel3 = [HomePagePageControllerCellModel new];
    homePageModel3.cellImageName = @"HomePage3.jpg";
    HomePageCommonViewModel *topModel = [HomePageCommonViewModel new];
    topModel.btnTitle = @"更多";
    topModel.titleLabelText = @"精彩专题";
    topModel.cellWidth = YYScreenSize().width-20;
    topModel.cellHeight = topModel.cellWidth*0.5;
    topModel.cellClassName = @"HomePagePageControllerCell";
    topModel.homePageViewCellArray = @[homePageModel1, homePageModel2, homePageModel3];
    _brilliantTopicView.viewModel = topModel;
}

- (void)updateSeasonNewEpisodeContent{
    //本季新剧数据源
    HomePageCommonViewModel *newEpisodeModel = [HomePageCommonViewModel new];
    newEpisodeModel.titleLabelText = @"本季新剧";
    newEpisodeModel.horizonSpace = 8.f;
    newEpisodeModel.verticalSpace = 8.f;
    newEpisodeModel.cellWidth = (YYScreenSize().width-20 - 3*newEpisodeModel.horizonSpace)/3.2;
    newEpisodeModel.isPageControlShow = NO;
    newEpisodeModel.cellClassName = @"HomePageCommonCell";
    
    
    HomePageCommonViewCellModel *newEpisodeCellModel = [HomePageCommonViewCellModel new];
    newEpisodeCellModel.episodeName = @"吸血鬼故事";
    newEpisodeCellModel.currentUpdate = @"更新至第一季第15集";
    newEpisodeCellModel.imageSring = @"HomePage1.jpg";
    
    CGFloat newEpisodeNameHeight = [newEpisodeCellModel.episodeName heightForFont:[UIFont systemFontOfSize:16] width:newEpisodeModel.cellWidth];
    CGFloat newCurrentUpdateHeight = [newEpisodeCellModel.currentUpdate heightForFont:[UIFont systemFontOfSize:13] width:newEpisodeModel.cellWidth];
    newEpisodeCellModel.imageMarginBottom = newEpisodeNameHeight + newCurrentUpdateHeight + 15.f;
    newEpisodeModel.cellHeight = (newEpisodeModel.cellWidth / 0.7) + newEpisodeCellModel.imageMarginBottom;
    newEpisodeModel.homePageViewCellArray = @[newEpisodeCellModel, newEpisodeCellModel, newEpisodeCellModel, newEpisodeCellModel, newEpisodeCellModel, newEpisodeCellModel];
    _seasonNewEpisode.viewModel = newEpisodeModel;
}

- (void)getData{
    //首页轮播
    [self updateCarouseContent];
    //最近更新
    [self updateRecentViewContent];
    //精彩专题
    [self updateWonderfulViewContent];
    //本季新剧
    [self updateSeasonNewEpisodeContent];

    //获取轮播图的高度
    CGFloat tableHeadBannerHeight = [_tableHeadBannerView getmtBaseHeight];
    _tableHeadBannerView.height = tableHeadBannerHeight;
    
    //排期表，剧集分类高度
    CGFloat scheduleSortViewHeight = 80.f;
    
    //最近更新视图高度
    CGFloat recentlyUpdateViewHeight = [_recentlyUpdateView getViewHeight];
    
    //获取精彩专题的高度
    CGFloat topicViewHeight = [_brilliantTopicView getViewHeight];
    
    //获取本季新剧的高度
    CGFloat newSeasonEpisodeHeight = [_seasonNewEpisode getViewHeight];
    
    _totalTableHeadHeight = tableHeadBannerHeight + scheduleSortViewHeight + recentlyUpdateViewHeight + topicViewHeight + newSeasonEpisodeHeight + 60;
    
    [_scheduleSortView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(scheduleSortViewHeight);
    }];
    
    [_recentlyUpdateView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(recentlyUpdateViewHeight);
    }];
    
    [_brilliantTopicView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(topicViewHeight);
    }];
    
    [_seasonNewEpisode mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(newSeasonEpisodeHeight);
    }];
    
    //Cell的数据源
    NSMutableArray *cellLineArray = [NSMutableArray array];
    UIFont *episodeFont = [UIFont systemFontOfSize:16];
    UIFont *updateFont = [UIFont systemFontOfSize:13];
    CGFloat cellWidth = (YYScreenSize().width - 20 - 16) / 3;
    CGFloat imageHeight = cellWidth/0.7;
    //一共有100行
    for (NSInteger index = 0; index < 50; index ++) {
        BOOL isEvenNo = (index % 2 == 0 ? YES : NO);
        
        /**
         偶数行整体多高一倍
         **/
        
        NSString *episodeName;
        NSString *currentUpdate;
        
        if (isEvenNo) {
            episodeName = @"吸血鬼故事吸血鬼故事";
            currentUpdate = @"更新至第一季第15集";
        }else{
            episodeName = @"吸血鬼故事";
            currentUpdate = @"更新至第一季第15集";
        }
        
        
        HomePageCommonViewCellModel *cellModel1 = [HomePageCommonViewCellModel new];
        cellModel1.episodeName = episodeName;
        cellModel1.currentUpdate = currentUpdate;
        cellModel1.imageSring = @"HomePage1.jpg";
        
        
        HomePageCommonViewCellModel *cellModel2 = [HomePageCommonViewCellModel new];
        cellModel2.episodeName = episodeName;
        cellModel2.currentUpdate = currentUpdate;
        cellModel2.imageSring = @"HomePage2.jpg";
        
        HomePageCommonViewCellModel *cellModel3 = [HomePageCommonViewCellModel new];
        cellModel3.episodeName = episodeName;
        cellModel3.currentUpdate = currentUpdate;
        cellModel3.imageSring = @"HomePage3.jpg";
        
        NSArray <HomePageCommonViewCellModel *> *tempArray = @[cellModel1, cellModel2, cellModel3];
        
        //随机一个cell再double
        NSInteger index = arc4random_uniform(3);
        HomePageCommonViewCellModel *tempModel = tempArray[index];
        tempModel.episodeName = [NSString stringWithFormat:@"%@%@", episodeName,episodeName];
        tempModel.currentUpdate = [NSString stringWithFormat:@"%@%@", currentUpdate,currentUpdate];
        
        CGFloat lineMaxHeight = 0;
        CGFloat tempHeight = 0;
        for (HomePageCommonViewCellModel *model in tempArray) {
            model.imageMarginBottom = [model.episodeName heightForFont:episodeFont width:cellWidth] + [model.currentUpdate heightForFont:updateFont width:cellWidth] + 15;
            tempHeight = model.imageMarginBottom + imageHeight + 10;
            if (lineMaxHeight < tempHeight) {
                lineMaxHeight = tempHeight;
            }
        }
        
        HomeEpisodeModel *model = [HomeEpisodeModel new];
        model.cellHorizonSpace = 8.f;
        model.cellWidth = cellWidth;
        model.cellArray = tempArray;
        model.cellHeight = lineMaxHeight;
        [cellLineArray addObject:model];
    }
    self.tableSource = [NSArray arrayWithArray:cellLineArray];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _totalTableHeadView.height = _totalTableHeadHeight;
    self.mtBaseTableView.tableHeaderView = _totalTableHeadView;
}

- (void)initVaribles{
    self.cellClassName = @"HomePageEpisodeCell";
    self.refreshBlock = nil;
    _offsetY = 0;
}

- (void)startHttpRequest{
    
}

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

#pragma mark - 懒加载

@end
