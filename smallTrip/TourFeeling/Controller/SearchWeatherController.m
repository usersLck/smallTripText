//
//  SearchWeatherController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/30.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "SearchWeatherController.h"

#import "HistoryViewController.h"

#import "WeatherController.h"

#import <Accelerate/Accelerate.h>

//  天气搜索
@interface SearchWeatherController () <UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, retain)UITableView *table;

@property (nonatomic, retain)NSArray *array;

@property (nonatomic, retain)NSMutableArray *displayArray;

@property (nonatomic, retain)NSArray *sectionArray;

@property (nonatomic, retain)NSDictionary *dic;

@property (nonatomic, retain)NSMutableDictionary *displayDic;

@property (nonatomic, strong) NSMutableArray *historyArray;

@end

@implementation SearchWeatherController

- (NSArray *)array{
    if (!_array) {
        self.array = [NSMutableArray array];
    }
    return _array;
}

- (NSMutableArray *)historyArray {
    if (!_historyArray) {
        _historyArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _historyArray;
}

- (NSDictionary *)dic{
    if (!_dic) {
        self.dic = [NSDictionary dictionary];
    }
    return _dic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *weatherImage = [ user objectForKey:@"weatherImage"];
    UIImageView *view = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.image = [self blurryImage:[UIImage imageNamed:weatherImage] withBlurLevel:99];
    [self.view addSubview:view];
    self.navigationItem.title = @"天气搜索";
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, TABBARHEIGHT * 3 / 2, KWIDTH, KHEIGHT) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    _table.sectionIndexBackgroundColor = [UIColor clearColor];
    _table.sectionIndexColor = [UIColor whiteColor];
    [self.view addSubview:_table];
    self.table.backgroundColor = [UIColor clearColor];
    [self getData];
    [self setSearchController];
    
    HistoryViewController *historyVC = [[HistoryViewController alloc] init];
    historyVC.view.backgroundColor = [UIColor whiteColor];
    historyVC.tableView.delegate = self;
    [self addChildViewController:historyVC];
     
}

- (void)setSearchController {
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    [_searchController.searchBar sizeToFit];
    _searchController.searchBar.delegate = self;
    _table.tableHeaderView = _searchController.searchBar;
    [self.view addSubview:_searchController.searchBar];
    _table.rowHeight = 50;
    
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
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        for (NSString *key in self.dic) {
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *dics in self.dic[key]) {
                NSMutableDictionary *dicss = [NSMutableDictionary dictionary];
                if ([[dics allKeys][0] containsString: searchController.searchBar.text]) {
                    [dicss setObject:dics[[dics allKeys][0]] forKey:[dics allKeys][0]];
                    [arr addObject:dicss];
                }
            }
            if (arr.count) {
                [dic1 setObject:arr forKey:key];
            }
            
        }
        self.displayDic = [NSMutableDictionary dictionaryWithDictionary:dic1];
        self.displayArray = [[self.displayDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
        [self.table reloadData];
        NSLog(@"%@", self.displayDic);
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == ((HistoryViewController *)self.childViewControllers[0]).tableView) {
        self.searchController.searchBar.text = self.historyArray[indexPath.row];
    } else {
        WeatherController *weather = [self.navigationController viewControllers][2];
        NSArray *arr = [self.displayDic objectForKey:self.displayArray[indexPath.section]];
        NSDictionary *dic = arr[indexPath.row];
        weather.name = dic[[dic allKeys][0]];
        [self.navigationController popToViewController:weather animated:YES];
    }
}

- (void)getData{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cityList = [documents stringByAppendingPathComponent:@"city.plist"];
    self.dic = [NSDictionary dictionaryWithContentsOfFile:cityList];
    self.displayDic = [NSMutableDictionary dictionaryWithDictionary:self.dic];
    self.array = [[self.dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    self.displayArray = [NSMutableArray arrayWithArray:self.array];
}

- (NSString *)firstCharactor:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.displayArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = [self.displayDic objectForKey:self.displayArray[section]];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hehe"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hehe"];
    }
    cell.backgroundColor = [UIColor clearColor];
    NSArray *arr = [self.displayDic objectForKey:self.displayArray[indexPath.section]];
    NSDictionary *dic = arr[indexPath.row];
    cell.textLabel.text = [dic allKeys][0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:24];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.historyArray.count) {
        if (tableView == ((HistoryViewController *)self.childViewControllers[0]).tableView) {
            return 0;
        }
    }
    return 50;
    
}

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, KWIDTH, 30)];
    view.backgroundColor = [UIColor clearColor];
    view.layer.borderWidth = 1;
    view.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor blackColor]);
    [self.table addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH - 80, 20, 80, view.bounds.size.height)];
    label.text = self.displayArray[section];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:40];
    label.textColor = [UIColor blackColor];
    [view addSubview:label];
    return view;
}
*/

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.displayArray;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.displayArray[section];
}

- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       &outBuffer,
                                       NULL,
                                       0,
                                       0,
                                       boxSize,
                                       boxSize,
                                       NULL,
                                       kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
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
