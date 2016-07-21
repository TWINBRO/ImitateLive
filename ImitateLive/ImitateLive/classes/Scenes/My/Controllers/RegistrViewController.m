//
//  RegistrViewController.m
//  ImitateLive
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 SJH. All rights reserved.
//

#import "RegistrViewController.h"
#import "RegisterRequest.h"
#import "LoginViewController.h"
@interface RegistrViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, strong) UIImagePickerController *imagePicker; // 图片选择器


@end

@implementation RegistrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    
    
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    
    self.avatarImageView.userInteractionEnabled = YES;
    // Do any additional setup after loading the view.
    self.backgroundView.image = [UIImage imageNamed:@"backg.jpg"];
    self.backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundView.userInteractionEnabled = YES;
    /*
     毛玻璃的样式(枚举)
     UIBlurEffectStyleExtraLight,
     UIBlurEffectStyleLight,
     UIBlurEffectStyleDark
     */
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.view.frame;
    [self.backgroundView addSubview:effectView];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left1.png"]];
    self.usernameTextField.leftView = image;
    self.usernameTextField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left2.png"]];
    self.passwordTextField.leftView = image1;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left2.png"]];
    self.confirmPassWordTextField.leftView = image2;
    self.confirmPassWordTextField.leftViewMode = UITextFieldViewModeAlways;
}
- (IBAction)registerButtonClicked:(id)sender {
    
    // 验证,判断用户名密码
    if ([self.usernameTextField.text length] == 0) {
        NSLog(@"用户名为空");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名不能为空" delegate:self cancelButtonTitle:@"请重新输入" otherButtonTitles: nil];
        [alertView show];
        [self.view addSubview:alertView];
    }else if ([self.passwordTextField.text length] == 0){
        NSLog(@"密码为空");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能为空" delegate:self cancelButtonTitle:@"请重新输入" otherButtonTitles: nil];
        [alertView show];
        [self.view addSubview:alertView];
        
    }else if (![self.passwordTextField.text isEqualToString:self.confirmPassWordTextField.text]){
        
        NSLog(@"两次输入密码不一致");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次输入密码不一致,请重新输入!" delegate:self cancelButtonTitle:@"请重新输入" otherButtonTitles: nil];
        [alertView show];
        [self.view addSubview:alertView];
        
    }else{
        
        AVUser *user = [AVUser user];// 新建 AVUser 对象实例
        user.username = self.usernameTextField.text;// 设置用户名
        user.password =  self.passwordTextField.text;// 设置密码
        
        AVObject *todoFolder = [[AVObject alloc] initWithClassName:@"TodoFolder"];// 构建对象
        [todoFolder setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"] forKey:@"avatar"];// 设置名称
        [todoFolder setObject:self.usernameTextField.text forKey:@"currentUsername"];
        [todoFolder saveInBackground];// 保存到云端
        
        [todoFolder saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                // 存储成功
                NSLog(@"%@",todoFolder.objectId);// 保存成功之后，objectId 会自动从云端加载到本地
//                [[NSUserDefaults standardUserDefaults] setObject:todoFolder.objectId forKey:self.usernameTextField.text];
//                [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"] forKey:self.usernameTextField.text];
            } else {
                // 失败的话，请检查网络环境以及 SDK 配置是否正确
            }
        }];
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                // 注册成功

                // 界面消失
                LoginViewController *loginVC = (LoginViewController *)[self.navigationController.viewControllers objectAtIndex:1];
                [self.navigationController popToViewController:loginVC animated:YES];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            } else {
                // 失败的原因可能有多种，常见的是用户名已经存在。
                NSLog(@"register error = %@",error);
                
            }
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    // 显示头像
    self.avatarImageView.image = image;
    
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    AVFile *file = [AVFile fileWithName:@"avatar.png" data:data];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"%@",file.url);//返回一个唯一的 Url 地址

        // 保存头像到本地
        [[NSUserDefaults standardUserDefaults]setObject:file.url forKey:@"avatar"];
        // 立即保存
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }];
    
    
    
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(saveImage), nil);
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // 隐藏图片选择页面
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)saveImage {
    
    NSLog(@"存储图片");
    
}
// 点击头像的方法
- (IBAction)tapAvatarImage:(id)sender {
    
    // 添加alertsheet
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 指定图片来源
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        _imagePicker.allowsEditing = YES;
        [self presentViewController:_imagePicker animated:YES completion:^{
            
        }];
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePicker.allowsEditing = YES;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:photoAction];
    [alert addAction:cameraAction];
    [alert addAction:cancelAction];
    // 显示alertController
    [self presentViewController:alert animated:YES completion:nil];
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
