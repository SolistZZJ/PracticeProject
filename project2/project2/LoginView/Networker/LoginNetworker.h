//
//  LoginNetworker.h
//  project1
//
//  Created by Solist on 2020/5/20.
//  Copyright © 2020 solist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginNetworker : NSObject

+ (RACSignal *)loginWithUsername:(NSString *)username password:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
