//
//  HistoryViewController.m
//  smallTrip
//
//  Created by Aaslte on 16/2/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "HistoryViewController.h"
#import "ForumListViewController.h"


@interface HistoryViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *contentArray;

@end

@implementation HistoryViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.frame = CGRectMake(0, 0, 1, 1);
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 1, 1) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"清除搜索历史" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, KWIDTH, 44);
    [button addTarget:self action:@selector(deleteHistory:) forControlEvents:UIControlEventTouchUpInside];
    _tableView.tableFooterView = button;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 44;
//}
- (void)deleteHistory:(UIButton *)button {
    [_contentArray removeAllObjects];
    self.view.frame = self.view.frame = CGRectMake(0, 0, 1, 1);
    _tableView.frame = self.view.bounds;
    [_tableView reloadData];
    
}
- (void)setNewTableView:(NSMutableArray *)array {
    _contentArray  = array;
    if (_contentArray.count != 0) {
        if (_contentArray.count <= 5) {
            self.view.frame = CGRectMake(0, 108, KWIDTH, 44 * (_contentArray.count + 1));
        } else {
            self.view.frame = CGRectMake(0, 108, KWIDTH, 44 * 6);
        }
    } else {
        self.view.frame = CGRectMake(0, 0, 1, 1);
    }
    
    _tableView.frame = self.view.bounds;
    
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _contentArray[indexPath.row];
    return cell;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *string = _contentArray[indexPath.row];
//    ((ForumListViewController *)self.parentViewController).searchController.searchBar.text = string;
//}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
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
