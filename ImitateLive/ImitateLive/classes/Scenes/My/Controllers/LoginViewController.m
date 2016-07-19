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
    [self.navigationController pushViewController:registerVC animated:YES];
//    self.hidesBottomBarWhenPushed = NO;
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
        LoginRequest *request = [[LoginRequest alloc]init];
        [request loginRequestWithUsername:self.userNameTextField.text password:self.passwordTextField.text success:^(NSDictionary *dic) {

            NSLog(@"login success = %@",dic);

            User *user = nil;

            long code = [[dic objectForKey:@"code"] longValue];
            //        NSString *code = [[dic objectForKey:@"code"] stringValue];
            

            
            if ((code == 1103) && ([dic[@"success"] intValue] == 1)) {
                
                user = [[User alloc] init];
                [user setValuesForKeysWithDictionary:dic[@"data"]];
                user.userName = _userNameTextField.text;
                user.password = _passwordTextField.text;
                [[FileDataHandle shareInstance] setUsername:_userNameTextField.text];
                [[FileDataHandle shareInstance] setPassword:_passwordTextField.text];
                [[FileDataHandle shareInstance] setUserId:user.userId];
                [[FileDataHandle shareInstance] setAvatar:user.avatar];
                [[FileDataHandle shareInstance] setLoginState:YES];

                _isLogin = YES;
                NSString *login = [NSString stringWithFormat:@"%d",_isLogin];
                NSString *avatar = [[dic objectForKey:@"data"] objectForKey:@"avatar"];
                NSString *userId = [[dic objectForKey:@"data"]objectForKey:@"userId"];
                // 保存头像和id以及是否登录到本地
                [[NSUserDefaults standardUserDefaults]setObject:avatar forKey:@"avatar"];
                [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
                [[NSUserDefaults standardUserDefaults]setObject:login forKey:@"isLogin"];
                [[NSUserDefaults standardUserDefaults]setObject:self.userNameTextField.text forKey:userId];
                [[NSUserDefaults standardUserDefaults]setObject:self.userNameTextField.text forKey:@"userName"];
                // 立即保存
                [[NSUserDefaults standardUserDefaults] synchronize];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
                [self.view addSubview:alertView];
                // 登录成功之后消失
                [self.navigationController popToRootViewControllerAnimated:YES];
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }
            
        } failure:^(NSError *error) {
            NSLog(@"login failure = %@",error);
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
