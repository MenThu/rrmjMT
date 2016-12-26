//
//  HomePageCommonViewCellModel.h
//  rrmjMT
//
//  Created by MenThu on 2016/12/15.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageCommonViewCellModel : NSObject

//图片名字
@property (nonatomic, copy) NSString  *imageSring;
//剧集名字
@property (nonatomic, copy) NSString  *episodeName;
//目前的更新状态
@property (nonatomic, copy) NSString  *currentUpdate;
//Image距离cell底部的距离
@property (nonatomic, assign) CGFloat imageMarginBottom;

@end
