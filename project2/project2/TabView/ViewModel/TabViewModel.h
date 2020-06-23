//
//  TabViewModel.h
//  project2
//
//  Created by Solist on 2020/5/23.
//  Copyright © 2020 solist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import "TabViewNetworker.h"

@class TabViewController;

NS_ASSUME_NONNULL_BEGIN

@interface TabViewModel : NSObject

@property (strong, nonatomic) RACCommand *loadDataCommond;

- (instancetype)initWithVC:(TabViewController *)tabVC;

@end

NS_ASSUME_NONNULL_END
