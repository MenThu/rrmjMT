//
//  HomePageRecmendCellView.m
//  rrmjMT
//
//  Created by MenThu on 2016/12/22.
//  Copyright © 2016年 MenThu. All rights reserved.
//

#import "HomePageRecmendCellView.h"


@interface HomePageRecmendCellView ()

@property (weak, nonatomic) IBOutlet UIImageView *videoImage;

@property (weak, nonatomic) IBOutlet UILabel *videoLabel;

@property (weak, nonatomic) IBOutlet UILabel *videoPerson;

@end

@implementation HomePageRecmendCellView

+ (instancetype)loadView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
}

- (void)setModel:(HomePageRecmendCellViewModel *)model{
    _model = model;
    
    NSLog(@"[%@] [%@] [%@]", model.imageName, model.des, model.recmendPerson);
    self.videoImage.image = [UIImage imageNamed:model.imageName];
    self.videoLabel.text = model.des;
    self.videoPerson.text = model.recmendPerson;
}

@end
