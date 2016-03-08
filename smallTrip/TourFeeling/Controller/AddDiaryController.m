//
//  AddDiaryController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/30.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "AddDiaryController.h"
#import "PrefixHeader.pch"
#import "DiaryTitleController.h"


//  编写游记页面
@interface AddDiaryController ()

@end

@implementation AddDiaryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"添加游记";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button_1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button_1.frame = CGRectMake(KWIDTH / 10, KHEIGHT / 3, KWIDTH / 5, KHEIGHT / 5);
    button_1.titleLabel.text = @"长游记";
    button_1.backgroundColor = [UIColor blackColor];
    button_1.tintColor = [UIColor greenColor];
    [button_1 addTarget:self action:@selector(writeLD:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_1];
    
    
    
    
}

- (void)writeLD:(UIButton *)button {
    DiaryTitleController *DTC = [[DiaryTitleController alloc] init];
    [self.navigationController pushViewController:DTC animated:YES];
    
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
