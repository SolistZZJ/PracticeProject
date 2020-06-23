//
//  DataTableViewCell.h
//  project2
//
//  Created by Solist on 2020/5/23.
//  Copyright © 2020 solist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"
#import <ReactiveObjC.h>
#import <SDWebImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataTableViewCell : UITableViewCell

@property (strong, nonatomic) DataModel *dataModel;

@end

NS_ASSUME_NONNULL_END
