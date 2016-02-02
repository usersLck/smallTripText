//
//  ForumController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/30.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "ForumController.h"

#import "ForumDetailController.h"

//  问答专区
@interface ForumController ()

@end

@implementation ForumController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blueColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 50, 150, 80);
    [button setTitle:@"问答详情" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(returnDetail:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)returnDetail:(UIButton *)sender{
    ForumDetailController *partner = [[ForumDetailController alloc] init];
    [self.navigationController pushViewController:partner animated:YES];
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
