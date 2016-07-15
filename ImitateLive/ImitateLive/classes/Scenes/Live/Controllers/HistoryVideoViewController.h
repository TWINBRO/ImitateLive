//
//  HistoryVideoViewController.h
//  ImitateLive
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BaseViewController.h"

@interface HistoryVideoViewController : BaseViewController

@property (strong, nonatomic) UICollectionView *videoCollectionView;

@property (strong, nonatomic) NSMutableArray *historyVideos;

@property (strong, nonatomic) NSString *uID;

@end
