//
//  TabViewController.m
//  project2
//
//  Created by Solist on 2020/5/22.
//  Copyright © 2020 solist. All rights reserved.
//

#import "TabViewController.h"

@interface TabViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *cellArrayDict;

@property (strong, nonatomic) UIScrollView *topSegmentView;
@property (strong, nonatomic) UIView *underlineView;
@property (strong, nonatomic) UIScrollView *tabScrollView;

@property (strong, nonatomic) NSArray* dataArray;
@property (strong, nonatomic) NSMutableArray* tableViewArray;
@property (strong, nonatomic) NSMutableArray* isFirstIntoTableViewArray;
@property (assign, nonatomic) BOOL isInitial;

@property (strong, nonatomic) TabViewModel *tabVM;

@end

@implementation TabViewController

#pragma mark - 生命期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configData];
    [self configSubView];
    [self configBtn];
    [self configVM];
    [self loadData];
    
    [self configNotification];
}

#pragma mark - 初始化

- (void)configData {
    //可修改
    self.dataArray = @[@"推荐",@"关注",@"其他"];
    //当前为第0页
    self.pageStatus = @0;
    self.isInitial = YES;
    
    self.isFirstIntoTableViewArray = [NSMutableArray array];
    for (int i = 0; i < self.dataArray.count; i++) {
        [self.isFirstIntoTableViewArray addObject: @"YES"];
    }
}

//初始化scrollView和tableView
- (void)configSubView {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    //初始化topSegmentView
    self.topSegmentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, screenWidth, 80)];
    self.topSegmentView.contentSize = CGSizeMake(self.dataArray.count*70, 0);
    [self.view addSubview:self.topSegmentView];
    
    //初始化scrollView（3组view，可复用）
    self.tabScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.topSegmentView.frame), CGRectGetMaxY(self.topSegmentView.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-self.topSegmentView.frame.size.height-65)];
    [self.view addSubview:self.tabScrollView];
    // 设置滚动范围
    self.tabScrollView.contentSize = CGSizeMake(self.tabScrollView.frame.size.width*3, 0);
    self.tabScrollView.bounces = NO;
    self.tabScrollView.showsVerticalScrollIndicator = NO;
    self.tabScrollView.showsHorizontalScrollIndicator = NO;
    self.tabScrollView.delegate = self;
    self.tabScrollView.pagingEnabled = YES;
    
    //初始化MyTableView
    self.tableViewArray = [NSMutableArray array];
    for (int i = 0; i < 3; ++i) {
        MyTableView *myTableView = [[NSBundle mainBundle] loadNibNamed:@"MyTableView" owner:nil options:nil].lastObject;
        myTableView.frame = CGRectMake(i*screenWidth, 0, screenWidth, CGRectGetHeight(self.tabScrollView.frame));
        myTableView.cellArray = [NSMutableArray array];
        myTableView.page = @(i);
        myTableView.tableView.estimatedRowHeight = 200;
        
        [self.tableViewArray addObject:myTableView];
        [self.tabScrollView addSubview:myTableView];
    }
}

