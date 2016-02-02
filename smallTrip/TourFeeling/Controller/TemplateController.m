//
//  TemplateController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/30.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TemplateController.h"

#import "AddDiaryController.h"


//  模板选择页面
@interface TemplateController ()

@end

@implementation TemplateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"模板选择";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    button.frame = CGRectMake(50, 50, 150, 100);
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(returnEdit:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)returnEdit:(UIButton *)sender{
    AddDiaryController *add = [[AddDiaryController alloc] init];
    [self.navigationController pushViewController:add animated:YES];
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
