//
//  ChatViewController.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "ChatViewController.h"
#import "LoginViewController.h"
#import "MessageTableViewCell.h"

@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate,AVIMClientDelegate,UITextViewDelegate>

// 聊天室
@property (strong, nonatomic) AVIMConversation *conversation;
// 所有消息
@property (strong, nonatomic) NSMutableArray *messageArr;

@end



@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化消息数组
    self.msgArray = [NSMutableArray array];
    
    self.chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -2, WindownWidth, WindowHeight-345) style:UITableViewStylePlain];
//    self.chatTableView.backgroundColor = [UIColor greenColor];
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
    
    [self.chatTableView registerNib:[UINib nibWithNibName:@"MessageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MessageTableViewCell_Identify];
    
    self.chatTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.chatTableView];
    
    [self addSendView];
   
    self.messageArr = [NSMutableArray array];
    [self queryConversationByConditions];
    
    
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"] isEqualToString:@"0"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您未登录,登录后才能发言" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            LoginViewController *loginVC = [mainSb instantiateViewControllerWithIdentifier:@"LoginViewController"];
            
            [self presentViewController:loginVC animated:YES completion:nil];
            
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        // 添加按钮
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    return YES;
    
}

- (void)addSendView {
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(70, WindowHeight - 345, WindownWidth-140, 50)];
    self.msgTextView = textView;
    self.msgTextView.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:210.0/255.0 alpha:1];
    self.msgTextView.delegate = self;
    self.msgTextView.text = @"发点弹幕吧！";
    self.msgTextView.textColor = [UIColor grayColor];
    [self.view addSubview:self.msgTextView];
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.backgroundColor = [UIColor colorWithRed:210.0/255.0 green:230.0/255.0 blue:210.0/255.0 alpha:1];
    [sendBtn setImage:[UIImage imageNamed:@"发送弹幕(1)"] forState:UIControlStateNormal];
    sendBtn.frame = CGRectMake(WindownWidth - 70, WindowHeight - 345, 70, 50 );
    [sendBtn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
    
}


- (void)sendAction:(UIButton *)button
{
    
    [self sendMessage];
    
}
#pragma mark -- 聊天
// 创建聊天室
- (void)creatTransientCoversation
{
    // Tom 创建了一个 client，用自己的名字作为 clientId
    __weak typeof(self) weakSelf = self;
    self.conversation = [[AVIMConversation alloc] init];
    // Tom 打开 client
    [self.client openWithCallback:^(BOOL succeeded, NSError *error) {
        // Tom 创建名称为 「HelloKitty PK 加菲猫」的会话
        [weakSelf.client createConversationWithName:weakSelf.liveModel.nickname clientIds:@[weakSelf.liveModel.liveID] attributes:nil options:AVIMConversationOptionTransient callback:^(AVIMConversation *conversation, NSError *error) {
            if (!error) {
                NSLog(@"创建成功！");
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.conversation = conversation;
                });
            }else
            {
                NSLog(@"%@",error);
            }
        }];
    }];
}

// 查询聊天室
- (void)queryConversationByConditions {
    // Tom 创建了一个 client，用自己的名字作为 clientId
    __weak typeof(self) weakSelf = self;
    self.client = [[AVIMClient alloc] initWithClientId:self.liveModel.liveID];
    self.client.delegate = self;
    // Tom 打开 client
    [self.client openWithCallback:^(BOOL succeeded, NSError *error) {
        // Tom 创建属性中 topic 是 movie 的查询
        AVIMConversationQuery *query = [weakSelf.client conversationQuery];
        [query whereKey:@"name" equalTo:weakSelf.liveModel.nickname];
        // 额外调用一次确保查询的是聊天室而不是普通对话
        [query whereKey:@"tr" equalTo:@(YES)];
        [query findConversationsWithCallback:^(NSArray *objects, NSError *error) {
            if (error) {
                NSLog(@"queryConversation error = %@",error);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (objects.count != 0) {
                    weakSelf.conversation = [objects firstObject];
                  //  [weakSelf getConversationFromSever];
                    
                }else{
                    [weakSelf creatTransientCoversation];
                }
            });
            
        }];
    }];
    
}
// 加入聊天室
- (void)joinConversation
{
    [self.client openWithCallback:^(BOOL succeeded, NSError *error) {
        AVIMConversationQuery *query = [self.client conversationQuery];
        [query getConversationById:self.conversation.conversationId callback:^(AVIMConversation *conversation, NSError *error) {
            [conversation joinWithCallback:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"加入成功！");
                }
            }];
        }];
    }];
}
// 发送消息
- (void)sendMessage
{
    NSString *currentUsername = [AVUser currentUser].username;// 当前用户名
    
    __weak typeof(self) weakSelf = self;
    AVIMTextMessage *message = [AVIMTextMessage messageWithText:self.msgTextView.text attributes:@{@"userName":currentUsername}];
    [self.client openWithCallback:^(BOOL succeeded, NSError *error) {
        [weakSelf.conversation sendMessage:message  callback:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"发送成功！");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.messageArr addObject:message];
                    [weakSelf.chatTableView reloadData];
                    [weakSelf scrollViewToBottom];
                });
            }else if (error){
                NSLog(@"%@",error);
            }
        }];
    }];
}
#pragma mark - AVIMClientDelegate
// 接收消息
- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message {
    NSLog(@"%@", message.text); // 你们在哪儿？
    [self.messageArr addObject:message];
    [self.chatTableView reloadData];
    [self scrollViewToBottom];
}
// 获取消息
- (void)getConversationFromSever
{
    __weak typeof(self) weakSelf = self;
    [self.client openWithCallback:^(BOOL succeeded, NSError *error) {
        // Tom 创建查询会话的 query
        AVIMConversationQuery *query = [weakSelf.client conversationQuery];
        // Tom 获取 id 为 2f08e882f2a11ef07902eeb510d4223b 的会话
        [query getConversationById:weakSelf.conversation.conversationId callback:^(AVIMConversation *conversation, NSError *error) {
            // 查询对话中最后 10 条消息，由于之前关闭了消息缓存功能，查询会走网络请求。
            [conversation queryMessagesWithLimit:10 callback:^(NSArray *objects, NSError *error) {
                NSLog(@"查询成功！");
                if (!error) {
                    for (AVIMTextMessage *textMessage in objects) {
                        [weakSelf.messageArr addObject:textMessage];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.chatTableView reloadData];
                        [weakSelf scrollViewToBottom];
                    });
                    
                }
            }];
        }];
    }];
    
}
- (void)scrollViewToBottom
{
    if (self.messageArr.count < 1) {
        return;
    }
    // 获取tableview的最后一行
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.messageArr.count - 1 inSection:0];
    // 滑到tableview最后一行的最小面
    [self.chatTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    if (_danmuDelegate != nil && [_danmuDelegate respondsToSelector:@selector(sendDanMuWithArray:)]) {
        [_danmuDelegate sendDanMuWithArray:self.messageArr];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = [self.chatTableView dequeueReusableCellWithIdentifier:MessageTableViewCell_Identify];
    AVIMTextMessage *message = self.messageArr[indexPath.row];
    cell.messageLabel.text = message.text;
    cell.userNmaeLabel.text = [NSString stringWithFormat:@"%@:",[message.attributes objectForKey:@"userName"]];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
