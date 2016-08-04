//
//  ChatViewController.h
//  ImitateLive
//
//  Created by ssx on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BaseViewController.h"
#import "LiveModel.h"

@protocol DanMuDelegate <NSObject>

- (void)sendDanMuWithArray:(NSMutableArray *)array;

@end

@interface ChatViewController : BaseViewController

@property (strong, nonatomic)UITableView *chatTableView;

@property (strong, nonatomic) UITextView *msgTextView;

@property (strong, nonatomic) AVIMClient *client;

@property (strong, nonatomic) LiveModel *liveModel;

@property (strong, nonatomic) NSString *clientName;

@property (strong, nonatomic) NSString *conversationID;

@property (strong, nonatomic) NSMutableArray *msgArray;

- (void)addSendView;


@property (weak, nonatomic) id<DanMuDelegate> danmuDelegate;

@end
