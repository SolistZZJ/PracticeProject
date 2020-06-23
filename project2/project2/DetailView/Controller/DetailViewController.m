//
//  DetailViewController.m
//  project2
//
//  Created by Solist on 2020/5/24.
//  Copyright © 2020 solist. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *myContentView;

@property (weak, nonatomic) IBOutlet UIImageView *picIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *descLB;
@property (weak, nonatomic) IBOutlet UILabel *detailLB;

@property (nonatomic, strong) DetailViewModel *detailVM;

@end

@implementation DetailViewController


#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configSubView];
    [self bindVM];
}

#pragma mark - 初始化子控件

- (void)configSubView {
    self.titleLB.text = self.dataModel.title;
    self.descLB.text = self.dataModel.desc;
    self.detailLB.text = self.dataModel.detail;
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager loadImageWithURL:self.dataModel.bigUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (finished) {
            self.picIV.image = image;
        }
    }];
    
    self.collectionCountLB.text = [NSString stringWithFormat:@"%@",self.dataModel.collectionCount];
    if (self.dataModel.isCollected) {
        [self.collectionBtn setImage:[UIImage imageNamed:@"关注1"] forState:UIControlStateNormal];
    }
    else {
        [self.collectionBtn setImage:[UIImage imageNamed:@"关注0"] forState:UIControlStateNormal];
    }
}

#pragma mark - 绑定viewModel

- (void)bindVM {
    self.detailVM = [[DetailViewModel alloc] initWithVC:self];
}

#pragma mark - 点击关注/取消按钮

//点击关注
- (void)collect {
    NSInteger currentCount = [self.dataModel.collectionCount integerValue]+1;
    self.dataModel.collectionCount = [NSNumber numberWithInteger:currentCount];
    self.dataModel.isCollected = YES;
    [self.collectionBtn setImage:[UIImage imageNamed:@"关注1"] forState:UIControlStateNormal];
    self.collectionCountLB.text = [NSString stringWithFormat:@"%@",self.dataModel.collectionCount];
}

//点击取消关注
- (void)cancelCollect {
    NSInteger currentCount = [self.dataModel.collectionCount integerValue]-1;
    self.dataModel.collectionCount = [NSNumber numberWithInteger:currentCount];
    self.dataModel.isCollected = NO;
    [self.collectionBtn setImage:[UIImage imageNamed:@"关注0"] forState:UIControlStateNormal];
    self.collectionCountLB.text = [NSString stringWithFormat:@"%@",self.dataModel.collectionCount];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
