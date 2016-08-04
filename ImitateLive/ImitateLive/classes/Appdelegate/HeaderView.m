//
//  HeaderView.m
//  ImitateLive
//
//  Created by ssx on 16/7/13.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (void)awakeFromNib {
    // Initialization code
}

- (void)setHomeModel:(HomeModel *)homeModel {

    _homeModel = homeModel;
    self.headerTitleLabel.text = homeModel.title;
    self.imgView.image = [UIImage imageNamed:@"Img_orange.png"];
}

@end
