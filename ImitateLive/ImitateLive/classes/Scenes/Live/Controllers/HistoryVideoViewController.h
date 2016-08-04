//
//  HistoryVideoViewController.h
//  ImitateLive
//
//  Created by ssx on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BaseViewController.h"
#import "VideoRelationModel.h"

@protocol HistoryVideoDelegate <NSObject>

- (void)returnVideoRelationModel:(VideoRelationModel *)model;

@end

@interface HistoryVideoViewController : BaseViewController

@property (strong, nonatomic) UICollectionView *videoCollectionView;

@property (strong, nonatomic) NSMutableArray *historyVideos;

@property (strong, nonatomic) NSString *uID;

@property (weak, nonatomic) id<HistoryVideoDelegate>delegate;

@end
