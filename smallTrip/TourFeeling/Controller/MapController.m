//
//  MapController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TourDetailController.h"

#import "MapController.h"

#import "TabbarView.h"


//  地图页面
@interface MapController ()

@end

@implementation MapController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    [self CreateTabButton];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"首页" style:UIBarButtonItemStyleDone target:self action:@selector(returnIndex:)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)returnIndex:(UIBarButtonItem *)sender{
    
    
    [self.navigationController popToViewController: [self.navigationController viewControllers][1] animated:YES];
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
