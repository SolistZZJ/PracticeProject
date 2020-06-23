//
//  LoginViewModel.m
//  project1
//
//  Created by Solist on 2020/5/20.
//  Copyright © 2020 solist. All rights reserved.
//

#import "LoginViewModel.h"
#import "LoginViewController.h"

@interface LoginViewModel ()

@property (nonatomic, weak) LoginViewController *loginVC;

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) RACSignal *usernameSig;
@property (nonatomic, strong) RACSignal *passwordSig;

@end

@implementation LoginViewModel

#pragma mark - 初始化

- (instancetype)initWithVC:(LoginViewController *)loginVC {
    self = [super init];
    if (self) {
        _loginVC = loginVC;
        
        //绑定TextField
        [self bindTextField];
        
        //绑定登录按钮
        [self bindLoginBtn];
    }
    return self;
}

#pragma mark - 绑定控件

//绑定TextField
- (void)bindTextField {
    //绑定属性
    RAC(self,self.username) = _loginVC.usernameTextField.rac_textSignal;
    RAC(self,self.password) = _loginVC.passwordTextField.rac_textSignal;
    
    //TF信号量
    self.usernameSig = _loginVC.usernameTextField.rac_textSignal;
    self.passwordSig = _loginVC.passwordTextField.rac_textSignal;
    
//    RACSignal *usernameIsValid = [RACSignal combineLatest:@[self.usernameSig, self.passwordSig] reduce:^id _Nonnull {
//        return @(self.username.length >= 8&&self.username.length <= 12);
//    }];
//    RACSignal *passwordIsValid = [RACSignal combineLatest:@[self.usernameSig, self.passwordSig] reduce:^id _Nonnull {
//        return @(self.password.length >= 8&&self.password.length <= 20);
//    }];
    
//    [usernameIsValid subscribeNext:^(id  _Nullable x) {
//        if ([x boolValue]) {
//            self.loginVC.usernameTextField.backgroundColor = [UIColor whiteColor];
//        }
//        else {
//            self.loginVC.usernameTextField.backgroundColor = [UIColor yellowColor];
//        }
//    }];
    
//    [passwordIsValid subscribeNext:^(id  _Nullable x) {
//        if ([x boolValue]) {
//            self.loginVC.passwordTextField.backgroundColor = [UIColor whiteColor];
//        }
//        else {
//            self.loginVC.passwordTextField.backgroundColor = [UIColor yellowColor];
//        }
//    }];
}

//绑定LoginBtn
- (void)bindLoginBtn {
    @weakify(self);
    RACSignal *loginBtnEnable = [RACSignal combineLatest:@[self.usernameSig, self.passwordSig] reduce:^id _Nonnull {
        @strongify(self);
        return @(self.username.length >= 8&&self.username.length <= 12&&self.password.length >= 8&&self.password.length <= 20);
    }];
    
    self.loginCommond = [[RACCommand alloc] initWithEnabled:loginBtnEnable signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self)
        return [LoginNetworker loginWithUsername:self.username password:self.password];
    }];
}

@end
