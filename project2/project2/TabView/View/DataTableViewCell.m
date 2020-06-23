//
//  DataTableViewCell.m
//  project2
//
//  Created by Solist on 2020/5/23.
//  Copyright © 2020 solist. All rights reserved.
//

#import "DataTableViewCell.h"

@interface DataTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *picIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *descLB;
@property (weak, nonatomic) IBOutlet UILabel *collectionCount;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;


@end

@implementation DataTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    //绑定model的cellectionCount（kvo）
    [[RACObserve(self.dataModel, collectionCount) skip:1] subscribeNext:^(id  _Nullable x) {
        if (self.dataModel.isCollected) {
            self.collectionCount.text = [NSString stringWithFormat:@"%@",x];
            [self.collectionBtn setImage:[UIImage imageNamed:@"关注0"] forState:UIControlStateNormal];
        }
        else {
            self.collectionCount.text=[NSString stringWithFormat:@"%@",x];
            [self.collectionBtn setImage:[UIImage imageNamed:@"关注1"] forState:UIControlStateNormal];
        }
    }];
}

#pragma mark - 初始化子控件
- (void)setDataModel:(DataModel *)dataModel {
    _dataModel = dataModel;
    
    if (self.dataModel.isCollected) {
        [_collectionBtn setImage:[UIImage imageNamed:@"关注1"] forState:UIControlStateNormal];
    }
    else {
        [_collectionBtn setImage:[UIImage imageNamed:@"关注0"] forState:UIControlStateNormal];
    }
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager loadImageWithURL:dataModel.url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (finished) {
            self.picIV.image = image;
        }
    }];
    
    self.titleLB.text = dataModel.title;
    self.descLB.text = dataModel.desc;
    self.collectionCount.text = [NSString stringWithFormat:@"%@",dataModel.collectionCount];
}


#pragma mark - 关注按钮点击事件
- (IBAction)collectionBtnClicked:(UIButton *)btn {
    NSUInteger currentCount = [self.collectionCount.text integerValue];
    if (self.dataModel.isCollected) {
        currentCount--;
        self.dataModel.collectionCount = [NSNumber numberWithInteger:currentCount];
        self.dataModel.isCollected = NO;
    }
    else {
        currentCount++;
        self.dataModel.collectionCount = [NSNumber numberWithInteger:currentCount];
        self.dataModel.isCollected = YES;
    }
}


@end
