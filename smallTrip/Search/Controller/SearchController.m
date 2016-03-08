//
//  SearchController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/28.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "SearchController.h"
#import "MapView.h"
#import "SectionView.h"
#import "HotDestinationCell.h"
#import "OtherDestinationCell.h"
#import "BigModel.h"
#import <AFNetworking.h>
#import "SearchDetailController.h"
#import <MJRefresh.h>

#define kUrlStr @"http://open.qyer.com/qyer/footprint/continent_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&page=1&track_app_channel=App%2520Store&track_app_version=6.8.4&track_device_info=iPhone7%2C1&track_deviceid=FED00E7E-E233-473F-990B-32BF24E8AE4F&track_os=ios%25209.2.1&v=1"

//  发现
@interface SearchController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *bigArr;
@property(nonatomic, strong) NSMutableArray *hotCountryArr;
@property(nonatomic, strong) NSMutableArray *otherCountryArr;
@property(nonatomic, strong) MapView *mapView;
@property(nonatomic, strong) SectionView *sectionView;
@property(nonatomic, strong) HotDestinationCell *hotCell;
@property(nonatomic, strong) UIButton *button;

@end

@implementation SearchController



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    [_mapView setButtonState:_button];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发现";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self requireData];
    [self createTableView];
    [self createMapViewAndSectionView];
    [self addHeaderRefresh];
    [UIFont familyNames];
    NSLog(@"%ld", [UIFont familyNames].count);
}

#pragma mark - 网络请求
- (void)requireData {
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    mager.responseSerializer = [AFJSONResponseSerializer serializer];
    [mager GET:kUrlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self analysisBigWithResponseObject:responseObject];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 数据解析
- (void)analysisBigWithResponseObject:(id)responseObject {
    NSArray *arr = responseObject[@"data"];
    self.bigArr = [NSMutableArray array];
    for (NSDictionary *dict in arr) {
        BigModel *bigModel = [[BigModel alloc] init];
        [bigModel setValuesForKeysWithDictionary:dict];
        [self.bigArr addObject:bigModel];
    }
    // 默认选中亚洲。第一次展示亚洲信息
    _hotCountryArr = [NSMutableArray arrayWithArray:((BigModel *)self.bigArr[0]).hotCountryArr];
    _otherCountryArr = [NSMutableArray arrayWithArray:((BigModel *)self.bigArr[0]).otherCountryArr];
}
#pragma mark - 创建mapView
- (void)createMapViewAndSectionView {
    _mapView = [[MapView alloc] init];
    _tableView.tableHeaderView = _mapView;    
    for (int i = 0; i < _mapView.buttonArr.count; i++) {
        UIButton *button = _mapView.buttonArr[i];
        if (i == 0) {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor orangeColor];
        }
//        button.tag = 1000+i;
        [button addTarget:self action:@selector(chooseContinent:) forControlEvents:UIControlEventTouchUpInside];
    }
    _sectionView = [[SectionView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 44)];
}

#pragma mark - 点击大洲按钮 选择大洲的方法实现
- (void)chooseContinent:(UIButton *)button{
    [_mapView setButtonState:button];
    _button = button;// 返回界面时继续动画
    BigModel *bigModel = _bigArr[button.tag%1000];
    _hotCountryArr = [NSMutableArray arrayWithArray:bigModel.hotCountryArr];
    _otherCountryArr = [NSMutableArray arrayWithArray:bigModel.otherCountryArr];
    _mapView.hottitleLabel.text = [NSString stringWithFormat:@"%@热门目的地", ((BigModel *)_bigArr[button.tag%1000]).cnname];
    _sectionView.titleLabel.text = [NSString stringWithFormat:@"%@其他地区", ((BigModel *)_bigArr[button.tag%1000]).cnname];
    [_tableView reloadData];
}

#pragma mark - 创建tableview
- (void)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[HotDestinationCell class] forCellReuseIdentifier:@"first"];
    [tableView registerClass:[OtherDestinationCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    _tableView = tableView;
}

#pragma mark - UITableViewDataSource
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _hotCountryArr.count;
    } else {
        return _otherCountryArr.count;
    }
}
// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
// 返回每行的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        _hotCell = [tableView dequeueReusableCellWithIdentifier:@"first"];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_hotCell configuireHotDestinationCellByModelArr:_hotCountryArr[indexPath.row] withTag:indexPath.row];
        if (_hotCountryArr.count < 2) {
            _hotCell.button2.userInteractionEnabled = NO;
        } else {
            _hotCell.button2.userInteractionEnabled = YES;
            _hotCell.button1.tag = (indexPath.row+1) * 1000 + 0;
            _hotCell.button2.tag = (indexPath.row+1) * 1000 + 1;
            [_hotCell.button1 addTarget:self action:@selector(chooseHotCountryDetail:) forControlEvents:UIControlEventTouchUpInside];
            [_hotCell.button2 addTarget:self action:@selector(chooseHotCountryDetail:) forControlEvents:UIControlEventTouchUpInside];
        }
        return _hotCell;
    } else {
        OtherDestinationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        OtherCountryModel *otherModel = _otherCountryArr[indexPath.row];
        cell.otherModel = otherModel;
        return cell;
    }
}



#pragma mark - UITableViewDelegate
// 头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return KHEIGHT/3.5 + 44;
    }
    return 44;
}
// 头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return _mapView;
    } 
    return _sectionView;
}
// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return KHEIGHT/3;
    }
    return 44;
}
// 点击cell响应的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        SearchDetailController *detailVc = [[SearchDetailController alloc] init];
        detailVc.contryid = ((OtherCountryModel *)_otherCountryArr[indexPath.row]).ID;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}

#pragma mark - 选择热门城市的button方法的实现
- (void)chooseHotCountryDetail:(UIButton *)button  {
    SearchDetailController *detailVc = [[SearchDetailController alloc] init];
    NSArray *arr = _hotCountryArr[button.tag / 1000 - 1];
    detailVc.contryid = ((HotCountryModel *)arr[button.tag % 1000]).ID;
        [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - 下拉刷新
- (void)addHeaderRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requireData];
    }];
}

@end
