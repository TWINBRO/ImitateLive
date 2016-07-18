//
//  LoginViewController.h
//  ImitateLive
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "BaseViewController.h"

#import "User.h"

@interface LoginViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@property (nonatomic, copy) void(^completion)(User *user, NSError *error);  //登录完成block回调


@end
