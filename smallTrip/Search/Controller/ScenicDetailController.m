//
//  ScenicDetailController.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/6.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "ScenicDetailController.h"
#import "DetailCell.h"
#import "ScenicDetailModel.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "RootTabBarViewController.h"

// 景点详情网址
#define kDetailUrl(string) [NSString stringWithFormat:@"http://open.qyer.com/qyer/footprint/poi_detail?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&page=1&poi_id=%@&screensize=1242&track_app_channel=App%%2520Store&track_app_version=6.8.4&track_device_info=iPhone7%%2C1&track_deviceid=FED00E7E-E233-473F-990B-32BF24E8AE4F&track_os=ios%%25209.2.1&v=1", string]

@interface ScenicDetailController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ScenicDetailModel *detailModel;
@property (nonatomic, strong) UIButton *backButton;

@end

CGFloat offsetY;

@implementation ScenicDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self createTableView];
    [self requireDataWithString:self.scenicId];
    [self createBackButton];
}

#pragma mark - 网络请求
- (void)requireDataWithString:(NSString *)string {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:kDetailUrl(string) parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject[@"data"];
        ScenicDetailModel *model = [[ScenicDetailModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        _detailModel = model;
        _tableView.tableHeaderView = [self headerView];
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 创建tableview
- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT - 49) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[DetailCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}

#pragma mark - tableview头视图
- (UIView *)headerView {
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT*1.5/4)];
    [_imageV sd_setImageWithURL:[NSURL URLWithString:_detailModel.photo]];
    return _imageV;
}
- (void)createBackButton {
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(KWIDTH/41, 25, 30, 30);
    [_backButton setBackgroundImage:[UIImage imageNamed:@"Secondback"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(doback:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
}
#pragma mark - 返回上一级的方法
- (void)doback:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableViewDataSource数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.detailModel = _detailModel;
    return cell;
}

#pragma mark - UITableViewDelegate代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_detailModel) {
        NSArray *arr = @[_detailModel.introduction, _detailModel.address, _detailModel.wayto, _detailModel.opentime, _detailModel.price, _detailModel.tips];
        CGFloat height = 0;
        for (int i = 0 ; i < arr.count; i++) {
            CGRect rect = [arr[i] boundingRectWithSize:CGSizeMake(KWIDTH - KWIDTH/20, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
            height += rect.size.height;
        }
        return height + 430;
    } else {
        return KHEIGHT;
    }
}



@end
