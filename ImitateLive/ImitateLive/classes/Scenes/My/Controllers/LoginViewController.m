//
//  LoginViewController.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistrViewController.h"
#import "LoginRequest.h"
#import "FileDataHandle.h"
#import "MyViewController.h"
@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (assign, nonatomic) BOOL isLogin;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    
    self.bgImgView.image = [UIImage imageNamed:@"backg.jpg"];
    self.bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.bgImgView.userInteractionEnabled = YES;
    /*
     毛玻璃的样式(枚举)
     UIBlurEffectStyleExtraLight,
     UIBlurEffectStyleLight,
     UIBlurEffectStyleDark
     */
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.view.frame;
    [self.bgImgView addSubview:effectView];
    
}
- (IBAction)loginButtonClicked:(id)sender {
    [self login];
}
- (IBAction)registerButtonClicked:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    UIStoryboard *mainsb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    RegistrViewController *registerVC = [mainsb instantiateViewControllerWithIdentifier:@"RegistrViewController"];
//    [self.navigationController pushViewController:registerVC animated:YES];
    [self presentViewController:registerVC animated:YES completion:nil];
//    self.hidesBottomBarWhenPushed = NO;
}
- (IBAction)closeButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)login {
    
    // 验证,判断用户名密码
    if ([self.userNameTextField.text length] == 0) {
        NSLog(@"用户名为空");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名不能为空" delegate:self cancelButtonTitle:@"请重新输入" otherButtonTitles: nil];
        [alertView show];
        [self.view addSubview:alertView];
    }else if ([self.passwordTextField.text length] == 0){
        NSLog(@"密码为空");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能为空" delegate:self cancelButtonTitle:@"请重新输入" otherButtonTitles: nil];
        [alertView show];
        [self.view addSubview:alertView];
        
    }else{

        [AVUser logInWithUsernameInBackground:self.userNameTextField.text password:self.passwordTextField.text block:^(AVUser *user, NSError *error) {
            if (user != nil) {
                NSLog(@"登陆成功");
                _isLogin = YES;

                User *user = nil;
                user = [[User alloc] init];
                user.userName = _userNameTextField.text;
                user.password = _passwordTextField.text;

                
                [[FileDataHandle shareInstance] setUsername:_userNameTextField.text];
                [[FileDataHandle shareInstance] setPassword:_passwordTextField.text];
                [[FileDataHandle shareInstance] setLoginState:YES];
                
                // 代理回调创建clientID
//                if (_delegate&&[_delegate respondsToSelector:@selector(createClientID:)]) {
//                    [_delegate createClientID:user.userName];
//                }

         
                

                
                NSString *login = [NSString stringWithFormat:@"%d",_isLogin];
                [[NSUserDefaults standardUserDefaults] setObject:self.userNameTextField.text forKey:@"userName"];
//                [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:self.userNameTextField.text] forKey:@"avatar"];
                
                [[NSUserDefaults standardUserDefaults]setObject:login forKey:@"isLogin"];
                // 立即保存
                [[NSUserDefaults standardUserDefaults] synchronize];
                // 登录成功之后消失
//                [self.navigationController popToRootViewControllerAnimated:YES];

                [self dismissViewControllerAnimated:YES completion:nil];
                
            } else {

                
            }
        }];
  
    }
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
