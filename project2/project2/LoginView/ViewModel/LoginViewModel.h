//
//  LoginViewModel.h
//  project1
//
//  Created by Solist on 2020/5/20.
//  Copyright © 2020 solist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginNetworker.h"
#import <ReactiveObjC.h>

@class LoginViewController;

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

@property (strong, nonatomic) RACCommand *loginCommond;

- (instancetype)initWithVC:(LoginViewController *)loginVC;

@end

NS_ASSUME_NONNULL_END
