//
//  ChatViewController.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "ChatViewController.h"
#import "LoginViewController.h"

@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate,AVIMClientDelegate,UITextViewDelegate>

// 聊天室
@property (strong, nonatomic) AVIMConversation *conversation;
// 所有消息
@property (strong, nonatomic) NSMutableArray *messageArr;


@property (strong, nonatomic) UIButton *sendBtn;
@end

#define UITableViewCell_Identify @"UITableViewCell_Identify"

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化消息数组
    self.msgArray = [NSMutableArray array];
    
    self.chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -2, WindownWidth, WindowHeight-345) style:UITableViewStylePlain];
//    self.chatTableView.backgroundColor = [UIColor greenColor];
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
    [self.chatTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:UITableViewCell_Identify];
    self.chatTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.chatTableView];

    [self addSendView];
    
    self.messageArr = [NSMutableArray array];
    [self queryConversationByConditions];
    
    //添加手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
    
    //添加键盘的监听事件
    //注册通知,监听键盘弹出事件
    [[NSNotificationCenter
      defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    //注册通知,监听键盘消失事件
    [[NSNotificationCenter
      defaultCenter] addObserver:self selector:@selector(keyboardDidHidden) name:UIKeyboardDidHideNotification object:nil];

    
}


//键盘弹出时
-(void)keyboardDidShow:(NSNotification *)notification

{
    //获取键盘高度
    NSValue
    *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect;

    [keyboardObject getValue:&keyboardRect];
    //调整放置有textView的view的位置
    //设置动画
    [UIView beginAnimations:nil context:nil];
    //定义动画时间
//    [UIView setAnimationDuration:0.2];
    //设置view的frame，往上平移

    self.msgTextView.frame = CGRectMake(5, 130, WindownWidth-85, 40);
    self.sendBtn.frame = CGRectMake(WindownWidth - 70, 130, 70, 40 );

    [UIView commitAnimations];

}
//键盘消失时
-(void)keyboardDidHidden {
    //定义动画
    [UIView beginAnimations:nil context:nil];
//    [UIView
//     setAnimationDuration:0.2];
    
    self.msgTextView.frame = CGRectMake(5, WindowHeight - 337, WindownWidth-85, 40);
    self.sendBtn.frame = CGRectMake(WindownWidth - 70, WindowHeight - 337, 70, 40 );
    
    [UIView commitAnimations];
    
}

-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    
//    [self.view endEditing:YES];
    [self.msgTextView resignFirstResponder];
}

- (void)addSendView {
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(5, WindowHeight - 337, WindownWidth-85, 40)];
    self.msgTextView = textView;
    self.msgTextView.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:210.0/255.0 alpha:1];
    self.msgTextView.text = @"发点弹幕吧！";
    self.msgTextView.textColor = [UIColor grayColor];
    self.msgTextView.layer.borderWidth = 1.0;
    self.msgTextView.layer.borderColor = [UIColor grayColor].CGColor;
    self.msgTextView.layer.cornerRadius = 5.0;
    self.msgTextView.delegate = self;
    [self.view addSubview:self.msgTextView];
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendBtn.backgroundColor = [UIColor colorWithRed:210.0/255.0 green:230.0/255.0 blue:210.0/255.0 alpha:1];
    self.sendBtn.layer.cornerRadius = 5.0;
    [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    self.sendBtn.frame = CGRectMake(WindownWidth - 70, WindowHeight - 337, 70, 40 );
    [self.sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.sendBtn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sendBtn];
    
}

//将要开始编辑

//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
//
//    self.msgTextView.frame
//    
//}

//- (void)sendMsg:(UIButton *)btn {
//    
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"] isEqualToString:@"0"]) {
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您未登录,登录后才能发言" preferredStyle:(UIAlertControllerStyleAlert)];
//        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//            UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//            LoginViewController *loginVC = [mainSb instantiateViewControllerWithIdentifier:@"LoginViewController"];
//           
//            [self presentViewController:loginVC animated:YES completion:nil];
//            
//        }];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
//        // 添加按钮
//        [alertController addAction:okAction];
//        [alertController addAction:cancelAction];
//        [self presentViewController:alertController animated:YES completion:nil];
//    }
//    else {
//        
//        NSString *currentUsername = [AVUser currentUser].username;// 当前用户名
//        [self createClientID:currentUsername];
//        
//    }
//    
//    
//    
//}

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
        [weakSelf.client createConversationWithName:weakSelf.liveModel.nickname clientIds:@[self.liveModel.liveID] attributes:nil options:AVIMConversationOptionTransient callback:^(AVIMConversation *conversation, NSError *error) {

            
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

// 对象
//- (AVIMClient *)client
//{
//    static AVIMClient *client = nil;
//    if (client == nil) {
//        client = [[AVIMClient alloc] initWithClientId:self.liveModel.liveID];
//    }
//    return client;
//}
// 查询聊天室
- (void)queryConversationByConditions {
    // Tom 创建了一个 client，用自己的名字作为 clientId
    __weak typeof(self) weakSelf = self;
    self.client = [[AVIMClient alloc] initWithClientId:@"tom"];
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

//                    [weakSelf joinConversation];// 加入聊天室

                    
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
    __weak typeof(self) weakSelf = self;
    [self.client openWithCallback:^(BOOL succeeded, NSError *error) {
        AVIMConversationQuery *query = [self.client conversationQuery];
        [query getConversationById:self.conversation.conversationId callback:^(AVIMConversation *conversation, NSError *error) {
            [conversation joinWithCallback:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"加入成功！");
                    weakSelf.conversation = conversation;
//                    [weakSelf getConversationFromSever];
                }
            }];
        }];
    }];
}
// 发送消息
- (void)sendMessage
{
    __weak typeof(self) weakSelf = self;
    
    AVIMTextMessage *message = [AVIMTextMessage messageWithText:self.msgTextView.text attributes:@{@"userId":@"username"}];
    
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
            [conversation queryMessagesWithLimit:-1 callback:^(NSArray *objects, NSError *error) {
                
                if (!error) {
                    NSLog(@"查询成功！");
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
    
    

    // 滑到tableview最后一行的最下面
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
    UITableViewCell *systemCell = [self.chatTableView dequeueReusableCellWithIdentifier:UITableViewCell_Identify];
    AVIMTextMessage *message = self.messageArr[indexPath.row];
    systemCell.textLabel.font = [UIFont systemFontOfSize:15];
    systemCell.textLabel.text = message.text;
    return systemCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 30;
    
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
