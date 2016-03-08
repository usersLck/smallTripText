//
//  SearchDetailController.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/4.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "SearchDetailController.h"
#import <AFNetworking.h>
#import "TopScrollView.h"
#import "ScenicCell.h"
#import "DetailModel.h"
#import "TopReusableView.h"
#import "ScrollModel.h"
#import <MJRefresh.h>
#import "CityDetailController.h"

// 城市名称的网址
#define kCityUrl(countryId, page) [NSString stringWithFormat:@"http://open.qyer.com/place/city/get_city_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&countryid=%@&page=%ld&track_app_channel=App%%2520Store&track_app_version=6.8.4&track_device_info=iPhone7%%2C1&track_deviceid=FED00E7E-E233-473F-990B-32BF24E8AE4F&track_os=ios%%25209.2.1&v=1", countryId, page]

// 轮播图片网址
#define kScrollImageUrl(countryId) [NSString stringWithFormat:@"http://open.qyer.com/qyer/footprint/country_detail?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&country_id=%@&page=1&track_app_channel=App2520Store&track_app_version=6.8.4&track_device_info=iPhone72C1&track_deviceid=FED00E7E-E233-473F-990B-32BF24E8AE4F&track_os=ios25209.2.1&v=1", countryId]


@interface SearchDetailController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) TopReusableView *topView;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *totalArr;
@property(nonatomic, strong) ScrollModel *scrollModel;
@property (nonatomic, strong) UIButton *topButton;

@end

NSInteger page = 2;// 根据下拉次数去请求网络参数
NSString *countryId;// 判断是否是同一个国家id

@implementation SearchDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 获取轮播图片
    [self getScrollImage];
    // 获取城市景点数据
    [self requireDataWithCountryId:_contryid page:1];
    // 创建collectionview
    [self createCollectionView];
    // 添加上拉加载
    [self addFooterRefresh];
    // 添加返回顶部按钮
    [self addBackTop];
    
}

#pragma mark - 懒加载创建数组
- (NSMutableArray *)totalArr {
    if (!_totalArr) {
        self.totalArr = [NSMutableArray array];
    }
    return _totalArr;
}
#pragma mark - 请求城市数据
- (void)requireDataWithCountryId:(NSString *)countryId page:(NSInteger)page {
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    mager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mager GET:kCityUrl(countryId, page) parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self analysisData:responseObject page:(NSInteger)page];
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 城市数据解析
- (void)analysisData:(NSData *)data page:(NSInteger)page {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *arr = dict[@"data"];
    for (NSDictionary *dic in arr) {
        DetailModel *model = [[DetailModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.totalArr addObject:model];
    }
}

#pragma mark - 网络请求----获取轮播图片
- (void)getScrollImage {
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    mager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mager GET:kScrollImageUrl(self.contryid) parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self analysisScrollImageData:responseObject];
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 轮播图片获取解析
- (void)analysisScrollImageData:(NSData *)data {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *diction = dict[@"data"];
    ScrollModel *model = [[ScrollModel alloc] init];
    [model setValuesForKeysWithDictionary:diction];
    _scrollModel = model;
    ((TopScrollView *)_topView.subviews[0]).scrollModel = _scrollModel;
    _topView.scrollModel = _scrollModel;
}
#pragma mark - 创建collectionview
- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((KWIDTH)/3.4, (KHEIGHT)/4.3);
    layout.sectionInset = UIEdgeInsetsMake(KWIDTH/40, KWIDTH/40, KWIDTH/40, KWIDTH/40);
    layout.headerReferenceSize = CGSizeMake(KWIDTH, KHEIGHT*2/5);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT ) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[ScenicCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerClass:[TopReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.view addSubview:_collectionView];
    
}
#pragma mark - 返回按钮
- (void)doBack:(UIButton *)button {
    [_topView.scrollView.timer invalidate];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_totalArr.count > 18*(page - 1)) {
        return 18 * (page - 1);
    } else {
        return _totalArr.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ScenicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.detailModel = _totalArr[indexPath.item];
    return cell;
}

#pragma mark - collectionView头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    self.topView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    [_topView.backButton addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    return _topView;
}

#pragma mark - 下拉加载
- (void)addFooterRefresh {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSString *idString = self.contryid;
        if ([idString isEqualToString:countryId]) {
            page++;
        } else {
            page = 2;
        }
        [self requireDataWithCountryId:self.contryid page:page];
        countryId = self.contryid;
    }];
    self.collectionView.mj_footer = footer;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CityDetailController *cityDetailVc = [[CityDetailController alloc] init];
    cityDetailVc.cityId = ((DetailModel *)_totalArr[indexPath.item]).ID;
    cityDetailVc.imageUrl = ((DetailModel *)_totalArr[indexPath.item]).photo;
    [self.navigationController pushViewController:cityDetailVc animated:YES];
}

#pragma mark - 返回顶部
- (void)addBackTop {
    _topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_topButton setTitle:@"点击返回顶部" forState:UIControlStateNormal];
    _topButton.layer.cornerRadius = 5;
    _topButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _topButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _topButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    [_topButton addTarget:self action:@selector(doTop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topButton];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > KHEIGHT/2) {
        _topButton.frame = CGRectMake(KWIDTH-85, KHEIGHT-80, 85, 30);
    } else if (scrollView.contentOffset.y < KHEIGHT/2) {
        _topButton.frame = CGRectMake(KWIDTH*3/4, KHEIGHT, KWIDTH/4, 30);
    }
}
- (void)doTop:(UIButton *)button {
    _collectionView.contentOffset = CGPointMake(0, 0);
    _topButton.frame = CGRectMake(KWIDTH*3/4, KHEIGHT, KWIDTH/4, 30);
}

@end
