//
//  TourListController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/2/2.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TourListController.h"

#import "HistoryViewController.h"

//  游记集锦
@interface TourListController () <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic, retain)UITableView *table;

@property (nonatomic, retain)UISearchController *searchController;

@property (nonatomic, retain)NSMutableArray *historyArray;

@end

@implementation TourListController

- (NSMutableArray *)historyArray {
    if (!_historyArray) {
        _historyArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _historyArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"游记集锦";
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT - TABBARHEIGHT * 3 /2) style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self setSearchController];
    HistoryViewController *historyVC = [[HistoryViewController alloc] init];
    historyVC.view.backgroundColor = [UIColor whiteColor];
    historyVC.tableView.delegate = self;
    [self addChildViewController:historyVC];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hehe"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hehe"];
    }
    return cell;
}

- (void)setSearchController {
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    [_searchController.searchBar sizeToFit];
    _searchController.searchBar.delegate = self;
    _table.tableHeaderView = _searchController.searchBar;
    _table.rowHeight = 50;
    
    _searchController.dimsBackgroundDuringPresentation = YES;
    _searchController.obscuresBackgroundDuringPresentation = YES;
    _searchController.hidesBottomBarWhenPushed = YES;
    _searchController.hidesNavigationBarDuringPresentation = NO;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    HistoryViewController *VC = self.childViewControllers[0];
    [VC setNewTableView:_historyArray];
    [_searchController.view addSubview:VC.view];
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    if (![searchBar.text isEqualToString:@""]) {
        [self.historyArray addObject:searchBar.text];
    }
    _searchController.active = NO;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    if (![searchController.searchBar.text isEqualToString:@""]) {
        
    }
    
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
