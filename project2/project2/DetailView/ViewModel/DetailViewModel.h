//
//  DetailViewModel.h
//  project2
//
//  Created by Solist on 2020/5/24.
//  Copyright © 2020 solist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

@class DetailViewController;

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewModel : NSObject

@property (weak, nonatomic) DetailViewController *vc;

- (instancetype)initWithVC:(DetailViewController *)vc;

@end

NS_ASSUME_NONNULL_END
