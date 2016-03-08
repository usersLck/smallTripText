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

#import "DiaryTitleController.h"



#define kTourMainUrlStr @"http://10.80.12.36:8080/text/travels?nowpage=1"

//  游圈主页
@interface TourFeelingController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *array;
@property(nonatomic, strong) NSMutableArray *firstArr;


// 点击加号按钮弹出view
@property (nonatomic, strong)UIView *addView;

@end

@implementation TourFeelingController


- (void)viewWillDisappear:(BOOL)animated {
    
    [self.view sendSubviewToBack:self.addView];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"游 圈";
    self.view.backgroundColor = [UIColor blueColor];
    [self creatAddView];
    [self createTableView];
    [self requireData];
    [self testFilter];
    [self addHeaderRefresh];
    [self addFooterRefresh];
    // 创建加号按钮
    [self addArticleButton];
    
}

// 数据解析
- (void)requireData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager GET:kTourMainUrlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:_tableView animated:YES];
        NSArray *arr = responseObject[@"success"];
        self.array = [NSMutableArray arrayWithCapacity:0];
        self.firstArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dict in arr) {
            TourModel *tourModel = [[TourModel alloc] init];
            [tourModel setValuesForKeysWithDictionary:dict];
            [self.array addObject:tourModel];
        }

        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
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
    progressHUD.labelText = @"玩命加载中...";
}

- (void)addHeaderRefresh {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"ddd");
        
            [self requireData];
//            [_tableView reloadData];
            [_tableView.mj_header endRefreshing];
        });
    }];
    [header setTitle:@"正在刷新数据..." forState:MJRefreshStateRefreshing];
    _tableView.mj_header = header;
}

- (void)addFooterRefresh {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"上拉");
            
            [_tableView reloadData];
            [_tableView.mj_footer endRefreshing];
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
    [cell cellRotation];// cell添加动画
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

// 创建加号按钮
- (void)addArticleButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(KWIDTH / 5 * 4, KHEIGHT / 7 * 5, KWIDTH / 6, KWIDTH / 6);
    button.backgroundColor = [UIColor greenColor];
    button.layer.cornerRadius = KWIDTH / 12;
    [button setImage:[UIImage imageNamed:@"add0"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

// 实现加号按钮方法
- (void)addView:(UIButton *)button {
    
    [self.view bringSubviewToFront:self.addView];
    
    
}

// 创建添加页面
- (void)creatAddView {
    
    self.addView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
    self.addView.backgroundColor = [UIColor blueColor];
    self.addView.alpha = 0.5;
    
    UIButton *addTravelsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addTravelsButton.frame = CGRectMake(KWIDTH / 9, KHEIGHT / 3, KWIDTH / 3, KWIDTH / 3);
    addTravelsButton.tag = 1001;
    addTravelsButton.backgroundColor = [UIColor clearColor];
    addTravelsButton.alpha = 1;
    [addTravelsButton setImage:[UIImage imageNamed:@"youji"] forState:UIControlStateNormal];
    [addTravelsButton addTarget:self action:@selector(writeTravels:) forControlEvents:UIControlEventTouchUpInside];
    [self.addView addSubview:addTravelsButton];
    
    UIButton *addMessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addMessageButton.frame = CGRectMake(KWIDTH / 9 * 5, KHEIGHT / 3, KWIDTH / 3, KWIDTH / 3);
    addMessageButton.tag = 1002;
    addMessageButton.backgroundColor = [UIColor clearColor];
    addMessageButton.alpha = 1;
    [addMessageButton setImage:[UIImage imageNamed:@"shuoshuo"] forState:UIControlStateNormal];
    [addMessageButton addTarget:self action:@selector(writeTravels:) forControlEvents:UIControlEventTouchUpInside];
    [self.addView addSubview:addMessageButton];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(KWIDTH / 5 * 4, KHEIGHT / 7 * 5, KWIDTH / 6, KWIDTH / 6);
    button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"add2"]];
    button.layer.cornerRadius = KWIDTH / 12;
    [button addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self.addView addSubview:button];
    
    
    
    [self.view addSubview:self.addView];
    
}

// 跳转到编辑游记(或心情)页面
- (void)writeTravels:(UIButton *)button {
    if (button.tag == 1001) {
        DiaryTitleController *DTVC = [[DiaryTitleController alloc] init];
        [self.navigationController pushViewController:DTVC animated:YES];
    }else{
        
    }
}

- (void)returnMainView:(UIButton *)button {
    
    [self.view sendSubviewToBack:self.addView];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
