//
//  BriefTableViewCell.h
//  ImitateLive
//
//  Created by ssx on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"

#import "LiveModel.h"

@protocol AddAlertControllerDelegate <NSObject>

- (void)addAlertController;

@end

@interface BriefTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *collectButton;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *levelLabel;

@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;

@property (weak, nonatomic) IBOutlet UILabel *gameNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *onlineNumberLabel;

@property (assign, nonatomic) BOOL isCollect;

@property (strong, nonatomic) VideoModel *videoModel;

@property (strong, nonatomic) LiveModel *liveModel;

@property (weak, nonatomic) id<AddAlertControllerDelegate> alertDelegate;

@property (assign, nonatomic) BOOL isFavorite;
@end
