//
//  MBProgressHUD+ZZJProgressHUD.h
//  project1
//
//  Created by Solist on 2020/5/20.
//  Copyright © 2020 solist. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (ZZJProgressHUD)

+ (void)waitHUD:(UIView *)view;

+ (void)successHUD:(UIView *)view;
+ (void)successHUDWithView:(UIView *)view title:(NSString *)title completed:(void(^)(void))block;

+ (void)errorHUDWithView:(UIView *)view error:(NSError *)error;
+ (void)notifyWithView:(UIView *)view info:(NSString *)info;

@end

NS_ASSUME_NONNULL_END
