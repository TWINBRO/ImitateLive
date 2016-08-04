//
//  TalentShowViewController.m
//  ImitateLive
//
//  Created by ssx on 16/7/22.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "TalentShowViewController.h"
#import "PlayerView.h"
#import <UMSocialSnsService.h>
#import <UMSocial.h>
#import "LoginViewController.h"
#import "MessageTableViewCell.h"
@interface TalentShowViewController ()<UMSocialUIDelegate,UITableViewDataSource,UITableViewDelegate,AVIMClientDelegate,UITextViewDelegate>

// 聊天室
@property (strong, nonatomic) AVIMConversation *conversation;
// 所有消息
@property (strong, nonatomic) NSMutableArray *messageArr;


@property (strong, nonatomic) UIButton *sendBtn;
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UIButton *heartButton;
@property (strong, nonatomic) PlayerView *playerView;
@property (strong, nonatomic) UIButton *closeButton;
@property (strong, nonatomic) UILabel *personLabel;
@property (strong, nonatomic) UILabel *numberLabel;
@property (strong, nonatomic) UILabel *nickNameLabel;
@property (strong, nonatomic) UIButton *messageButton;


@end
#define HLS_URL @"http://dlhls.cdn.zhanqi.tv/zqlive/"
@implementation TalentShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableString * filePath = [[NSMutableString alloc]initWithString:  [NSString stringWithFormat:@"%@%@.m3u8",HLS_URL,self.liveModel.videoId]];
    filePath = [filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSURL *videoUrl = [NSURL URLWithString: filePath ];
    self.playerView = [[PlayerView alloc]initWithUrl:filePath frame:self.view.frame];
    if (!self.playerView.isPlaying) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 250)];
        imgView.image = [UIImage imageNamed:@"load"];
        
        [self.view addSubview:imgView];
        
        [self.view.layer addSublayer:self.playerView.playerLayer];
        
    }else{
        
        [self.view.layer addSublayer:self.playerView.playerLayer];
        
    }
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeButton.frame = CGRectMake(WindownWidth - 50, 30, 30, 30);
    [self.closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.heartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.heartButton.frame = CGRectMake(WindownWidth - 50, WindowHeight - 50, 30, 30);
    [self.heartButton setImage:[UIImage imageNamed:@"heartB"] forState:UIControlStateNormal];
    [self.heartButton addTarget:self action:@selector(heartButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.personLabel = [[UILabel alloc] initWithFrame:CGRectMake(-15, 100, 85, 30)];
    self.personLabel.text = [NSString stringWithFormat:@"%@",self.liveModel.online];
    self.personLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.personLabel.layer.cornerRadius = 15;
    self.personLabel.clipsToBounds = YES;
    self.personLabel.textColor = [UIColor whiteColor];
    self.personLabel.textAlignment = NSTextAlignmentCenter;
    
    
//    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, WindowHeight - 40, 300, 21)];
//    self.numberLabel.text = [NSString stringWithFormat:@"欢迎来到%@的直播间",self.liveModel.nickname];
//    self.numberLabel.textColor = [UIColor colorWithRed:14.0/255.0 green:192.0/255.0 blue:228.0/255.0 alpha:1];
    

    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(WindownWidth - 100, WindowHeight - 47, 25, 25)];
    shareBtn.layer.masksToBounds = YES;
    shareBtn.layer.cornerRadius = 5;
    [shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:shareBtn];

    self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 100, 30)];
    self.nickNameLabel.text = [NSString stringWithFormat:@"%@",self.liveModel.nickname];
    self.nickNameLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.nickNameLabel.layer.cornerRadius = 15;
    self.nickNameLabel.clipsToBounds = YES;
    self.nickNameLabel.textColor = [UIColor whiteColor];
    self.nickNameLabel.font = [UIFont systemFontOfSize:13.0];
    self.nickNameLabel.textAlignment = NSTextAlignmentCenter;
    
    self.messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.messageButton.frame = CGRectMake(20, WindowHeight - 50, 30, 30);
    [self.messageButton setImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
    [self.messageButton addTarget:self action:@selector(messageButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.messageButton];
    [self.view addSubview:self.nickNameLabel];
//    [self.view addSubview:self.numberLabel];
    [self.view addSubview:self.personLabel];
    [self.view addSubview:self.heartButton];
    [self.view addSubview:self.closeButton];
    
    // 初始化消息数组
    self.msgArray = [NSMutableArray array];
    
    self.chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, WindowHeight/2, WindownWidth, WindowHeight/2-70) style:UITableViewStylePlain];
    self.chatTableView.backgroundColor = [UIColor clearColor];
    //tableView头部视图
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 0, 20)];
    self.chatTableView.tableHeaderView = header;
    
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
    
    
    [self.chatTableView registerNib:[UINib nibWithNibName:@"MessageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MessageTableViewCell_Identify];
    
    self.chatTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.chatTableView];
    

    
    self.messageArr = [NSMutableArray array];
    [self queryConversationByConditions];
    
    //添加手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];

}

