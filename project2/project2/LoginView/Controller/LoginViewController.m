//
//  LoginViewController.m
//  project1
//
//  Created by Solist on 2020/5/20.
//  Copyright © 2020 solist. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"

@interface LoginViewController ()

@property (strong, nonatomic) LoginViewModel *loginVM;

@property (assign, nonatomic) BOOL isChecked;

@end

@implementation LoginViewController

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self config];
}

#pragma mark - 初始化

- (void)config {
    self.isChecked = NO;
    
    //设置按钮
    [self configButton];
    
    //设置ViewModel
    [self configViewModel];
}

//初始化按钮
- (void)configButton {
    //用户名或密码为空时，按钮不可用
    _loginButton.enabled = NO;
    
//    //设置可用时的按钮样式
//    [_loginButton setBackgroundImage:[self createImageWithColor:[UIColor orangeColor]] forState:UIControlStateNormal];
//    
    //设置不可用时的按钮样式
    [_loginButton setBackgroundImage:[self createImageWithColor:[UIColor grayColor]] forState:UIControlStateDisabled];
    //设置圆角的大小
    _loginButton.layer.cornerRadius = 25;
    _loginButton.layer.masksToBounds = YES;
}

//初始化ViewModel
- (void)configViewModel {
    _loginVM = [[LoginViewModel alloc] initWithVC:self];
    
    //绑定登录事件
    [self bindLoginAction];
}

- (void)bindLoginAction {
    self.loginButton.rac_command = self.loginVM.loginCommond;
    [self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    
    //加载中
    [self.loginVM.loginCommond.executing subscribeNext:^(NSNumber * _Nullable x) {
        if (x.boolValue) {
            //显示菊花
            [MBProgressHUD waitHUD:self.view];
        }
    }];
    
    //加载成功
    [self.loginVM.loginCommond.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        [self LoginSuccess];
    }];

    //加载失败
    [self.loginVM.loginCommond.errors subscribeNext:^(NSError * _Nullable x) {
        [self LoginFail:x];
    }];
}

#pragma mark - 登录成功

- (void)LoginSuccess {
    [MBProgressHUD successHUDWithView:self.view title:@"登录成功" completed:^{
        //界面跳转
        [self performSegueWithIdentifier:@"tabViewSeg" sender:nil];
    }];
}

#pragma mark - 登录失败

- (void)LoginFail:(NSError *)error {
    [MBProgressHUD errorHUDWithView:self.view error:error];
}

#pragma mark - 用颜色生成一张图片

- (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


#pragma mark - check按钮(额外)

- (IBAction)checkButton:(UIButton *)btn {
    if (self.isChecked == NO) {
        [btn setImage:[UIImage imageNamed:@"check1"] forState:UIControlStateNormal];
        self.isChecked = YES;
    }
    else {
        [btn setImage:[UIImage imageNamed:@"check0"] forState:UIControlStateNormal];
        self.isChecked = NO;
    }
}

#pragma mark - 取消键盘响应
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
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
