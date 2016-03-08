//
//  PlaceChoseController.m
//  smallTrip
//
//  Created by 纪宇驰 on 16/3/4.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "PlaceChoseController.h"
#import "HistoryViewController.h"


@interface PlaceChoseController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating>
@property (nonatomic, strong)NSMutableArray *historyArray;
@property (nonatomic, strong)NSMutableArray *showArr;

@property (nonatomic, strong)UISearchController *searchController;
@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSString *section;



// 1.0版本
@property (nonatomic, strong)UITextField *textField;





@end

@implementation PlaceChoseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIBarButtonItem *choseButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(confirmPlace:)];
    self.navigationItem.rightBarButtonItem = choseButton;
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT / 20)];
    self.textField.placeholder = @"请输入地点";
    self.textField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textField];
    [self creatSection];
//    [self setTableView];
//    
//    [self setSearchController];
//    
//    // 历史搜索记录视图的控制器
//    HistoryViewController *historyVC = [[HistoryViewController alloc] init];
//    historyVC.view.backgroundColor = [UIColor whiteColor];
//    historyVC.tableView.delegate = self;
//    [self addChildViewController:historyVC];
//    
    
    
    
    
}

#pragma mark - 创建tableView
- (void)setTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - 创建searchBar
- (void)setSearchController {
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    [_searchController.searchBar sizeToFit];
    _searchController.searchBar.delegate = self;
    _tableView.tableHeaderView = _searchController.searchBar;
    _tableView.rowHeight = 40;
    
    _searchController.dimsBackgroundDuringPresentation = YES;
    _searchController.obscuresBackgroundDuringPresentation = YES;
    _searchController.hidesBottomBarWhenPushed = YES;
    
    _searchController.hidesNavigationBarDuringPresentation = NO;
}

#pragma mark - UITableViewDelegate方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    return cell;
}

#pragma mark - UISearchBar代理方法
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    HistoryViewController *VC = self.childViewControllers[0];
    [VC setNewTableView:_historyArray];
    VC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [_searchController.view addSubview:VC.view];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    if (![searchBar.text isEqualToString:@""]) {
        [self.historyArray addObject:searchBar.text];
    }
    _searchController.active = NO;
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"%@", searchController.searchBar.text);
    _showArr = [NSMutableArray arrayWithCapacity:0];
    
    
}

#pragma mark - 懒加载
- (NSMutableArray *)historyArray {
    if (!_historyArray) {
        self.historyArray = [NSMutableArray array];
    }
    return _historyArray;
    
}



#pragma mark - 点击navigationBar右侧按钮方法
- (void)confirmPlace:(UIBarButtonItem *)Item {
    NSDictionary *dict = @{@"section":self.section, @"place":self.textField.text};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"place" object:self userInfo:dict];
    [self.navigationController popToViewController:[self.navigationController viewControllers][2] animated:YES];
    
}

- (void)creatSection {
    self.section = [NSString stringWithFormat:@"%ld", self.sectionNum];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
