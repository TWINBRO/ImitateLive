//
//  MyHeaderTableViewCell.h
//  ImitateLive
//
//  Created by ssx on 16/7/13.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import <UIKit/UIKit.h>
//MyHeaderTableViewCell的重用标识符
#define MyHeaderTableViewCell_Identify @"MyHeaderTableViewCell_Identify"
@interface MyHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
