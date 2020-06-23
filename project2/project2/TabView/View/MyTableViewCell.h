//
//  MyTableViewCell.h
//  project2
//
//  Created by Solist on 2020/6/23.
//  Copyright © 2020 solist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"
#import <ReactiveObjC.h>
#import <SDWebImage.h>
#import <Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTableViewCell : UITableViewCell

@property (strong, nonatomic) DataModel *dataModel;

- (instancetype)initWithDataModel:(DataModel *)dataModel;

@end

NS_ASSUME_NONNULL_END
