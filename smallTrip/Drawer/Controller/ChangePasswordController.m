//
//  ChangePasswordController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/2/2.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "ChangePasswordController.h"

#import "EditPasswordController.h"

@interface ChangePasswordController ()

@end

@implementation ChangePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"修改密码";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"发送邮件" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(returnVc:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)returnVc:(UIButton *)sender{
    EditPasswordController *change = [[EditPasswordController alloc] init];
    [self.navigationController pushViewController:change animated:YES];
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
