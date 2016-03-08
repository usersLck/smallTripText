//
//  StrategyListController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/2/2.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "StrategyListController.h"

#import "HistoryViewController.h"

#import "travelNotesCell.h"


#import <AFNetworking.h>




//  攻略集锦
@interface StrategyListController ()<UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic, retain)UITableView *table;

@property (nonatomic, retain)UISearchController *searchController;

@property (nonatomic, retain)NSMutableArray *historyArray;

@end

@implementation StrategyListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"攻略集锦";
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT - TABBARHEIGHT * 3 /2) style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self setSearchController];
    self.table.rowHeight = 300;
    HistoryViewController *historyVC = [[HistoryViewController alloc] init];
    historyVC.view.backgroundColor = [UIColor whiteColor];
    historyVC.tableView.delegate = self;
    [self addChildViewController:historyVC];
    [self.table registerClass:[travelNotesCell class] forCellReuseIdentifier:@"travelNotes"];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(image:)];
    self.navigationItem.rightBarButtonItem = button;
}

- (void)image:(UIButton *)button{
    UIImageView *images = [[UIImageView alloc ]initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:images];
    
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    mager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    mager.requestSerializer = [AFJSONRequestSerializer serializer];
    mager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    [mager.requestSerializer setValue:@"multipart/form-data; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString *path = @"/Users/liuchangkai/smallTripText/smallTrip/Resources/1.jpg";
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *imagestr64 = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSData *das = [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSInteger k = 0;
    /*
    for (int i = 0; i < 2; i++) {
        NSInteger j = imagestr64.length / 50;
        NSRange range = NSMakeRange(0, 0);
        k = i * j;
        if (i == 49) {
            range = NSMakeRange(k, imagestr64.length - k);
        }else{
            range = NSMakeRange(i * j , j);
        }
        [parameters setObject:[imagestr64 substringWithRange:range] forKey:[NSString stringWithFormat:@"fileName%d", i]];
    }
    */
//    NSLog(@"%@", parameters);
    [parameters setObject:imagestr64 forKey:@"fileName"];
//     [parameters setObject:imagestr64 forKey:@"type"];
    /*
    [mager POST:@"http://10.80.12.36:8080/text/travels" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *path = @"/Users/liuchangkai/smallTripText/smallTrip/Resources/1.mov";
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSData *das = [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [formData appendPartWithFileData:das name:@"fileName" fileName:@"video1.mov" mimeType:@"video/quicktime"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败 %@", error);
    }];
    */
    /*
    [mager POST:@"http://192.168.1.107:8080/text/travels1" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败 %@", error);
    }];
    */
    
     [mager POST:@"http://192.168.1.107:8080/text/travels1" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
     
     NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"cloudy11"], 0.5);
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
     formatter.dateFormat = @"yyyyMMddHHmmss";
     NSString *str = [formatter stringFromDate:[NSDate date]];
     NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
     
     NSString *name = @"shenme";
     
     [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/png"];
     NSLog(@"forma %@", formData);
     } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     NSLog(@"成功%@", responseObject);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     NSLog(@"失败 %@", error);
     }];
    
    
    /*
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil nil];
    // 参数
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"token"] = @"param";
    // 访问路径
    NSString *stringURL = [NSString stringWithFormat:@"%@%@",HOSTURL,kUploadAvatar];
    
    [manager POST:stringURL parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 上传文件
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"上传成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传错误");
    }];
    */
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    travelNotesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"travelNotes"];
    
    if (indexPath.row == 0) {
        cell.travelNotesTitle.text = @"逛吃逛吃香港与功夫之王梁小龙的庙街之缘";
        cell.travelBeginDate.text = @"2016.02.01";
        cell.travelDays.text = @"14天";
        cell.readingNumbers.text = @"1364次浏览";
        cell.travelDestination.text = @"香港";
        cell.touristName.text = @"by嘿咔噜";
        cell.travelImage.image = [UIImage imageNamed:@"cloudy11"];
    }else if (indexPath.row == 1){
        cell.travelNotesTitle.text = @"丝路：帝国之掖河西走廊";
        cell.travelBeginDate.text = @"2015.08.27";
        cell.travelDays.text = @"9天";
        cell.readingNumbers.text = @"1193次浏览";
        cell.travelDestination.text = @"中国.酒泉";
        cell.touristName.text = @"byHelloJason2010";
        cell.travelImage.image = [UIImage imageNamed:@"camel"];
    }else if (indexPath.row == 2){
        cell.travelNotesTitle.text = @"單車環島記--2/3的台灣";
        cell.travelBeginDate.text = @"2016.01.29";
        cell.travelDays.text = @"16天";
        cell.readingNumbers.text = @"7833次浏览";
        cell.travelDestination.text = @"台湾";
        cell.touristName.text = @"by吃饼干的小黄人";
        cell.travelImage.image = [UIImage imageNamed:@"taiwan"];
    }else{
        cell.travelNotesTitle.text = @"走在墨尔本的阳光下";
        cell.travelBeginDate.text = @"2016.02.03";
        cell.travelDays.text = @"11天";
        cell.readingNumbers.text = @"7938次浏览";
        cell.travelDestination.text = @"澳大利亚Pearcedale";
        cell.touristName.text = @"byStephanie12";
        cell.travelImage.image = [UIImage imageNamed:@"australia"];
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
    _searchController.searchBar.showsSearchResultsButton = YES;
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
