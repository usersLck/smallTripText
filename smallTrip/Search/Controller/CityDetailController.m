//
//  CityDetailController.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/6.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "CityDetailController.h"
#import "CityTopView.h"
#import "CityTopModel.h"
#import <AFNetworking.h>
#import "CityListCell.h"
#import "CityTableModel.h"
#import <Accelerate/Accelerate.h>
#import "ScenicDetailController.h"
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "UIImageView+LBBlurredImage.h"

#define kScrollUrl(cityId) [NSString stringWithFormat:@"http://open.qyer.com/qyer/footprint/city_detail?city_id=%@&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&page=1&track_app_channel=App%%2520Store&track_app_version=6.8.4&track_device_info=iPhone7%%2C1&track_deviceid=FED00E7E-E233-473F-990B-32BF24E8AE4F&track_os=ios%%25209.2.1&v=1", cityId]

#define kTableViewUrl(cityId, page) [NSString stringWithFormat:@"http://open.qyer.com/qyer/onroad/poi_list?category_id=32%%2C147%%2C148&city_id=%@&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&orderby=popular&page=%ld&track_app_channel=App%%2520Store&track_app_version=6.8.4&track_device_info=iPhone7%%2C1&track_deviceid=FED00E7E-E233-473F-990B-32BF24E8AE4F&track_os=ios%%25209.2.1&types=&v=1", cityId, page]

@interface CityDetailController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) CityTopView *cityTopV;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIButton *topButton;

@end

NSInteger page1 = 2;// 上拉次数
NSString *oldCityId;// 判断上拉的城市
static BOOL flag = YES;
@implementation CityDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setBackgroundImage];
    [self requireDataWithCityId:self.cityId];
    [self requireDataForTableViewWithCityId:self.cityId page:1];
    [self createCityTopView];
    [self createTableView];
    [self addFooterRefresh];
    [self addBackTop];
}

#pragma mark - 背景图片模糊处理
- (void)setBackgroundImage {

    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
    [_imageV sd_setImageWithURL:[NSURL URLWithString:self.imageUrl]];
    [_imageV setImageToBlur:_imageV.image blurRadius:50 completionBlock:nil];
    [self.view insertSubview:_imageV atIndex:0];
}

#pragma mark - 创建topView
- (void)createCityTopView {
    _cityTopV = [[CityTopView alloc] init];
    [_cityTopV.backButton addTarget:self action:@selector(doback:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cityTopV];
}
- (void)doback:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 创建tableview
- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-49) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[CityListCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}
#pragma mark - 懒加载创建数组
- (NSMutableArray *)listArr {
    if (!_listArr) {
        self.listArr = [NSMutableArray array];
    }
    return _listArr;
}

#pragma mark - 网络请求TopView
- (void)requireDataWithCityId:(NSString *)cityId {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:kScrollUrl(cityId) parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self analysisDataWithObject:responseObject];
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
    }];
}
#pragma mark - 数据解析TopView
- (void)analysisDataWithObject:(id)responseObject {
    CityTopModel *model = [[CityTopModel alloc] init];
    [model setValuesForKeysWithDictionary:responseObject[@"data"]];
    _cityTopV.topModel = model;
    self.tableView.tableHeaderView = _cityTopV;
}

#pragma mark - 网络请求TableView
- (void)requireDataForTableViewWithCityId:(NSString *)cityId page:(NSInteger)page {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:kTableViewUrl(cityId, page) parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self analysisDataForTableViewWithObject:responseObject];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
#pragma mark - 数据解析TableView
- (void)analysisDataForTableViewWithObject:(id)responseObject {
    NSDictionary *dict = responseObject[@"data"];
    NSArray *arr = dict[@"entry"];
    for (NSDictionary *dic in arr) {
        CityTableModel *model = [[CityTableModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.listArr addObject:model];
    }
}

#pragma mark - UITableViewDataSource数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.cityModel = self.listArr[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 210 + 5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ScenicDetailController *scenicDetailVc = [[ScenicDetailController alloc] init];
    scenicDetailVc.scenicId = ((CityTableModel *)self.listArr[indexPath.row]).ID;
    [self.navigationController pushViewController:scenicDetailVc animated:YES];
}

#pragma mark - 下拉加载
- (void)addFooterRefresh {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSString *newCityId = self.cityId;
        if ([newCityId isEqualToString:oldCityId]) {
            page1++;
        } else {
            page1 = 2;
        }
        [self requireDataForTableViewWithCityId:self.cityId page:page1];
        oldCityId = self.cityId;
    }];
    footer.stateLabel.textColor = [UIColor whiteColor];
    self.tableView.mj_footer = footer;
}

#pragma mark - 返回顶部
- (void)addBackTop {
    _topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_topButton setTitle:@"点击返回顶部" forState:UIControlStateNormal];
    _topButton.layer.cornerRadius = 5;
    _topButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _topButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _topButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [_topButton addTarget:self action:@selector(doTop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topButton];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > KHEIGHT/3) {
        if (flag) {
            _topButton.frame = CGRectMake(KWIDTH-85, KHEIGHT-80, 85, 30);
            flag = NO;
    }
    } else if (scrollView.contentOffset.y < KHEIGHT/3) {
        if (!flag) {
            _topButton.frame = CGRectMake(KWIDTH*3/4, KHEIGHT, KWIDTH/4, 30);
            flag = YES;
        }
    }
}


- (void)doTop:(UIButton *)button {
    _tableView.contentOffset = CGPointMake(0, 0);
    _topButton.frame = CGRectMake(KWIDTH*3/4, KHEIGHT, KWIDTH/4, 30);
}

@end
