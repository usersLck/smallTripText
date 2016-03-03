//
//  IndexController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/28.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "IndexController.h"

#import "SearchController.h"

#import "TourFeelingController.h"

#import "TourDetailController.h"

#import <RESideMenu.h>

//#import "NetHandler.h"

#define kUrlAll @"http://192.168.0.3:8080/text/aaa"
//http://lolbox.duowan.com/phone/apiHeroDetail.php?OSType=iOS8.1.2&v=70&heroName=Ashe"


#import "IndexModel.h"


//  首页
#import "LikeButton.h"

@interface IndexController () <RESideMenuDelegate>

@end

@implementation IndexController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"推荐";
    self.view.backgroundColor  = [UIColor redColor];
    self.view.backgroundColor  = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 50, 300, 200);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(returnC:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    

    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(100, 400, 85, 30);
    button1.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:button1];
    [button1 setTitle:@"测试钮" forState:UIControlStateNormal];
    button1.layer.cornerRadius = 5;
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(returnC:) forControlEvents:UIControlEventTouchUpInside];
    LikeButton *likeButton = [[LikeButton alloc] initWithFrame:CGRectMake(300, 300, 100, 30)];
    likeButton.countLabel.text = @"10000";
    [self.view addSubview:likeButton];
}

- (void)returnC:(UIButton *)sender{
    
    NSURL *url = [NSURL URLWithString:kUrlAll];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
//    NSData *datas = [@"date=20151101&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213" dataUsingEncoding:NSUTF8StringEncod ing];
//    [request setHTTPBody:datas];
    //  发送请求，建立链接
//    NSURLResponse *response = nil;
//    NSError *error = nil;
//    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    NSLog(@"%@", error);
//    NSError *jsonerr = nil;
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&jsonerr];
    
//    [NetHandler getDataWithUrl:kUrlAll completion:^(NSData *data) {
//        NSError *error = nil;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
//        NSLog(@"%@", dic[@"success"]);
//        NSArray *array = dic[@"success"];
//        for (NSDictionary *dics in array) {
//            IndexModel *index = [[IndexModel alloc] init];
//            [index setValuesForKeysWithDictionary:dics];
//            NSLog(@"%@\n%@", index.idcord, index.name);
//        }
//    }];
    
    TourDetailController *tour = [[TourDetailController alloc] init];
    [self.navigationController pushViewController:tour animated:YES];
}

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController {
    NSLog(@"1");
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController {
    NSLog(@"2");
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController {
    NSLog(@"3");
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController {
    NSLog(@"4");
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
