//
//  TourDetailController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TourDetailController.h"
#import "RootTabBarViewController.h"
#import "TabbarView.h"
#import "TimeShaftView.h"
#import "FXLabel.h"


#import "DetailTextCell.h"
#import "DetailImageCell.h"
#import "DetailTourModel.h"
#import <UIImageView+WebCache.h>
#import "ManagerTopView.h"


//  游记详情
@interface TourDetailController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *detailTableView;

// 时间轴button
@property (nonatomic, strong)UIButton *timeButton;

// 时间轴View
@property (nonatomic, strong)TimeShaftView *timeShaftView;

@end

@implementation TourDetailController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    ((RootTabBarViewController *)self.tabBarController).tabBarView.hidden = YES;
    [self CreateTabButton];
//    self.view.backgroundColor = [UIColor brownColor];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"游记详情";
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(returnIndex:)];
    self.navigationItem.leftBarButtonItem = button;
    
    NSLog(@"%@", self.tourModel.listArr);
    [self creatTimeShaftView];
    [self createDetailTableView];
    self.timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.timeButton.frame = CGRectMake(KWIDTH / 7 * 6, KHEIGHT / 7 * 5, KWIDTH / 7, KWIDTH / 7);
    self.timeButton.alpha = 0.6;
    self.timeButton.backgroundColor = [UIColor blackColor];
    [self.timeButton setImage:[UIImage imageNamed:@"open"] forState:UIControlStateNormal];
    [self.timeButton addTarget:self action:@selector(showTimeShaftView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.timeButton];
    
    
    
}

- (void)returnIndex:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSoure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tourModel.listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailTourModel *model = self.tourModel.listArr[indexPath.row];
    if ([model.type isEqualToString:@"1"]) {
        DetailTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"text"];
        cell.label.text = model.description0;
        return cell;
    } else if ([model.type isEqualToString:@"2"]) {
        DetailImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"image"];
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.description0] placeholderImage:nil];
        return cell;
    }
    return nil;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailTourModel *model = self.tourModel.listArr[indexPath.row];
    if ([model.type isEqualToString:@"1"]) {
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
        CGRect rect = [model.description0 boundingRectWithSize:CGSizeMake(KWIDTH - KWIDTH/20, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        return rect.size.height + KWIDTH/20;
    }
    return KWIDTH/20 + 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ManagerTopView *topView = [[ManagerTopView alloc] init];
    topView.tourModel = self.tourModel;
    return topView;
}

#pragma mark - 一些View、控件的创建
- (void)CreateTabButton{
    
    TabbarView *tabView = [[TabbarView alloc] initWithFrame:CGRectMake(0, KHEIGHT - TABBARHEIGHT, KWIDTH, TABBARHEIGHT) andDelegate:self];
    [self.view addSubview:tabView];
    
}

// 创建tableView
- (void)createDetailTableView {
    self.detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT - TABBARHEIGHT - 20) style:UITableViewStylePlain];
    self.detailTableView.dataSource = self;
    self.detailTableView.delegate = self;
    self.detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.detailTableView.backgroundColor = [UIColor whiteColor];
    [self.detailTableView registerClass:[DetailTextCell class] forCellReuseIdentifier:@"text"];
    [self.detailTableView registerClass:[DetailImageCell class] forCellReuseIdentifier:@"image"];
    self.detailTableView.tableFooterView = [self creatFootView];
    self.detailTableView.tableHeaderView = [self creatHeaderView];
    [self.view addSubview:self.detailTableView];
}

// 创建分区头View
- (UIView *)creatHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT / 4)];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT / 4)];
    imageV.image = [UIImage imageNamed:@"fjTest"];
    [headerView addSubview:imageV];
    
    FXLabel *titleLabel = [[FXLabel alloc] init];
    titleLabel.frame = CGRectMake(0, KHEIGHT / 10, KWIDTH, KHEIGHT / 20);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"══════ 元，你长大了 ══════";
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    titleLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.75f];
    titleLabel.shadowOffset = CGSizeMake(0.0f, 5.0f);
    titleLabel.shadowBlur = 5.0f;
    [headerView addSubview:titleLabel];
    
    UIImageView *userPic = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH / 20, KHEIGHT / 6 * 1, KWIDTH / 8, KWIDTH / 8)];
    userPic.image = [UIImage imageNamed:@"userPic"];
    userPic.backgroundColor = [UIColor yellowColor];
    userPic.layer.borderColor = [[UIColor whiteSmoke] CGColor];
    userPic.layer.borderWidth = 0.5;
    userPic.layer.cornerRadius = KWIDTH / 30;
    // 剪裁
    userPic.layer.masksToBounds = YES;
    [headerView addSubview:userPic];
    
    // 用户名label
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH / 5, KHEIGHT / 6, KWIDTH / 5 * 4, KWIDTH / 16)];
    userNameLabel.text = @"年轻的行者";
    userNameLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:userNameLabel];
    
    // 日期label
    UILabel *daysLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH / 5, KHEIGHT / 6 + KWIDTH / 16, KWIDTH / 5 * 4, KWIDTH / 16)];
    daysLabel.text = @"2016.3.8";
    daysLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:daysLabel];
    
    return headerView;
}


- (UIView *)creatFootView {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT / 4)];
    footView.backgroundColor = [UIColor whiteColor];
    UIImageView *endImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT / 16 * 3)];
    endImageView.image = [UIImage imageNamed:@"theEnd"];
    UILabel *endTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KHEIGHT / 16 * 3, KWIDTH, KHEIGHT / 16)];
    endTextLabel.text = @"微途,你的青春时光轴";
    endTextLabel.textAlignment = NSTextAlignmentCenter;
    endTextLabel.backgroundColor = [UIColor whiteColor];
    endTextLabel.textColor = [UIColor carapaceColor];
    [footView addSubview:endImageView];
    [footView addSubview:endTextLabel];
    return footView;
}

#pragma mark - 时间轴
// 时间轴button方法
- (void)showTimeShaftView:(UIButton *)button {
    
    self.timeButton.frame = CGRectMake(KWIDTH * 2, 0, 0, 0);
    [self.view bringSubviewToFront:self.timeShaftView];
    
    
}

// 创建时间轴View
- (void)creatTimeShaftView {
    
    self.timeShaftView = [[TimeShaftView alloc] initWithFrame:CGRectMake(KWIDTH / 4, 0, KWIDTH / 4 * 3, KHEIGHT - TABBARHEIGHT - 20)];
    // 还缺数据传入
//    self.timeShaftView.placeArr =
//    self.timeShaftView.timeStr =
    [self.timeShaftView.cancelButton addTarget:self action:@selector(removeTimeShaftView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.timeShaftView];
    [self.view sendSubviewToBack:self.timeShaftView];
    
}


// 收起时间轴View
- (void)removeTimeShaftView:(UIButton *)button {
    self.timeButton.frame = CGRectMake(KWIDTH / 7 * 6, KHEIGHT / 7 * 5, KWIDTH / 7, KWIDTH / 7);
    [self.view sendSubviewToBack:self.timeShaftView];
    
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
