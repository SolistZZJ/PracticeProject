//
//  LoginViewController.h
//  project1
//
//  Created by Solist on 2020/5/20.
//  Copyright © 2020 solist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+ZZJProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

NS_ASSUME_NONNULL_END