- (void)messageButtonclicked:(UIButton *)button {

    [self addSendView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    //添加键盘的监听事件
    //注册通知,监听键盘弹出事件
    [[NSNotificationCenter
      defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    //注册通知,监听键盘消失事件
    [[NSNotificationCenter
      defaultCenter] addObserver:self selector:@selector(keyboardDidHidden) name:UIKeyboardDidHideNotification object:nil];
    
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
    //    [UIView beginAnimations:nil context:nil];
    //    //定义动画时间
    //    [UIView setAnimationDuration:0.2];
    //设置view的frame，往上平移
    
    self.msgTextView.frame = CGRectMake(5, WindowHeight-keyboardRect.size.height-40, WindownWidth-85, 40);
    self.sendBtn.frame = CGRectMake(WindownWidth - 74, WindowHeight-keyboardRect.size.height-40, 70, 40 );
    
    //    [UIView commitAnimations];
    
}
//键盘消失时
-(void)keyboardDidHidden {
    //定义动画
    //    [UIView beginAnimations:nil context:nil];
    //    [UIView
    //     setAnimationDuration:0.2];
    
//    self.msgTextView.frame = CGRectMake(5, WindowHeight - 337, WindownWidth-85, 40);
//    self.sendBtn.frame = CGRectMake(WindownWidth - 74, WindowHeight - 337, 70, 40 );
    [self.msgTextView removeFromSuperview];
    [self.sendBtn removeFromSuperview];
    
    //    [UIView commitAnimations];
    
}

-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    
    //    [self.view endEditing:YES];
    [self.msgTextView resignFirstResponder];
    
}

- (void)addSendView {

    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(5, WindowHeight - 50, WindownWidth-85, 40)];
    self.msgTextView = textView;
    //    self.msgTextView.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:210.0/255.0 alpha:1];
    self.msgTextView.backgroundColor = [UIColor whiteColor];
    self.msgTextView.delegate = self;
    self.msgTextView.text = @"发点弹幕吧！";
    self.msgTextView.textColor = [UIColor grayColor];
    self.msgTextView.layer.borderWidth = 1.0;
    self.msgTextView.layer.borderColor = [UIColor colorWithRed:14.0/255.0 green:192.0/255.0 blue:228.0/255.0 alpha:1].CGColor;
    self.msgTextView.layer.cornerRadius = 5.0;
    self.msgTextView.delegate = self;
    [self.view addSubview:self.msgTextView];
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendBtn.backgroundColor = [UIColor colorWithRed:14.0/255.0 green:192.0/255.0 blue:228.0/255.0 alpha:1];
    self.sendBtn.layer.cornerRadius = 5.0;
    [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    self.sendBtn.frame = CGRectMake(WindownWidth - 74, WindowHeight - 50, 70, 40 );
    [self.sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sendBtn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sendBtn];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 24;
    
}

- (void)sendAction:(UIButton *)button
{
    
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
    }else {
        
        [self sendMessage];
        
    }
    
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
                    
                    //                    [weakSelf getConversationFromSever];
                    
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"message" object:nil userInfo:@{@"message":message.text}];
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
    // 滑到tableview最后一行的最小面
    
    [self.chatTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = [self.chatTableView dequeueReusableCellWithIdentifier:MessageTableViewCell_Identify];
    AVIMTextMessage *message = self.messageArr[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    
    cell.messageLabel.textColor = [UIColor whiteColor];
    cell.messageLabel.text = message.text;
    cell.userNmaeLabel.text = [NSString stringWithFormat:@"%@:",[message.attributes objectForKey:@"userName"]];
    return cell;
    
}

// 设置区头（每个分区开始区域的视图）
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 0, 20)];
    label.text = [NSString stringWithFormat:@"   欢迎来到%@的直播间",self.liveModel.nickname];
    label.font = [UIFont systemFontOfSize:13.0];
    label.textColor = [UIColor colorWithRed:14.0/255.0 green:192.0/255.0 blue:228.0/255.0 alpha:1];
    return label;
    
}

//设置分区区头高度
- (CGFloat )tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    
    return 20;
}

- (void)closeButtonClicked:(UIButton *)button {

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)heartButtonClicked:(UIButton *)button {

    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(WindownWidth - 50, WindowHeight - 50, 30, 30)];
    imgView.image = [UIImage imageNamed:@"heart"];
    [self.view addSubview:imgView];
//    [UIView animateWithDuration:2 animations:^{
//        imgView.alpha = 0;
//        
//    }];

    [UIView animateWithDuration:2 delay:0 options:nil animations:^{
        // 动画主体部分
        imgView.alpha = 0;
        imgView.frame = CGRectMake(300, 100, 30, 30);
        
    } completion:^(BOOL finished) {
        // 动画完成后执行的代码
        [imgView removeFromSuperview];
        
    }];
    
}

// 分享
- (void)shareAction {
    
    [UMSocialData defaultData].extConfig.title = @"转发到微博";
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:self.liveModel.spic];
    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"578c804167e58e5c90000c6b"
                                      shareText:[NSString stringWithFormat:@"我正在#战旗TV#观看%@的现场直播：【%@】，精彩炫酷，大家速速来围观！http://www.zhanqi.tv%@（分享自@战旗TV直播平台）",self.liveModel.nickname,self.liveModel.title,self.liveModel.url] // 分享的内容
                                     shareImage:nil
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToSina]
                                       delegate:self];
    
}

// 实现回调方法
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
    
    // 根据responseCode得到发送的结果
    if (response.responseCode == UMSResponseCodeSuccess) {
        NSLog(@"分享成功");
    }else {
        NSLog(@"%d",response.responseCode);
    }
    
}

// 程序进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [self.playerView.playerLayer removeFromSuperlayer];

}


// 程序返回
- (void)applicationWillEnterForeground:(UIApplication *)application{
    
    NSMutableString * filePath = [[NSMutableString alloc]initWithString:  [NSString stringWithFormat:@"%@%@.m3u8",HLS_URL,self.liveModel.videoId]];
    filePath=[filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    self.playerView = [[PlayerView alloc]initWithUrl:filePath frame:CGRectMake(0, 20, self.view.frame.size.width, 250)];
    
    [self.view.layer addSublayer:self.playerView.playerLayer];

    
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
