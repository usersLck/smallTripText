//
//  ViewController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/28.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "ViewController.h"
#import "ShareButton.h"
#import <UIImageView+WebCache.h>
#import "LikeButton.h"

@interface ViewController ()<UIAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 240, 30)];
    label.text = @"我们征程现在开始啦！！！";
    [self.view addSubview:label];
    
    ShareButton *button = [[ShareButton alloc] initShareButton:self];
    button.frame = CGRectMake(100, 100, 40, 30);
    
    [self.view addSubview:button];
    
    LikeButton *likeView = [[LikeButton alloc] initWithFrame:CGRectMake(100, 300, 120, 30) delegate:self];
    likeView.countLabel.text = @"123";
    [self.view addSubview:likeView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
