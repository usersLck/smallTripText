//
//  ForumListViewController.m
//  smallTrip
//
//  Created by Aaslte on 16/2/19.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "ForumListViewController.h"
#import "ForumDetailController.h"
#import "CommunityController.h"
#import "ForumListCell.h"
#import "HistoryViewController.h"
#import <AFNetworking.h>
#import "ForumModel.h"
#import <MJRefresh.h>


@interface ForumListViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *historyArray; 
@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, strong) NSMutableArray *showArr;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger page;

@end

@implementation ForumListViewController

#pragma mark - 属性懒加载

- (NSMutableArray *)historyArray {
    if (!_historyArray) {
        _historyArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _historyArray;
}

- (NSArray *)dataSourceArr {
    if (!_dataSourceArr) {
        _dataSourceArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSourceArr;
}

- (NSMutableArray *)showArr {
    if (!_showArr) {
        _showArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _showArr;
}

- (void)resignResponder {
    _searchController.active = NO;
    self.parentViewController.navigationController.navigationBar.hidden = YES;
}

#pragma mark - 设置TableView
- (void)setTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tableView registerClass:[ForumListCell class] forCellReuseIdentifier:@"cell"];
}

# pragma mark - 设置SearchController
- (void)setSearchController {
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    [_searchController.searchBar sizeToFit];
    _searchController.searchBar.delegate = self;
    _tableView.tableHeaderView = _searchController.searchBar;
    _tableView.rowHeight = 200;
    
    _searchController.dimsBackgroundDuringPresentation = YES;
    _searchController.obscuresBackgroundDuringPresentation = YES;
    _searchController.hidesBottomBarWhenPushed = YES;
    
    _searchController.hidesNavigationBarDuringPresentation = NO;
}

#pragma mark - 获取NSURL
- (NSString *)getURlStr {
    NSString *url = [NSString stringWithFormat:@"http://10.80.12.36:8080/text/question?name=%@&nowpage=%ld", _name, _page];
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return url;
}

#pragma mark - 视图加载
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.frame = CGRectMake(0, 66, KWIDTH, KHEIGHT - 66);
    [self setTableView];
    
    [self setSearchController];
    
    // 历史搜索记录视图的控制器
    HistoryViewController *historyVC = [[HistoryViewController alloc] init];
    historyVC.view.backgroundColor = [UIColor whiteColor];
    historyVC.tableView.delegate = self;
    [self addChildViewController:historyVC];
    
    
    _name = @"all";
    _page = 1;
    
    [self getNetworkingData:[self getURlStr]];
}

#pragma mark - searchBar Delegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
//    NSLog(@"%d", _searchController.active);
//    self.parentViewController.navigationController.navigationBar.hidden = YES;
//    NSLog(@"%@", self.parentViewController.navigationController.navigationBar);
}

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
    for (ForumModel *model in _dataSourceArr) {
        NSString *str = model.title;
        if ([str containsString:searchController.searchBar.text]) {
            
            [_showArr addObject:model];
            [_tableView reloadData];
        }
    }
    
}

#pragma mark - TableVire Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _showArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForumListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ForumModel *model = self.showArr[indexPath.row];
    [cell setCell:model];
    
    //    CATransform3D rotation;//3D旋转
    //
    //    rotation = CATransform3DMakeTranslation(0 ,50 ,20);
    //                    rotation = CATransform3DMakeRotation( M_PI_4 , 0.0, 0.7, 0.4);
    //    //逆时针旋转
    //
    //    rotation = CATransform3DScale(rotation, 0.9, .9, 1);
    //
    //    rotation.m34 = 1.0/ -600;
    //
    //    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    //    cell.layer.shadowOffset = CGSizeMake(10, 10);
    //    cell.alpha = 0;
    //    cell.layer.transform = rotation;
    //
    //    [UIView beginAnimations:@"rotation" context:NULL];
    //    //旋转时间
    //    [UIView setAnimationDuration:0.6];
    //    cell.layer.transform = CATransform3DIdentity;
    //    cell.alpha = 1;
    //    cell.layer.shadowOffset = CGSizeMake(0, 0);
    //    [UIView commitAnimations];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == ((HistoryViewController *)self.childViewControllers[0]).tableView) {
        self.searchController.searchBar.text = self.historyArray[indexPath.row];
    } else {
    ForumDetailController *VC = [[ForumDetailController alloc] init];
    _searchController.active = NO;
    [self.navigationController pushViewController:VC animated:YES];
    //    [self.parentViewController presentViewController:VC animated:YES completion:nil];
    }
}



#pragma mark - 网络请求
- (void)getNetworkingData:(NSString *)url {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 需要转换类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *arr = responseObject[@"success"];
        for (NSDictionary *dic in arr) {
            ForumModel *model = [[ForumModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataSourceArr addObject:model];
            [self.showArr addObject:model];
        }
        [_tableView reloadData];
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络请求失败%@", task);
    }];
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
