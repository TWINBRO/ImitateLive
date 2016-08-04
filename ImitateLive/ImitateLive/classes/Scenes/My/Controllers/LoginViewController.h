//
//  LoginViewController.h
//  ImitateLive
//
//  Created by ssx on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BaseViewController.h"

@protocol LoginDelegate <NSObject>

- (void)createClientID:(NSString *)clientID;

@end

#import "User.h"

@interface LoginViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) id<LoginDelegate>delegate;

@property (nonatomic, copy) void(^completion)(User *user, NSError *error);  //登录完成block回调


@end
