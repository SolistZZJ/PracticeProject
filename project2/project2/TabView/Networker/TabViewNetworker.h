//
//  TabViewNetworker.h
//  project2
//
//  Created by Solist on 2020/5/23.
//  Copyright © 2020 solist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import <AVOSCloud.h>
#import "DataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TabViewNetworker : NSObject

+ (RACSignal *)loadDataWithTagkey:(NSNumber *)key;

@end

NS_ASSUME_NONNULL_END
