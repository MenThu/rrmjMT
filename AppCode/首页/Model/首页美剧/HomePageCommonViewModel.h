//
//  HomePageCommonViewModel.h
//  rrmjMT
//
//  Created by MenThu on 2016/12/15.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomePageCommonViewCellModel.h"

@interface HomePageCommonViewModel : NSObject

//视图宽度
@property (nonatomic, assign) CGFloat commonViewWidth;

//最近更新等信息
@property (nonatomic, copy) NSString *titleLabelText;

//视图CellModel的Array
@property (nonatomic, strong) NSArray *homePageViewCellArray;

//cell的宽度
@property (nonatomic, assign) CGFloat cellWidth;

//cell的高度
@property (nonatomic, assign) CGFloat cellHeight;

//水平距离
@property (nonatomic, assign) CGFloat horizonSpace;

//垂直距离
@property (nonatomic, assign) CGFloat verticalSpace;

//显示多少行
@property (nonatomic, assign) NSInteger howManyLine;

//是否显示PageControl
@property (nonatomic, assign) BOOL isPageControlShow;

//PageControl的个数
@property (nonatomic, assign) NSInteger truePageNo;

//Collectionview的Cell名字
@property (nonatomic, copy) NSString *cellClassName;

//是否来自xib
@property (nonatomic, assign) BOOL isFromXib;

//视图类型,主要是为了区分精彩专题和其他的区别
@property (nonatomic, assign) NSInteger modelType;

//按钮的信息 如果两者都为空，则按钮不显示
@property (nonatomic, copy) NSString *btnTitle;
@property (nonatomic, strong) UIImage *btnImage;

//cell中图片的宽高比例
@property (nonatomic, assign) CGFloat cellImageProportion;

@property (nonatomic, assign) BOOL isPageEnable;

@end
