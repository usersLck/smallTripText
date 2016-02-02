//
//  WeatherController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TourDetailController.h"

#import "WeatherController.h"

#import "TabbarView.h"

#import "SearchWeatherController.h"


//  天气主页
@interface WeatherController ()

@end

@implementation WeatherController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    [self CreateTabButton];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(KWIDTH / 22, KWIDTH / 22 + TABBARHEIGHT + 10, KWIDTH / 11, KWIDTH / 11);
    [self.view addSubview:button];
    [button setImage:[UIImage imageNamed:@"magnifier"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(returnSearch:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"首页" style:UIBarButtonItemStyleDone target:self action:@selector(returnIndex:)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)returnSearch:(UIButton *)sender{
    SearchWeatherController *search = [[SearchWeatherController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}

- (void)returnIndex:(UIBarButtonItem *)sender{
    [self.navigationController popToViewController:[self.navigationController viewControllers][1] animated:YES];
}


- (void)CreateTabButton{
    
    TabbarView *tabView = [[TabbarView alloc] initWithFrame:CGRectMake(0, KHEIGHT - TABBARHEIGHT, KWIDTH, TABBARHEIGHT) andDelegate:self];
    [self.view addSubview:tabView];
    
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
