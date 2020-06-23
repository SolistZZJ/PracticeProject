//
//  TabViewModel.m
//  project2
//
//  Created by Solist on 2020/5/23.
//  Copyright © 2020 solist. All rights reserved.
//

#import "TabViewModel.h"
#import "TabViewController.h"

@interface TabViewModel ()

@property (nonatomic, weak) TabViewController *tabVC;

@end

@implementation TabViewModel


#pragma mark - 初始化

- (instancetype)initWithVC:(TabViewController *)tabVC {
    self = [super init];
    if (self) {
        _tabVC = tabVC;
        
        [self bindBtn];
        [self bindPageStatus];
        [self config];
    }
    return self;
}

#pragma mark - 绑定按钮

- (void)bindBtn {
    for (int i = 0; i < self.tabVC.buttonArray.count; ++i) {
        ItemButton *currentButton = self.tabVC.buttonArray[i];
        
        @weakify(self);
        [[currentButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            self.tabVC.pageStatus = @(i);
        }];
    }
}

#pragma mark - 绑定pageStatus

- (void)bindPageStatus {
    [[RACObserve(self.tabVC, pageStatus) skip:1] subscribeNext:^(id  _Nullable x) {
        [self.tabVC switchTabView];
    }];
}

#pragma mark - 绑定数据

- (void)config {
    self.loadDataCommond = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [TabViewNetworker loadDataWithTagkey:self.tabVC.pageStatus];
    }];
}
@end
