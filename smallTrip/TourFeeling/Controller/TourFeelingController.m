//
//  TourFeelingController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/28.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TourFeelingController.h"

#import "TourManageController.h"


//  游圈主页
@interface TourFeelingController ()

@end

@implementation TourFeelingController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
//    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"游圈";
    self.view.backgroundColor = [UIColor blueColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(KWIDTH / 4 * 3, KHEIGHT - TABBARHEIGHT * 2, TABBARHEIGHT, TABBARHEIGHT);
    [self.view addSubview:button];
    [button setTitle:@"+" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:34];
    [button addTarget:self action:@selector(returnManage:) forControlEvents:UIControlEventTouchUpInside];
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
