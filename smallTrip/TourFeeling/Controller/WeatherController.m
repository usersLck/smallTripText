//
//  WeatherController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TourDetailController.h"

#import "WeatherController.h"

#import "TabbarView.h"

#import "SearchWeatherController.h"

#import "NetHandler.h"

#import "CityWeather.h"

#import "CityPollute.h"

#import "ShareButton.h"

#import "LineData.h"

#import "weatherDetail.h"

#import "WeatherCell.h"

#define kUrlAll @"http://aider.meizu.com/app/weather/listWeather?cityIds=%@"

//  天气主页
@interface WeatherController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain)NSMutableArray *array;

@property (nonatomic, retain)UITableView *table;

@property (nonatomic, assign)NSInteger type;

@property (nonatomic, assign)CGFloat initPoint;

@end

@implementation WeatherController

- (void)setName:(NSString *)name{
    _name = [NSString stringWithFormat:kUrlAll, name];
    
    [self getData];
}

- (NSMutableArray *)array{
    if (!_array) {
        self.array = [NSMutableArray array];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"天气";
    
    [self CreateTabButton];
    
    [self CreateView];

}

- (void)CreateView{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"首页" style:UIBarButtonItemStyleDone target:self action:@selector(returnIndex:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT - TABBARHEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:_table];
    self.table.dataSource = self;
    self.table.delegate = self;
    self.table.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.table registerClass:[WeatherCell class] forCellReuseIdentifier:@"weatherCell"];
}

- (void)getData{
    if (!self.name) {
        self.name = @"101010100";
    }
    [NetHandler getDataWithUrl:self.name completion:^(NSData *data) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
        NSArray *arrays = dic[@"value"];
        for (NSDictionary *dic in arrays) {
            CityWeather *weather = [[CityWeather alloc] init];
            [weather setValuesForKeysWithDictionary:dic];
            [self.array addObject:weather];
        }
        if (!((CityWeather *)[self.array lastObject]).city) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请求失败" message:@"很抱歉您搜索的地区没有详细天气请重新选择" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }else{
            [self.table reloadData];
        }
        
    }];
}

- (void)returnIndex:(UIBarButtonItem *)sender{
    [self.navigationController popToViewController:[self.navigationController viewControllers][1] animated:YES];
}

- (void)CreateTabButton{
    
    TabbarView *tabView = [[TabbarView alloc] initWithFrame:CGRectMake(0, KHEIGHT - TABBARHEIGHT, KWIDTH, TABBARHEIGHT) andDelegate:self];
    [self.view addSubview:tabView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weatherCell" forIndexPath:indexPath];
    
    if(self.array.count){
        CityWeather *cityWeather = [self.array lastObject];
        cell.array = cityWeather.detailArray;
        cell.weekArray = ((CityWeather *)[self.array lastObject]).weatherArray;
        cell.cityNameLabel.text = cityWeather.city;
        cell.qualityLabel.text = cityWeather.pollute.aqi;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KHEIGHT * 2 - TABBARHEIGHT;
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
