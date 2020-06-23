//
//  MBProgressHUD+ZZJProgressHUD.m
//  project1
//
//  Created by Solist on 2020/5/20.
//  Copyright © 2020 solist. All rights reserved.
//

#import "MBProgressHUD+ZZJProgressHUD.h"

@implementation MBProgressHUD (ZZJProgressHUD)

#pragma mark - 网络等待

+ (void)waitHUD:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
}

#pragma mark - 网络请求成功

//用于tableview等无提示加载成功
+ (void)successHUD:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:NO];
}

//用于有提示的网络加载成功
+ (void)successHUDWithView:(UIView *)view title:(NSString *)title completed:(nonnull void (^)(void))block {
    [MBProgressHUD hideHUDForView:view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = title;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:view animated:YES];
        block();
    });
}

#pragma mark - 网络连接错误

+ (void)errorHUDWithView:(UIView *)view error:(NSError *)error {
    [MBProgressHUD hideHUDForView:view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = error.localizedDescription;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:view animated:YES];
    });
}

#pragma mark - 提示

+ (void)notifyWithView:(UIView *)view info:(NSString *)info {
    [MBProgressHUD hideHUDForView:view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = info;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:view animated:YES];
    });
}

@end