//初始化按钮
- (void)configBtn {
    //根据dataArray的数目生成对应的button
    self.buttonArray = [NSMutableArray array];
    for (int i = 0; i < self.dataArray.count; ++i) {
        ItemButton *itemButton = [[[NSBundle mainBundle] loadNibNamed:@"ItemButton" owner:nil options:nil] lastObject];
        [itemButton setFrame:CGRectMake(0, 0, 70, 70)];
        [self.topSegmentView addSubview:itemButton];
        //设置button位置
        [itemButton setCenter:CGPointMake(i*70+50, CGRectGetMidY(self.topSegmentView.bounds))];
        
        //设置button样式
        //设置图片
        NSString *normalBtnImageName = [NSString stringWithFormat:@"%@0",self.dataArray[i]];
        UIImage *normalImage = [UIImage imageNamed:normalBtnImageName];
        if (normalImage == nil) {
            normalImage = [UIImage imageNamed:@"default0"];
        }
        [itemButton setImage:normalImage forState:UIControlStateNormal];
        NSString *disabledBtnImageName = [NSString stringWithFormat:@"%@1",self.dataArray[i]];
        UIImage *disabledImage = [UIImage imageNamed:disabledBtnImageName];
        if (disabledImage == nil) {
            disabledImage = [UIImage imageNamed:@"default1"];
        }
        [itemButton setImage:disabledImage forState:UIControlStateDisabled];
        //设置文字
        [itemButton setTitle:self.dataArray[i] forState:UIControlStateNormal];
        [itemButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [itemButton setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        
        //设置第一个button为disabled
        if (i == 0) {
            itemButton.enabled = NO;
        }
        else {
            itemButton.enabled = YES;
        }
        
        [self.buttonArray addObject:itemButton];
    }
    
    //初始化underlineView
    ItemButton *firstButton = self.buttonArray[0];
    self.underlineView = [[UIView alloc] init];
    self.underlineView.backgroundColor = [UIColor redColor];
    [self.topSegmentView addSubview:self.underlineView];
    self.underlineView.frame = CGRectMake(CGRectGetMinX(firstButton.frame)+15, CGRectGetMaxY(firstButton.frame)-10, 40, 2.0);
    
}

#pragma mark - 初始化数据

- (void)loadData {
    //加载中
    [self.tabVM.loadDataCommond.executing subscribeNext:^(NSNumber * _Nullable x) {
        if (x.boolValue) {
            //显示菊花
            [MBProgressHUD waitHUD:self.view];
        }
    }];
    
    //加载完成
    [self.tabVM.loadDataCommond.executionSignals.switchToLatest subscribeNext:^(NSMutableArray* _Nullable x) {
        MyTableView *currentTableView;
        if (self.isInitial) {
            currentTableView = (MyTableView *)self.tableViewArray[0];
            self.cellArrayDict = [NSMutableDictionary dictionary];
            [self.cellArrayDict setObject:[x mutableCopy] forKey:@(0)];
            currentTableView.cellArray = [x mutableCopy];
            [currentTableView.tableView reloadData];
            self.isFirstIntoTableViewArray[0] = @"NO";
            self.isInitial = NO;
        }
        else {
            currentTableView = (MyTableView *)self.tableViewArray[1];
            [self.cellArrayDict setObject:[x mutableCopy] forKey:self.pageStatus];
            currentTableView.cellArray = [x mutableCopy];
            
            [self setContOffSet];
            //更新tableView
            [currentTableView.tableView reloadData];
            
        }
        [MBProgressHUD successHUD:self.view];
      }];

    //加载失败
    [self.tabVM.loadDataCommond.errors subscribeNext:^(NSError * _Nullable x) {
        [MBProgressHUD errorHUDWithView:self.view error:x];
    }];
    
    [self.tabVM.loadDataCommond execute:nil];
}



#pragma mark - 绑定ViewModel

- (void)configVM {
    //绑定
    self.tabVM = [[TabViewModel alloc] initWithVC:self];
}

#pragma mark - 切换tabView

- (void)switchTabView {
    [self changeBtnStyle];
    if([self.isFirstIntoTableViewArray[[self.pageStatus intValue]] isEqualToString: @"YES"]) {
        self.isFirstIntoTableViewArray[[self.pageStatus intValue]] = @"NO";
        //网络获取cell数据
        [self loadData];
    }
    else {
        //清除前一个tableView数据，防止回退时出现短暂的数据
        MyTableView *preTableView = (MyTableView *)self.tableViewArray[0];
        preTableView.cellArray = [NSMutableArray array];
        [preTableView.tableView reloadData];
        
        MyTableView *currentTableView = (MyTableView *)self.tableViewArray[1];
        currentTableView.cellArray = self.cellArrayDict[self.pageStatus];
        [currentTableView.tableView reloadData];
        [self setContOffSet];
    }
}

//改变scrollView的位置
- (void)setContOffSet {
    CGFloat contentSetX = CGRectGetWidth(self.tabScrollView.bounds);
    [self.tabScrollView setContentOffset:CGPointMake(contentSetX, 0) animated:NO];
}

//改变按钮样式
- (void)changeBtnStyle {
    for (int i = 0; i < self.buttonArray.count; ++i) {
        ItemButton *currentButton = self.buttonArray[i];
        if (i == [self.pageStatus intValue]) {
            currentButton.enabled = NO;
            [self slideUnderline:currentButton];
        }
        else {
            currentButton.enabled = YES;
        }
    }
}

//滑动underlineView
- (void)slideUnderline:(ItemButton *)btn {
    [UIView animateWithDuration:0.2 animations:^{
        self.underlineView.frame = CGRectMake(CGRectGetMinX(btn.frame)+15, CGRectGetMaxY(btn.frame)-10, self.underlineView.frame.size.width, self.underlineView.frame.size.height);
    }];
}

#pragma mark - scrollView的代理方法

//判断滑动到了哪个table界面
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.tabScrollView) {
        int currentPage;
        NSLog(@"%f，%@",self.tabScrollView.contentOffset.x, self.pageStatus);
        if (self.tabScrollView.contentOffset.x != 0) {
            if ([self.pageStatus intValue] != self.dataArray.count-1) {
                currentPage = [self.pageStatus intValue] + 1;
                self.pageStatus = @(currentPage);
            }
            else {
                //循环到第一个
                self.pageStatus = @(0);
            }
        }
        else {
            if ([self.pageStatus intValue] != 0) {
                currentPage = [self.pageStatus intValue] - 1;
                self.pageStatus = @(currentPage);
            }
            else {
                //循环到最后一个
                self.pageStatus = @(self.dataArray.count-1);
            }
        }
    }
}

#pragma mark - 绑定Notification
- (void)configNotification {
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"cellClicked" object:nil ] subscribeNext:^(NSNotification * _Nullable x) {
        [self performSegueWithIdentifier:@"detailSeg" sender:x.object];
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(DataModel *)sender {
    if ([segue.identifier isEqualToString:@"detailSeg"]) {
        DetailViewController *vc = segue.destinationViewController;
        vc.dataModel = sender;
    }
}


@end
