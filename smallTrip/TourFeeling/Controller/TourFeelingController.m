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

//  游圈主页
@interface TourFeelingController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation TourFeelingController

- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
////    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}

// createTableView
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[FirstTourCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[SecondTourCell class] forCellReuseIdentifier:@"cell2"];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"游 圈";
    self.view.backgroundColor = [UIColor blueColor];
    
    [self createTableView];
    
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(returnManage:)];
//    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(KWIDTH / 4 * 3, KHEIGHT - TABBARHEIGHT * 2, TABBARHEIGHT, TABBARHEIGHT);
    [self.view addSubview:button];
    [button setTitle:@"+" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:34];
    [button addTarget:self action:@selector(returnManage:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(100, 200, 100, 50);
    [button1 setTitle:@"滤镜" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
}
- (void)test:(UIButton *)button {
    TestViewController *test = [[TestViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SecondTourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    [cell cellRotation];// cell添加动画
    
    return cell;
    
    /*
    if (indexPath.row % 2 != 0) {
        FirstTourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        return cell;
    } else {
        SecondTourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        [cell cellRotation];// cell添加动画
        
        return cell;
    }
     */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return KHEIGHT/4 + 3;
    
    /*
    if (indexPath.row % 2 != 0) {
//        FirstTourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//        return cell.headImageView.bounds.size.height + cell.contentLabel.bounds.size.height + cell.attentionButton.bounds.size.height + 30;
        return 160;
    } else {
//        SecondTourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
//        return cell.pictureImageView.bounds.size.height + cell.titleLabel.bounds.size.height + cell.contentLabel.bounds.size.height + cell.attentionButton.bounds.size.height + 30;
        return 320;
    }
    */
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TourDetailController *tourDetailController = [[TourDetailController alloc] init];
    [self.navigationController pushViewController:tourDetailController animated:YES];
}

- (void)returnManage:(UIButton *)sender{
    TourManageController *manage = [[TourManageController alloc] init];
    [self.navigationController pushViewController:manage animated:YES];
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
