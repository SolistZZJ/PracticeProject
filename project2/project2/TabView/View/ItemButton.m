//
//  itemButton.m
//  project2
//
//  Created by Solist on 2020/6/19.
//  Copyright © 2020 solist. All rights reserved.
//

#import "ItemButton.h"

@implementation ItemButton

- (instancetype)init {
    self = [super init];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        UIEdgeInsets imageEdg = UIEdgeInsetsMake(0, 16, 30, 16);
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.edges.mas_equalTo(self).mas_offset(imageEdg);
        }];
        UIEdgeInsets titleEdg = UIEdgeInsetsMake(30, 23, 0, 0);
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self).mas_offset(titleEdg);
        }];
    }
    return self;
}

@end
