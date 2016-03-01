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

@interface ForumListViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) NSMutableArray *searchList;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *alphaView;

@end

@implementation ForumListViewController

- (UIView *)alphaView {
    if (!_alphaView) {
        _alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
        _alphaView.backgroundColor = [UIColor blackColor];
        _alphaView.alpha = 0.6;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignResponder)];
        [_alphaView addGestureRecognizer:tap];
    }
    return _alphaView;
}
- (void)resignResponder {
    _searchController.active = NO;
    self.parentViewController.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.frame = CGRectMake(0, 66, KWIDTH, KHEIGHT - 66);
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.pagingEnabled = YES;
    [tableView registerClass:[ForumListCell class] forCellReuseIdentifier:@"cell"];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    [_searchController.searchBar sizeToFit];
    _searchController.searchBar.delegate = self;
    tableView.tableHeaderView = _searchController.searchBar;
    tableView.rowHeight = 200;
    
    _searchController.dimsBackgroundDuringPresentation = YES;
    _searchController.obscuresBackgroundDuringPresentation = YES;
    _searchController.hidesBottomBarWhenPushed = YES;
//    _searchController.hidesNavigationBarDuringPresentation = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"%d", _searchController.active);
    self.parentViewController.navigationController.navigationBar.hidden = YES;
//    NSLog(@"%@", self.parentViewController.navigationController.navigationBar);
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"dddd");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
//    [self.parentViewController.view addSubview:self.alphaView];
//    CGRect rect = _searchController.searchBar.frame;
//    [UIView animateWithDuration:0.5 animations:^{
//       _searchController.searchBar.frame = CGRectMake(0, -46, rect.size.width, rect.size.height);
//    }];

    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.alphaView removeFromSuperview];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForumListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back"]];
    
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
    ForumDetailController *VC = [[ForumDetailController alloc] init];
    _searchController.active = NO;
    [self.navigationController pushViewController:VC animated:YES];
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
