//
//  TourPartnerController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/30.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TourPartnerController.h"

#import "TourManageController.h"

#import "FootController.h"

#import "ShareController.h"

#import "ForumManageController.h"



//  旅友主页
@interface TourPartnerController ()

@end

@implementation TourPartnerController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 200, 50)];
    [button setTitle:@"ta的游记" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(returnVc:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 5000;
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    [button1 setTitle:@"ta的足迹" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button1];
    [button1 addTarget:self action:@selector(returnVc:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag = 5001;
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(50, 150, 200, 50)];
    [button2 setTitle:@"ta的分享" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(returnVc:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag = 5002;
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 200, 50)];
    [button3 setTitle:@"ta的社区" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button3];
    [button3 addTarget:self action:@selector(returnVc:) forControlEvents:UIControlEventTouchUpInside];
    button3.tag = 5003;
}

- (void)returnVc:(UIButton *)sender{
    TourManageController *tourManage = [[TourManageController alloc] init];
    
    FootController *foot = [[FootController alloc] init];
    
    ShareController *share = [[ShareController alloc] init];
    
    ForumManageController *forum = [[ForumManageController alloc] init];
    
    NSArray *array = @[tourManage, foot, share, forum];
    
    [self.navigationController pushViewController:array[sender.tag % 1000] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
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
