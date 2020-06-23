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



- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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

//初始化cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"dataCell%ld",(long)indexPath.row]];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DataTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.dataModel = self.cellArray[indexPath.row];
    return cell;
}

//点击cell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //通过notification向TabViewController传递信息
    [[NSNotificationCenter defaultCenter] postNotificationName: @"cellClicked" object: self.cellArray[indexPath.row]];
}

@end
