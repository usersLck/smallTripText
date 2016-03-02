//
//  WeatherController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TourDetailController.h"

#import "WeatherController.h"
/*
#import "TabbarView.h"

#import "SearchWeatherController.h"

//#import "NetHandler.h"

#import "CityWeather.h"

#import "ShareButton.h"

#import "LineData.h"

#import "weatherDetail.h"

#import "WeatherCell.h"

#define kUrlAll @"http://aider.meizu.com/app/weather/listWeather?cityIds=101120101"
*/
//  天气主页
@interface WeatherController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain)NSMutableArray *array;

@property (nonatomic, retain)UITableView *table;

@property (nonatomic, assign)NSInteger type;

@property (nonatomic, assign)CGFloat initPoint;

@end

@implementation WeatherController
/*
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
    [self.table registerClass:[WeatherCell class] forCellReuseIdentifier:@"weatherCell"];
}

- (void)getData{
    [NetHandler getDataWithUrl:kUrlAll completion:^(NSData *data) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
        NSArray *arrays = dic[@"value"];
        for (NSDictionary *dic in arrays) {
            CityWeather *weather = [[CityWeather alloc] init];
            [weather setValuesForKeysWithDictionary:dic];
            [self.array addObject:weather];
            LineData *line = [[LineData alloc] initWithFrame:CGRectMake(10, KHEIGHT * 2 / 3 - TABBARHEIGHT, KWIDTH - 20, TABBARHEIGHT) andArray:((CityWeather *)self.array[0]).detailArray andType:1];
//            [self.view addSubview:line];
            for (int i = 0; i < line.topArray.count; i++) {
                WeatherDetail *detail = ((CityWeather *)self.array[0]).detailArray[i];
                NSRange range = NSMakeRange(11, 5);
                ((UILabel *)line.topArray[i]).text = [detail.startTime substringWithRange:range];
                ((UILabel *)line.secondArray[i]).text = detail.weather;
                NSInteger temp = (detail.highestTemperature + detail.lowerestTemperature) / 2;
                ((UILabel *)line.lastArray[i]).text = [NSString stringWithFormat:@"%ld", temp] ;
            }
            
        }
        [self.table reloadData];
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _initPoint = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%lf", scrollView.contentOffset.y - _initPoint);
    if ((scrollView.contentOffset.y - _initPoint) >= 100) {
        self.type = 1;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.type != 0) {
        scrollView.contentOffset = CGPointMake(0, 300);
        self.type = 0;
    }else{
        scrollView.contentOffset = CGPointMake(0, 0);
    }
    
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
        cell.array = ((CityWeather *)self.array[0]).detailArray;
    }
    
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
