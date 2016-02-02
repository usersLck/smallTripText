//
//  CollectController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/2/2.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "CollectController.h"

#import "StrategyListController.h"

#import "TourListController.h"

//  我的收藏主页
@interface CollectController ()

@end

@implementation CollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的收藏";
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 200, 50)];
    [button3 setTitle:@"攻略集锦" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button3];
    [button3 addTarget:self action:@selector(returnVc:) forControlEvents:UIControlEventTouchUpInside];
    button3.tag = 5000;
    
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(50, 250, 200, 50)];
    [button4 setTitle:@"游记集锦" forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button4];
    [button4 addTarget:self action:@selector(returnVc:) forControlEvents:UIControlEventTouchUpInside];
    button4.tag = 5001;
    
    
}

- (void)returnVc:(UIButton *)sender{
    
    StrategyListController *strategy = [[StrategyListController alloc] init];
    
    TourListController *tour = [[TourListController alloc] init];
    
    NSArray *array = @[strategy, tour];
    
    [self.navigationController pushViewController:array[sender.tag % 1000] animated:YES];
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
