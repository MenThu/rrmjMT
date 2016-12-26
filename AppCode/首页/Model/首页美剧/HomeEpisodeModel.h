//
//  HomeEpisodeModel.h
//  rrmjMT
//
//  Created by MenThu on 2016/12/12.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "MTBaseCellModel.h"
#import "HomePageCommonViewCellModel.h"

@interface HomeEpisodeModel : MTBaseCellModel

//子cell的宽度
@property (nonatomic, assign) CGFloat cellWidth;

//子cell间的距离
@property (nonatomic, assign) CGFloat cellHorizonSpace;

@property (nonatomic, strong) NSArray <HomePageCommonViewCellModel *> *cellArray;

@end
