//
//  LoginNetworker.m
//  project1
//
//  Created by Solist on 2020/5/20.
//  Copyright © 2020 solist. All rights reserved.
//

#import "LoginNetworker.h"

@implementation LoginNetworker

+ (RACSignal *)loginWithUsername:(NSString *)username password:(NSString *)password {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //模拟登录操作... ...
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //模拟延时
            [subscriber sendNext:@"登陆成功"];
            [subscriber sendCompleted];
        });
        return nil;
    }];
    return signal;
}

@end
