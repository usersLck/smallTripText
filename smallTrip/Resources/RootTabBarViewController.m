//
//  RootTabBarViewController.m
//  smallTrip
//
//  Created by Aaslte on 16/2/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "IndexController.h"
#import "SearchController.h"
#import "TourFeelingController.h"
#import "CommunityController.h"

@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.hidden = YES;
    
    _tabBarView = [[UIView alloc] initWithFrame:self.tabBar.frame];
    _tabBarView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self.view addSubview:_tabBarView];
    
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.tabBar.frame.size.width / 4 * i, 0, self.tabBar.frame.size.width / 4, 49);
        [_tabBarView addSubview:button];
        [button addTarget:self action:@selector(doTap:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1000 + i;
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"a%d", i]] forState:UIControlStateNormal];
    }
    
    [self setNavigation];
    
    
}
- (void)doTap:(UIButton *)button {
    self.selectedIndex = button.tag % 1000;
}
- (void)setNavigation {
    IndexController *index = [[IndexController alloc] init];
    UINavigationController *indexNavi = [[UINavigationController alloc] initWithRootViewController:index];
    
    SearchController *search = [[SearchController alloc] init];
    UINavigationController *searchNavi = [[UINavigationController alloc] initWithRootViewController:search];
    
    
    TourFeelingController *tour = [[TourFeelingController alloc] init];
    UINavigationController *tourNavi = [[UINavigationController alloc] initWithRootViewController:tour];
    
    CommunityController *community = [[CommunityController alloc] init];
    UINavigationController *communityNavi = [[UINavigationController alloc] initWithRootViewController:community];
    
    
    NSArray *array = @[indexNavi, searchNavi, tourNavi, communityNavi];
    
    self.viewControllers = array;
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
