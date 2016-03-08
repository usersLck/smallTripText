//
//  TourFeelingController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/28.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TourFeelingController.h"
#import "TourManageController.h"
#import "FirstTourCell.h"
#import "SecondTourCell.h"
#import "TourDetailController.h"
#import "TestViewController.h"
#import "RootTabBarViewController.h"
#import <AFNetworking.h>
#import <MBProgressHUD.h>
#import <MJRefreshHeader.h>
#import <MJRefreshFooter.h>
#import <MJRefresh.h>
#import "TourModel.h"
#import "TourPartnerController.h"

#define kTourMainUrlStr @"http://10.80.12.36:8080/text/travels"
#define kAppendingStr @"?nowpage=1"

//  游圈主页
@interface TourFeelingController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *array;

@end

typedef NS_ENUM(NSInteger, RequireType){
    hearderRequire,
    footerRequire,
    normalRequire
};

@implementation TourFeelingController
static int page = 1;

// 解析数据
- (void)jsonAnalysis:(id)responseObject requireType:(RequireType)requireType {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSArray *arr = dict[@"success"];
    self.array = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dict in arr) {
        TourModel *tourModel = [[TourModel alloc] init];
        [tourModel setValuesForKeysWithDictionary:dict];
        if (requireType == hearderRequire) {
            self.array = [NSMutableArray array];
            [self.array addObject:tourModel];
        }
        [self.array addObject:tourModel];
    }
}

// 网络请求
- (void)requireDataWithURLString:(NSString *)urlStr requireType:(RequireType)requireType {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:_tableView animated:YES];
        [self jsonAnalysis:responseObject requireType:requireType];
        [self.tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络请求错误：%@", error);
    }];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ////    self.navigationController.navigationBar.hidden = YES;
    ((RootTabBarViewController *)self.tabBarController).tabBarView.hidden = NO;
}

// createTableView
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[FirstTourCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[SecondTourCell class] forCellReuseIdentifier:@"cell2"];
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:_tableView animated:YES];
    progressHUD.labelText = @"数据加载中...";
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"游 圈";
    self.view.backgroundColor = [UIColor blueColor];
    
    [self createTableView];
    [self requireDataWithURLString:[kTourMainUrlStr stringByAppendingString:kAppendingStr] requireType:normalRequire];
    
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(returnManage:)];
//    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(KWIDTH / 4 * 3, KHEIGHT - TABBARHEIGHT * 2, TABBARHEIGHT, TABBARHEIGHT);
    [self.view addSubview:button];
    [button setTitle:@"+" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:34];
    [button addTarget:self action:@selector(returnManage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self testFilter];
    [self addHeaderRefresh];
    [self addFooterRefresh];
}
// 下拉加载
- (void)addHeaderRefresh {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{        
            [self requireDataWithURLString:kTourMainUrlStr requireType:hearderRequire];
            // 放到网络请求里去结束刷新
//            [_tableView.mj_header endRefreshing];
        });
    }];
    [header setTitle:@"正在刷新数据..." forState:MJRefreshStateRefreshing];
    _tableView.mj_header = header;
}
// 下拉刷新
- (void)addFooterRefresh {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            page++;
            NSString *urlStr = [kTourMainUrlStr stringByAppendingString:[NSString stringWithFormat:@"?nowpage=%d", page]];
            [self requireDataWithURLString:urlStr requireType:footerRequire];
        });
    }];
    [footer setTitle:MJRefreshAutoFooterRefreshingText forState:MJRefreshStateRefreshing];
    _tableView.mj_footer = footer;
}

- (void)testFilter {
#warning 测试滤镜
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(100, 200, 100, 50);
    [button1 setTitle:@"滤镜" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
}
- (void)test:(UIButton *)button {
    TestViewController *test = [[TestViewController alloc] init];
    
    [self presentViewController:test animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SecondTourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    [cell.headButton addTarget:self action:@selector(goTourPartner:) forControlEvents:UIControlEventTouchUpInside];
    TourModel *tourModel = self.array[indexPath.row];
    cell.tourModel = tourModel;
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KHEIGHT/4 + 3;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TourDetailController *tourDetailController = [[TourDetailController alloc] init];
    tourDetailController.tourModel = self.array[indexPath.row];
    [self.navigationController pushViewController:tourDetailController animated:YES];
}

- (void)returnManage:(UIButton *)sender{
    TourManageController *manage = [[TourManageController alloc] init];
    [self.navigationController pushViewController:manage animated:YES];
}

#warning 跳转到旅游主页
- (void)goTourPartner:(UIButton *)button {
    TourPartnerController *tourPartnerVc = [[TourPartnerController alloc] init];
//    tourPartnerVc. =
    [self.navigationController pushViewController:tourPartnerVc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
