//
//  HomeEpisodeModel.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/12.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "HomeEpisodeModel.h"

@implementation HomeEpisodeModel


- (NSString *)description{
    return [NSString stringWithFormat:@"%@", @{@"cellHeight":@(self.cellHeight)}];
}

@end
