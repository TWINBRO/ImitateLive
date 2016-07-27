//
//  TalentShowViewController.h
//  ImitateLive
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BaseViewController.h"
#import "LiveModel.h"
@interface TalentShowViewController : BaseViewController
@property (strong, nonatomic) LiveModel *liveModel;

@property (strong, nonatomic)UITableView *chatTableView;

@property (strong, nonatomic) UITextView *msgTextView;

@property (strong, nonatomic) AVIMClient *client;

@property (strong, nonatomic) NSString *clientName;

@property (strong, nonatomic) NSString *conversationID;

@property (strong, nonatomic) NSMutableArray *msgArray;

- (void)addSendView;

@end
