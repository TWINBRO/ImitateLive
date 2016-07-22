//
//  BriefViewController.h
//  ImitateLive
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BaseViewController.h"
#import "VideoModel.h"

#import "LiveModel.h"

@interface BriefViewController : BaseViewController

@property (strong, nonatomic) UITableView *briefTableView;

@property (strong, nonatomic) VideoModel *videoModel;

@property (strong, nonatomic) LiveModel *liveModel;

@end
