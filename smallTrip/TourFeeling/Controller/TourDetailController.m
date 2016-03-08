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

#import "DetailTextCell.h"
#import "DetailImageCell.h"
#import "DetailTourModel.h"
#import <UIImageView+WebCache.h>
#import "ManagerTopView.h"


//  游记详情
@interface TourDetailController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *detailTableView;

@end

@implementation TourDetailController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    ((RootTabBarViewController *)self.tabBarController).tabBarView.hidden = YES;
    [self CreateTabButton];
//    self.view.backgroundColor = [UIColor brownColor];
}

- (void)CreateTabButton{
    
    TabbarView *tabView = [[TabbarView alloc] initWithFrame:CGRectMake(0, KHEIGHT - TABBARHEIGHT, KWIDTH, TABBARHEIGHT) andDelegate:self];
    [self.view addSubview:tabView];
   
}

- (void)createDetailTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor orangeColor];
    _detailTableView = tableView;
    [_detailTableView registerClass:[DetailTextCell class] forCellReuseIdentifier:@"text"];
    [_detailTableView registerClass:[DetailImageCell class] forCellReuseIdentifier:@"image"];
    [self.view addSubview:_detailTableView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"游记详情";
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(returnIndex:)];
    self.navigationItem.leftBarButtonItem = button;
    
    NSLog(@"%@", self.tourModel.listArr);
    [self createDetailTableView];
    
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
