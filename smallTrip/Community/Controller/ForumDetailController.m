//
//  ForumDetailController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/31.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "ForumDetailController.h"


//  问答详情
@interface ForumDetailController ()

@end

@implementation ForumDetailController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"问答详情";
    self.view.backgroundColor = [UIColor colorWithRed:120 green:130 blue:180 alpha:0.8];
    
    self.view.backgroundColor = [UIColor whiteColor];
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
