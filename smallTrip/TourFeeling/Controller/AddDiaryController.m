//
//  AddDiaryController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/30.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "AddDiaryController.h"


//  编写游记页面
@interface AddDiaryController ()

@end

@implementation AddDiaryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"添加游记";
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
