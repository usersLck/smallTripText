//
//  CommunityController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/28.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "CommunityController.h"

#import "TravelView.h"

#import "PartnerView.h"

#import "ForumView.h"

#import "TourPartnerController.h"

#import "FindPartnerController.h"

#import "ForumController.h"

#import "ForumListViewController.h"

//  社交主页
@interface CommunityController ()

@property (nonatomic, retain)TravelView *travel;

@property (nonatomic, retain)PartnerView *partner;

@property (nonatomic, retain)ForumView *forum;

@end

@implementation CommunityController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
//    NSLog(@"%@", self.navigationController.navigationBar);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationItem.title = @"社交";

    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"旅友排行", @"结伴旅行", @"问答专区"]];
    seg.frame = CGRectMake(0, BUTTONHEIGHT, KWIDTH, BUTTONHEIGHT);
    [self.view addSubview:seg];
    [seg addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventValueChanged];
    
    self.travel = [[TravelView alloc] initWithFrame:CGRectMake(0, seg.frame.origin.y + seg.frame.size.height, KWIDTH, KHEIGHT - seg.frame.origin.y - seg.frame.size.height)];
    [self.view addSubview:self.travel];
    self.travel.tag = 2000;
    [self.travel.button addTarget:self action:@selector(returnVC:) forControlEvents:UIControlEventTouchUpInside];
    self.travel.button.tag = 3000;
    
    self.partner = [[PartnerView alloc] initWithFrame:self.travel.frame];
    [self.view addSubview:self.partner];
    self.partner.tag = 2001;
    [self.partner.button addTarget:self action:@selector(returnVC:) forControlEvents:UIControlEventTouchUpInside];
    self.partner.button.tag = 3001;
    
    
//    self.forum = [[ForumView alloc] initWithFrame:self.travel.frame];
//    [self.view addSubview:self.forum];
//    self.forum.tag = 2002;
//    [self.forum.button addTarget:self action:@selector(returnVC:) forControlEvents:UIControlEventTouchUpInside];
//    self.forum.button.tag = 3002;
    
    ForumListViewController *forumListVC = [[ForumListViewController alloc] init];
    forumListVC.view.tag = 2002;
    [self.view addSubview:forumListVC.view];
    [self addChildViewController:forumListVC];
    
    
    seg.selectedSegmentIndex = 0;
    
    [self.view bringSubviewToFront:self.travel];
    NSLog(@"%@", self.navigationController);
}

- (void)returnVC:(UIButton *)sender{
    TourPartnerController *tour = [[TourPartnerController alloc] init];
    
    FindPartnerController *find = [[FindPartnerController alloc] init];
    
    ForumController *forum = [[ForumController alloc] init];
    
    NSArray *vcArr = @[tour, find, forum];
    [self.navigationController pushViewController:vcArr[sender.tag % 1000] animated:YES];
}

- (void)changeView:(UISegmentedControl *)sender{
    UIViewController *VC = [self viewController:[self.view viewWithTag:2000 + sender.selectedSegmentIndex]];
    

//        ((ForumListViewController *)VC).searchController.active = NO;
    
        
    

    [self.view bringSubviewToFront:[self.view viewWithTag:2000 + sender.selectedSegmentIndex]];
}
- (UIViewController *)viewController:(UIView *)view {
//    for (UIView *next = [view superview]; next; [next superview]) {
//        UIResponder *nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[UIViewController class]]) {
//            return (UIViewController *)nextResponder;
//        }
//    }
//    return nil;
    id next = [view nextResponder];
    while (![next isKindOfClass:[UIViewController class]] && next != nil) {
        next = [next nextResponder];
    }
    return (UIViewController *)next;
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
