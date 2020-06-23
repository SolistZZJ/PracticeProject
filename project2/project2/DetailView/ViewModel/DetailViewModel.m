//
//  DetailViewModel.m
//  project2
//
//  Created by Solist on 2020/5/24.
//  Copyright © 2020 solist. All rights reserved.
//

#import "DetailViewModel.h"
#import "DetailViewController.h"


@implementation DetailViewModel

#pragma mark - 初始化

- (instancetype)initWithVC:(DetailViewController *)vc {
    self = [super init];
    if (self) {
        _vc = vc;
        
        [self bindBtn];
    }
    return self;
}

#pragma mark - 绑定按钮

- (void)bindBtn { 
    [[self.vc.collectionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (self.vc.dataModel.isCollected) {
            [self.vc cancelCollect];
        }
        else {
            [self.vc collect];
        }
    }];
}

@end
