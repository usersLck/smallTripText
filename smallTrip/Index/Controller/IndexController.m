//
//  IndexController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/28.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "IndexController.h"
#import "SearchController.h"
#import "TourFeelingController.h"
#import "TourDetailController.h"
#import <RESideMenu.h>
#import "RootTabBarViewController.h"

//  首页
#import "LikeButton.h"

@interface IndexController () <RESideMenuDelegate>

@end

@implementation IndexController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    ((RootTabBarViewController *)self.tabBarController).tabBarView.hidden = NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    self.navigationItem.title = @"推荐";
    self.view.backgroundColor  = [UIColor redColor];
    self.view.backgroundColor  = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 50, 300, 200);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(returnC:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    

    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(100, 400, 85, 30);
    button1.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:button1];
    [button1 setTitle:@"测试钮" forState:UIControlStateNormal];
    button1.layer.cornerRadius = 5;
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    LikeButton *likeButton = [[LikeButton alloc] initWithFrame:CGRectMake(300, 300, 100, 30)];
    likeButton.countLabel.text = @"10000";
    [self.view addSubview:likeButton];
}

- (void)returnC:(UIButton *)sender{
    NSString *STR = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSArray *ARR = [NSArray arrayWithContentsOfFile:@"/Users/liuchangkai/Library/Developer/CoreSimulator/Devices/FBE732A0-EAAF-46EF-8F0A-59EDFBD915F0/data/Containers/Data/Application/BE830CDC-9AE2-4218-A241-9C97C2E28915/Documents/Travels.plist"];
    NSLog(@"%@", ARR);
    TourDetailController *tour = [[TourDetailController alloc] init];
    [self.navigationController pushViewController:tour animated:YES];
}

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController {
    NSLog(@"1");
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController {
    NSLog(@"2");
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController {
    NSLog(@"3");
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController {
    NSLog(@"4");
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
