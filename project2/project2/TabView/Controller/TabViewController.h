//
//  TabViewController.h
//  project2
//
//  Created by Solist on 2020/5/22.
//  Copyright © 2020 solist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>
#import "TabViewModel.h"
#import "MBProgressHUD+ZZJProgressHUD.h"
#import "DataTableViewCell.h"
#import "DetailViewController.h"
#import "MyTableView.h"
#import "ItemButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface TabViewController : UIViewController

@property (strong, nonatomic) NSNumber *pageStatus;

@property (strong, nonatomic) NSMutableArray *buttonArray;

- (void)switchTabView;


@end

NS_ASSUME_NONNULL_END
