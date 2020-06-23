//
//  MyTableView.m
//  project2
//
//  Created by Solist on 2020/6/19.
//  Copyright © 2020 solist. All rights reserved.
//

#import "MyTableView.h"

@interface MyTableView() <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MyTableView

#pragma mark - 初始化

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configSubview];
    }
    return self;
}

#pragma mark - 初始化子控件

- (void)configSubview {
    //初始化tableview
    _tableView = [[UITableView alloc] init];
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

#pragma mark - tableView的代理方法

//返回section数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//返回row数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellArray.count;
}

//返回cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 192;
}

//初始化cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"dataCell%ld",(long)indexPath.row]];
    if (!cell) {
        cell = [[MyTableViewCell alloc] initWithDataModel:self.cellArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //cell.dataModel = self.cellArray[indexPath.row];
    return cell;
}

//点击cell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //通过notification向TabViewController传递信息
    [[NSNotificationCenter defaultCenter] postNotificationName: @"cellClicked" object: self.cellArray[indexPath.row]];
}

@end
