//
//  DrawerController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "DrawerController.h"

#import "CollectController.h"

#import "MyTourController.h"

#import "MyForumController.h"

#import "TourManageController.h"

#import "UserManageController.h"

//  抽屉首页
@interface DrawerController ()

@end

@implementation DrawerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 200, 50)];
    [button setTitle:@"我的游记" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(returnVc:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 5000;
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    [button1 setTitle:@"我的收藏" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button1];
    [button1 addTarget:self action:@selector(returnVc:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag = 5001;
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(50, 150, 200, 50)];
    [button2 setTitle:@"我的旅行单" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(returnVc:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag = 5002;
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 200, 50)];
    [button3 setTitle:@"我的社交" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button3];
    [button3 addTarget:self action:@selector(returnVc:) forControlEvents:UIControlEventTouchUpInside];
    button3.tag = 5003;
    
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(50, 250, 200, 50)];
    [button4 setTitle:@"账户管理" forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button4];
    [button4 addTarget:self action:@selector(returnVc:) forControlEvents:UIControlEventTouchUpInside];
    button4.tag = 5004;
    
    
}

- (void)returnVc:(UIButton *)sender{
    
    CollectController *collect = [[CollectController alloc] init];
    
    UINavigationController *collectNavi = [[UINavigationController alloc] initWithRootViewController:collect];
    
    TourManageController *tourManage = [[TourManageController alloc] init];
    
    UINavigationController *tourManageNavi = [[UINavigationController alloc] initWithRootViewController:tourManage];
    
    MyTourController *myTour = [[MyTourController alloc] init];
    
    UINavigationController *myTourNavi = [[UINavigationController alloc] initWithRootViewController:myTour];
    
    MyForumController *forum = [[MyForumController alloc] init];
    
    UINavigationController *forumNavi = [[UINavigationController alloc] initWithRootViewController:forum];
    
    UserManageController *user = [[UserManageController alloc] init];
    
    UINavigationController *userNavi = [[UINavigationController alloc] initWithRootViewController:user];
    
//    NSArray *array = @[collect, tourManage, myTour, forum, user];
    
    NSArray *arr = @[collectNavi, tourManageNavi, myTourNavi, forumNavi, userNavi];
    
    [self presentViewController:arr[sender.tag % 1000] animated:YES completion:nil ];
    
//    [self.navigationController pushViewController:array[sender.tag % 1000] animated:YES];
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
