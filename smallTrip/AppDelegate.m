//
//  AppDelegate.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/28.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "AppDelegate.h"

#import "IndexController.h"

#import "CommunityController.h"

#import "SearchController.h"

#import "TourFeelingController.h"

#import "DrawerController.h"

#import <RESideMenu.h>

@interface AppDelegate () <RESideMenuDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor  = [UIColor whiteColor];
    
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    
    IndexController *index = [[IndexController alloc] init];
    UINavigationController *indexNavi = [[UINavigationController alloc] initWithRootViewController:index];
    indexNavi.tabBarItem.title = @"首页";
    indexNavi.tabBarItem.image = [UIImage imageNamed:@"index"];
    
    SearchController *search = [[SearchController alloc] init];
    UINavigationController *searchNavi = [[UINavigationController alloc] initWithRootViewController:search];
    searchNavi.tabBarItem.title = @"发现";
    searchNavi.tabBarItem.image = [UIImage imageNamed:@"search"];
    
    
    TourFeelingController *tour = [[TourFeelingController alloc] init];
    UINavigationController *tourNavi = [[UINavigationController alloc] initWithRootViewController:tour];
    tourNavi.tabBarItem.title = @"游圈";
    tourNavi.tabBarItem.image = [UIImage imageNamed:@"tour"];
    
    CommunityController *community = [[CommunityController alloc] init];
    UINavigationController *communityNavi = [[UINavigationController alloc] initWithRootViewController:community];
    communityNavi.tabBarItem.title = @"社交";
    communityNavi.tabBarItem.image = [UIImage imageNamed:@"community"];
    
    
    NSArray *array = @[indexNavi, searchNavi, tourNavi, communityNavi];
    
    tabbar.viewControllers = array;
    
    tabbar.selectedIndex = 0;
    
    DrawerController *drawer = [[DrawerController alloc] init];
    
    UINavigationController *drawerNavi = [[UINavigationController alloc] initWithRootViewController:drawer];
    
    RESideMenu *reside = [[RESideMenu alloc] initWithContentViewController:tabbar leftMenuViewController:drawerNavi rightMenuViewController:nil];
    reside.view.backgroundColor = [UIColor yellowColor];
    reside.view.frame = [UIScreen mainScreen].bounds;
    reside.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    reside.contentViewShadowColor = [UIColor blackColor];
    reside.contentViewShadowOffset = CGSizeMake(0, 0);
    reside.contentViewShadowOpacity = 0.6;
    reside.contentViewShadowRadius = 12;
    reside.contentViewShadowEnabled = NO;
    reside.delegate = self;

    
    self.window.rootViewController = reside;
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
