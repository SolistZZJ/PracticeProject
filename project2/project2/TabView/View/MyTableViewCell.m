//
//  MyTableViewCell.m
//  project2
//
//  Created by Solist on 2020/6/23.
//  Copyright © 2020 solist. All rights reserved.
//

#import "MyTableViewCell.h"

@interface MyTableViewCell ()

@property (strong, nonatomic) UIImageView *picIV;
@property (strong, nonatomic) UILabel *titleLB;
@property (strong, nonatomic) UILabel *descLB;
@property (strong, nonatomic) UILabel *collectionCount;
@property (strong, nonatomic) UIButton *collectionBtn;

@end

@implementation MyTableViewCell

#pragma mark - 初始化

- (instancetype)initWithDataModel:(DataModel *)dataModel {
    self = [super init];
    
    if (self) {
        _dataModel =dataModel;
        
        [self configSubView];
    }
    
    return self;
}

#pragma mark - 初始化子控件

- (void)configSubView {
    
    //初始化ImageView
    [self setupImageView];
    
    //初始化Label
    [self setupLabel];
    
    //初始化按钮
    [self setupButton];
}

- (void)setupImageView {
    //初始化imageView
    _picIV = [[UIImageView alloc] init];
    [self addSubview:_picIV];
    [_picIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@100);
        make.left.equalTo(@20);
        make.centerY.equalTo(self);
    }];
    
    //加载图片数据
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    @weakify(self);
    [manager loadImageWithURL:self.dataModel.url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (finished) {
            @strongify(self);
            self.picIV.image = image;
        }
    }];
}

- (void)setupLabel {
    //添加标题Label
    _titleLB = [[UILabel alloc] init];
    [self addSubview:_titleLB];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self.picIV.mas_right).offset(30);
        make.right.equalTo(self).offset(-20);
    }];
    _titleLB.text = self.dataModel.title;
    
    //添加描述Label
    _descLB = [[UILabel alloc] init];
    [self addSubview:_descLB];
    [_descLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLB.mas_bottom).offset(20);
        make.left.equalTo(self.picIV.mas_right).offset(30);
        make.right.equalTo(self).offset(-20);
    }];
    _descLB.text = self.dataModel.desc;
    _descLB.numberOfLines = 3;
    
    //添加收藏数Label
    _collectionCount = [[UILabel alloc] init];
    [self addSubview:_collectionCount];
    [_collectionCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self).offset(-20);
    }];
    self.collectionCount.text = [NSString stringWithFormat:@"%@",self.dataModel.collectionCount];
}

- (void)setupButton {
    //添加收藏按钮
    _collectionBtn = [[UIButton alloc] init];
    [self addSubview:_collectionBtn];
    [_collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@32);
        make.centerY.equalTo(self.collectionCount);
        make.right.equalTo(self.collectionCount.mas_left).offset(-10);
    }];
    if (_dataModel.isCollected) {
        [_collectionBtn setImage:[UIImage imageNamed:@"关注1"] forState:UIControlStateNormal];
    }
    else {
        [_collectionBtn setImage:[UIImage imageNamed:@"关注0"] forState:UIControlStateNormal];
    }
    
    //添加收藏按钮点击事件
    @weakify(self);
    [[_collectionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
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
    }];
}

#pragma mark - 绑定model

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

#pragma mark - 关注按钮点击事件

- (void)collectionBtnClicked:(UIButton *)btn {
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
