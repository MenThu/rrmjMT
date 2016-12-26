//
//  HomePageCommonViewModel.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/15.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "HomePageCommonViewModel.h"

@implementation HomePageCommonViewModel

- (instancetype)init{
    if (self = [super init]) {
        self.isFromXib = YES;
        self.howManyLine = 1;
        self.isPageEnable = NO;
        self.btnTitle = @"";
        self.btnImage = nil;
    }
    return self;
}

@end
