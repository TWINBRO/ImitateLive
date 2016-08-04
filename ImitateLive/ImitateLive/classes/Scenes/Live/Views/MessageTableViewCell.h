//
//  MessageTableViewCell.h
//  ImitateLive
//
//  Created by ssx on 16/7/21.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MessageTableViewCell_Identify @"MessageTableViewCell_Identify"

@interface MessageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userNmaeLabel;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end
