//
//  HistoryViewController.h
//  smallTrip
//
//  Created by Aaslte on 16/2/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController

@property (nonatomic, strong, readonly) UITableView *tableView;
- (void)setNewTableView:(NSArray *)array;

@end
