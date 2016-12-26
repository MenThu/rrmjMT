//
//  HomePageWonderfulTopic.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/24.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "HomePageWonderfulTopic.h"
#import "MTPageControlView.h"

@interface HomePageWonderfulTopic ()
{
    UILabel *_titleLabel;
    UIButton *_actButton;
    CGFloat _viewHeight;
    //视图内元素的间距
    CGFloat _itemSpace;
    CGFloat _labelHeight;
}

@property (nonatomic, strong, readwrite) MTPageControlView *carouseView;

@end

@implementation HomePageWonderfulTopic

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configContent];
    }
    return self;
}

- (void)configContent{
    
    _itemSpace = 10.f;
    _labelHeight = 20.f;
    
    UILabel *label = [UILabel new];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label];
    _titleLabel = label;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor colorWithHexString:@"#3198C6"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(touchActButton:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:button];
    _actButton = button;
    
    //高度随意给的，为的只是不报itemHeight 比 collectionview 高 的 错误
    MTPageControlView *carouseView = [[MTPageControlView alloc] initWithFrame:CGRectMake(0, 0, YYScreenSize().width, 1000)];
    [self addSubview:carouseView];
    _carouseView = carouseView;
    
    //建立约束
    MJWeakSelf;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf).offset(_itemSpace);
        make.right.equalTo(_actButton.mas_left).offset(-_itemSpace);
        make.height.mas_equalTo(_labelHeight);
    }];
    
    [_actButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.equalTo(_titleLabel);
        make.right.equalTo(weakSelf).offset(-_itemSpace);
        make.width.mas_equalTo(20.f);
    }];
    
    //设置水平被放大的优先级
    //    [_titleLabel setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisVertical];
    //    [_actButton setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    [_carouseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(_itemSpace);
        make.left.equalTo(_titleLabel);
        make.bottom.equalTo(weakSelf).offset(-_itemSpace);
        make.right.equalTo(_actButton);
        make.height.mas_equalTo(1000.f);
    }];
}

- (void)setViewModel:(HomePageCommonViewModel *)viewModel{
    _viewModel = viewModel;
    
    _titleLabel.text = viewModel.titleLabelText;
    [_actButton setTitle:viewModel.btnTitle forState:UIControlStateNormal];
    CGFloat btnTitleWidth = [viewModel.btnTitle widthForFont:_actButton.titleLabel.font];
    [_actButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(btnTitleWidth+10);
    }];
    
    _carouseView.cellClassName = viewModel.cellClassName;
    _carouseView.itemHeight = viewModel.cellHeight;
    [_carouseView startLayout];
    _carouseView.carouselSource = viewModel.homePageViewCellArray;
    CGFloat carouseViewHeight = [_carouseView getmtBaseHeight];
    [_carouseView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(carouseViewHeight);
    }];
    _viewHeight = carouseViewHeight + _labelHeight + 3 * _itemSpace;
//    NSLog(@"%f %f", carouseViewHeight,_viewHeight);
}

- (CGFloat)getViewHeight{
    return _viewHeight;
}

- (void)touchActButton:(UIButton *)actButton{
    NSLog(@"touch");
}

@end
