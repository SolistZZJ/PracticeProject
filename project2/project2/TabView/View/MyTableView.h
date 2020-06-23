//
//  MyTableView.h
//  project2
//
//  Created by Solist on 2020/6/19.
//  Copyright © 2020 solist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTableViewCell.h"
#import <Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTableView : UIView

@property (strong, nonatomic) UITableView *tableView;


@property (strong, nonatomic) NSNumber *page;
@property (strong, nonatomic) NSMutableArray *cellArray;


@end

NS_ASSUME_NONNULL_END
