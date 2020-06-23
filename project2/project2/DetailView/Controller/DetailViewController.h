//
//  DetailViewController.h
//  project2
//
//  Created by Solist on 2020/5/24.
//  Copyright © 2020 solist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+ZZJProgressHUD.h"
#import "DataModel.h"
#import "DetailViewModel.h"
#import <SDWebImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (strong, nonatomic) DataModel *dataModel;

@property (weak, nonatomic) IBOutlet UILabel *collectionCountLB;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;


- (void)collect;
- (void)cancelCollect;

@end

NS_ASSUME_NONNULL_END
