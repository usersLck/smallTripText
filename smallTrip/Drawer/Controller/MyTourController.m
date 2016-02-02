//
//  MyTourController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/2/2.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "MyTourController.h"

#import "TravelViewController.h"


//  我的旅行单主页
@interface MyTourController ()

@end

@implementation MyTourController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的旅行单";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"查看行程" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(returnVc:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)returnVc:(UIButton *)sender{
    TravelViewController *travel = [[TravelViewController alloc] init];
    [self.navigationController pushViewController:travel animated:YES];
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
