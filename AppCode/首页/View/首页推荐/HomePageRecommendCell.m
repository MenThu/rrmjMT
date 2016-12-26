//
//  HomePageRecommendCell.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/22.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "HomePageRecommendCell.h"
#import "HomePageRecommendCellModel.h"
#import "HomePageRecmendCellView.h"

@interface HomePageRecommendCell ()

{
    NSArray <HomePageRecmendCellView *> *_viewArray;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *content;


@property (weak, nonatomic)  HomePageRecmendCellView *headView;

@property (weak, nonatomic)  HomePageRecmendCellView *one;
@property (weak, nonatomic)  HomePageRecmendCellView *two;

@property (weak, nonatomic)  HomePageRecmendCellView *three;
@property (weak, nonatomic)  HomePageRecmendCellView *four;



@end

@implementation HomePageRecommendCell

- (void)updateCustomView{
    HomePageRecommendCellModel *model = (HomePageRecommendCellModel *)self.cellModel;
    [self.headView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(model.topHeight);
    }];
    [self.one mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(model.contentMaxHeight);
    }];
    for (NSInteger index = 0; index < model.contentArray.count; index ++) {
        _viewArray[index].model = model.contentArray[index];
    }
}

- (void)configCustomView{
    
    [self.contentView addSubview:(self.headView = [HomePageRecmendCellView loadView])];
    [self.contentView addSubview:self.one = [HomePageRecmendCellView loadView]];
    [self.contentView addSubview:(self.two = [HomePageRecmendCellView loadView])];
    [self.contentView addSubview:(self.three = [HomePageRecmendCellView loadView])];
    [self.contentView addSubview:(self.four = [HomePageRecmendCellView loadView])];

    @weakify(self);
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.contentView).offset(30);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(200);
    }];
    
    [self.one mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.headView.mas_bottom).offset(10);
        make.left.equalTo(self.headView);
        make.right.equalTo(self.two.mas_left).offset(-10);
        make.height.mas_equalTo(200);
        make.width.equalTo(self.two);
    }];
    
    [self.two mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.one);
        make.right.equalTo(self.headView);
        make.height.equalTo(self.one);
    }];
    
    [self.three mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.right.width.height.equalTo(self.one);
        make.top.equalTo(self.one.mas_bottom).offset(10);
    }];
    
    [self.four mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.right.width.height.equalTo(self.two);
        make.top.equalTo(self.three);
    }];
    _viewArray = @[self.headView, self.one, self.two, self.three, self.four];
}


@end
