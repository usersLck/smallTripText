//
//  TravelsImageController.m
//  smallTrip
//
//  Created by 纪宇驰 on 16/3/4.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TravelsImageController.h"

@interface TravelsImageController ()

@end

@implementation TravelsImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)doSave:(UIButton *)button{
    [super doSave:button];
    
    NSLog(@"%@", [self.navigationController viewControllers]);
    
    UIImage *image = self.imageView.image;
    NSDictionary *dict = @{@"image":image, @"sign":@"1", @"section":self.section};
    // 发送传递image的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"image" object:self userInfo:dict];
    
    
    
    
    [self.navigationController popToViewController:[self.navigationController viewControllers][2] animated:YES];
    
    
    
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
