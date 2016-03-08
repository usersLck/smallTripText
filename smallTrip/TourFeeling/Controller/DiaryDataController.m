//
//  DiaryDataController.m
//  smallTrip
//
//  Created by 纪宇驰 on 16/2/16.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "DiaryDataController.h"
#import "AddDiaryCell.h"
#import "TextController.h"
#import "TravelsImageController.h"
#import "RootTabBarViewController.h"
#import "PlaceChoseController.h"
#import "CoverImageView.h"
#import "FXLabel.h"



@interface DiaryDataController ()<UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSInteger _num;
    NSInteger _section;
}

// -------------数据源设置-----------------
@property (nonatomic, strong)NSMutableDictionary *totalDict;
@property (nonatomic, strong)NSMutableArray *sectionArr;
@property (nonatomic, strong)NSMutableArray *markArr;
@property (nonatomic, strong)NSMutableArray *placeArr;
@property (nonatomic, assign)NSInteger tableSection;
// ---------------------------------------
@property (nonatomic, assign)NSInteger height;

@property (nonatomic, strong)UITableView *tableView;

// 封面选择
@property (nonatomic, strong)CoverImageView *coverImageV;

// 存储collectionView分区数的数组
@property (nonatomic, strong)NSMutableArray *numArr;
// 模块选择View
@property (nonatomic, strong)UIView *choseModuleView;
// 传递section
@property (nonatomic, strong)NSString *collectionSection;
// 传递日期
@property (nonatomic, strong)NSString *everyDate;

// 整体数据源
@property (nonatomic, strong)NSMutableArray *travelsSourceArr;
// 当前游记数据
@property (nonatomic, strong)NSMutableDictionary *sourceDict;


@end
// 游记编辑页面
@implementation DiaryDataController

- (void)viewWillAppear:(BOOL)animated {
    // 隐藏tabBar
    ((RootTabBarViewController *)self.tabBarController).tabBarView.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    // 显示tabBar
    ((RootTabBarViewController *)self.tabBarController).tabBarView.hidden = NO;
    [self.view sendSubviewToBack:self.choseModuleView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"编辑游记";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showModule:) name:@"showAddModule" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addItemNum:) name:@"addNum" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addImageCell:) name:@"image" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(amendCell:) name:@"amend" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPlace:) name:@"place" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(choseMyPlace:) name:@"position" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alterSource:) name:@"alterSource" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRowHeight:) name:@"height" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(coverImageSave:) name:@"coverImage" object:nil];
    
    
    UIBarButtonItem *saveTravelsButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveTravels:)];
    self.navigationItem.rightBarButtonItem = saveTravelsButtonItem;
    
    [self creatModuleChoseView];
    [self creatSource];
    [self creatTableView];
    
}

#pragma mark - UITableViewDelegate方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger num = [self.numOfRow integerValue];
    
    return num;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AddDiaryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"register" forIndexPath:indexPath];
    NSMutableArray *sectionArray = [NSMutableArray arrayWithArray:self.sectionArr[indexPath.section]];
    NSMutableArray *pointArr = [NSMutableArray arrayWithArray:self.markArr[indexPath.section]];
    NSMutableArray *placeArr = [NSMutableArray arrayWithArray:self.placeArr[indexPath.section]];
    NSNumber *num = self.numArr[indexPath.section];
    NSInteger collectionNum = [num integerValue];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.sectionNum = indexPath.section;
    cell.sectionArr = sectionArray;
    cell.placeArr = placeArr;
//    NSLog(@"^^^%@", sectionArray);
    cell.pointArr = pointArr;
    cell.section = collectionNum;
//    NSLog(@"xxxxxxx%ld", collectionNum);
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 这里需要自适应高度，根据collectionview的高度来判断，collectionview的高度根据item的高度和上下间隙的宽度来计算，item的个数是从当前的controller来获取的，
    if (self.height < KHEIGHT / 3) {
        return KHEIGHT / 3;
    }else{
        return self.height;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT / 20)];
    view.backgroundColor = [UIColor BACKCOLOR];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH / 40, 0, KWIDTH / 20 * 19, KHEIGHT / 20)];
    label.backgroundColor = [UIColor BACKCOLOR];
    label.text = [NSString stringWithFormat:@"Day %ld", section + 1];
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];
    return view;
}


- (void)creatTableView {
    
    self.coverImageV = [[CoverImageView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT / 4)];
    self.coverImageV.titleLabel.text = @"点击选择游记封面";
    self.coverImageV.secondTitleLabel.text = @"为你的游记选择一个漂亮的封面吧！";
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH,KHEIGHT) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor BACKCOLOR];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = KHEIGHT / 3;
    self.tableView.tableHeaderView = self.coverImageV;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[AddDiaryCell class] forCellReuseIdentifier:@"register"];
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return KHEIGHT / 20;
}

// 设置行数
- (void)setNumOfRow:(NSString *)numOfRow {
    
    _numOfRow = numOfRow;
    [self.tableView reloadData];
    
}

// 设置日期
//- (void)setDays:(NSString *)days {
//    _days = days;
//    
//    NSArray *arr = [days componentsSeparatedByString:@"-"];
//    
//    
//}



// 创建模块选择View
- (void)creatModuleChoseView {
    
    self.choseModuleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
    self.choseModuleView.backgroundColor = [UIColor grayColor];
    self.choseModuleView.alpha = 0.9;
    NSArray *pictureArr = @[@"textAdd", @"pictureAdd"];
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(KWIDTH / 9 + KWIDTH / 9 * 4 * i, KHEIGHT / 3, KWIDTH / 3, KWIDTH / 3);
        button.tag = 1010 + i;
        button.backgroundColor = [UIColor clearColor];
        button.layer.cornerRadius = KWIDTH / 12;
        button.alpha = 1;
        [button setImage:[UIImage imageNamed:pictureArr[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(enterNexPage:) forControlEvents:UIControlEventTouchUpInside];
        [self.choseModuleView addSubview:button];
    }
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(KWIDTH / 5 * 2, KHEIGHT / 3 * 2, KWIDTH / 5, KHEIGHT / 20);
    cancelButton.backgroundColor = [UIColor grayColor];
    [cancelButton setTitle:@"取 消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAdd:) forControlEvents:UIControlEventTouchUpInside];
    [self.choseModuleView addSubview:cancelButton];
    
    
    [self.view addSubview:self.choseModuleView];
 
}

// 取消选择模块页面，回到游记编辑页面
- (void)cancelAdd:(UIButton *)button {
    
    [self.view sendSubviewToBack:self.choseModuleView];

}



// 进入模块编辑页面
- (void)enterNexPage:(UIButton *)button {
    
    if (button.tag == 1010) {
        TextController *TVC = [[TextController alloc] init];
        TVC.section = self.collectionSection;
        [self.navigationController pushViewController:TVC animated:YES];
    }else if (button.tag == 1011){
        UIImagePickerController *imagePickerC = [[UIImagePickerController alloc] init];
        // 设置图片来源
        imagePickerC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerC.delegate = self;
        imagePickerC.allowsEditing = YES;
        [self.navigationController presentViewController:imagePickerC animated:YES completion:nil];
    }else{
        
    }
}

- (void)saveTravels:(UIBarButtonItem *)item {
    
    [self saveSourceDictToLocalize];
    
}


#pragma mark - 实现通知方法
- (void)addItemNum:(NSNotification *)notification {
    
    // 添加区分cell类型的标记
    NSMutableArray *sectionArray = self.sectionArr[self.tableSection];
    NSMutableArray *pointArr = self.markArr[self.tableSection];
    // 添加cell个数
    _num += 1;
    // 获取外界传来的文本
    NSString *str = notification.userInfo[@"text"];
    // 设置key
    NSString *key = [NSString stringWithFormat:@"%ld", _num];
    // 将文本和对应key添加到数据源字典中
    NSInteger section = [notification.userInfo[@"section"] integerValue];
    
    NSMutableDictionary *dict = sectionArray[section];
    [dict setObject:str forKey:key];
//    NSLog(@"trueSection:%ld", section);
//    NSLog(@"%@,%@", str, key);
//    NSLog(@"dict:%@", sectionArray);

    // 设置位置标记和类型标记的数组
    NSInteger sign = [notification.userInfo[@"sign"] integerValue];
    CGPoint point = CGPointMake(sign, _num);
    // 在数组中添加值对(CGPoint类型)，要注意CGPoint添加到数组中必须是NSValue类型
    NSMutableArray *arr = pointArr[section];
    [arr addObject:[NSValue valueWithCGPoint:point]];
    [self.tableView reloadData];
    
}

- (void)addImageCell:(NSNotification *)notification {
    // 此方法原理同上

    NSMutableArray *sectionArray = self.sectionArr[self.tableSection];
    NSMutableArray *pointArr = self.markArr[self.tableSection];
    _num += 1;
    UIImage *image = notification.userInfo[@"image"];
    if (image != nil) {
        NSString *key = [NSString stringWithFormat:@"%ld", _num];
        NSInteger section = [notification.userInfo[@"section"] integerValue];
        NSMutableDictionary *dict = sectionArray[section];
        [dict setObject:image forKey:key];

        // 设置位置标记和类型标记的数组
        NSInteger sign = [notification.userInfo[@"sign"] integerValue];
        CGPoint point = CGPointMake(sign, _num);
        NSMutableArray *arr = pointArr[section];
        [arr addObject:[NSValue valueWithCGPoint:point]];
        [self.tableView reloadData];
        
    }
    
}


- (void)amendCell:(NSNotification *)notification{
    // 此观察者方法是用来修改对应cell中的内容，并不需要增加数据源字典中的数据
    NSInteger tableSectionNow = [notification.userInfo[@"section"] integerValue];
    NSMutableArray *sectionArray = self.sectionArr[tableSectionNow];
    NSString *key = notification.userInfo[@"key"];
    NSString *text = notification.userInfo[@"text"];
    NSInteger section = [notification.userInfo[@"section"] integerValue];
    NSMutableDictionary *dict = sectionArray[section];
    [dict setObject:text forKey:key];
    [self.tableView reloadData];
    
}

- (void)getPlace:(NSNotification *)notification {
    
    NSInteger tableSectionNum = [notification.userInfo[@"section"] integerValue];
    
    
    
    NSMutableArray *sectionArray = self.sectionArr[tableSectionNum];
    NSMutableArray *pointArr = self.markArr[tableSectionNum];
    
    NSNumber *num = self.numArr[tableSectionNum];
    NSInteger collectionNum = [num integerValue];
    collectionNum += 1;
    NSNumber *newNum = [NSNumber numberWithInteger:collectionNum];

    NSString *placeName = notification.userInfo[@"place"];
    NSMutableArray *collectionPlaceArr = self.placeArr[tableSectionNum];
    [collectionPlaceArr insertObject:placeName atIndex:collectionNum - 2];
    [self.placeArr removeObjectAtIndex:tableSectionNum];
    [self.placeArr insertObject:collectionPlaceArr atIndex:tableSectionNum];
    
    [self.numArr removeObjectAtIndex:tableSectionNum];
    [self.numArr insertObject:newNum atIndex:tableSectionNum];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [sectionArray addObject:dict];
    NSMutableArray *arr = [NSMutableArray array];
    [pointArr addObject:arr];
//    NSLog(@"sectionArr:%@", sectionArray);

    [self.tableView reloadData];
    
}

- (void)alterSource:(NSNotification *)notification {
    
    NSInteger sectionNow = [notification.userInfo[@"tableSection"] integerValue];
    NSMutableArray *newSectionArr = [NSMutableArray arrayWithArray:notification.userInfo[@"section"]];
    NSMutableArray *pointNow = [NSMutableArray arrayWithArray:notification.userInfo[@"point"]];
    
    [self.sectionArr removeObjectAtIndex:sectionNow];
    [self.markArr removeObjectAtIndex:sectionNow];
    [self.sectionArr insertObject:newSectionArr atIndex:sectionNow];
    [self.markArr insertObject:pointNow atIndex:sectionNow];
    
    [self.tableView reloadData];
    
}

// 展示模块选择页面
- (void)showModule:(NSNotification *)notification {
    NSInteger tableSection = [notification.userInfo[@"tableSection"] integerValue];
    self.tableSection = tableSection;
    self.collectionSection = notification.userInfo[@"collectionSection"];
    [self.view bringSubviewToFront:self.choseModuleView];
    
}

// 接收通知传过来的值来给tableView的rowHeight赋值
- (void)updateRowHeight:(NSNotification *)notification {
    
    NSInteger num = [notification.userInfo[@"height"] integerValue];
    
    self.height = num;
    [self.tableView reloadData];
}


#pragma mark - 存储数据到本地
- (void)saveSourceDictToLocalize {
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Travels" ofType:@"plist"];
    NSMutableArray *data = [NSMutableArray arrayWithContentsOfFile:plistPath];

    // 地点
    NSMutableArray *transitPlaceArr = [NSMutableArray arrayWithArray:self.placeArr];
    NSMutableArray *newPlaceArr = [NSMutableArray array];
    for (NSMutableArray *arr in transitPlaceArr) {
        [arr removeLastObject];
        NSMutableArray *arr1 = [NSMutableArray array];
        for (NSString *place in arr) {
            [arr1 addObject:place];
        }
        NSArray *arr2 = [NSArray arrayWithArray:arr1];
        [newPlaceArr addObject:arr2];
    }
    NSArray *finalPlaceArr = [NSArray arrayWithArray:newPlaceArr];
    
    // 内容
    NSMutableArray *transitSectionArr = [NSMutableArray arrayWithArray:self.sectionArr];
    NSMutableArray *totalSectionArr = [NSMutableArray array];
    for (NSMutableArray *tableSectionArr in transitSectionArr) {
        NSMutableArray *newTableSectionArr = [NSMutableArray array];
        for (NSMutableDictionary *collectionDict in tableSectionArr) {
            NSMutableDictionary *newCollectionDict = [NSMutableDictionary dictionary];
            for (NSString *key in collectionDict) {
                if ([key isEqualToString:@"0"]) {
                    NSData *imageData = UIImageJPEGRepresentation(collectionDict[key], 1.0);
                    [newCollectionDict setObject:imageData forKey:key];
                }else{
                    [newCollectionDict setObject:collectionDict[key] forKey:key];
                }
            }
            NSDictionary *finalcollectionDict = [NSDictionary dictionaryWithDictionary:newCollectionDict];
            [newTableSectionArr addObject:finalcollectionDict];
        }
        NSArray *finalTableSectionArr = [NSArray arrayWithArray:newTableSectionArr];
        [totalSectionArr addObject:finalTableSectionArr];
    }
    NSArray *finalTotalSectionArr = [NSArray arrayWithArray:totalSectionArr];
    // 标记&类型
    NSMutableArray *transitMarkArr = [NSMutableArray arrayWithArray:self.markArr];
    NSMutableArray *totalPointArr = [NSMutableArray array];
    for (NSMutableArray *tablePointArr in transitMarkArr) {
        NSMutableArray *arr_1 = [NSMutableArray array];
        for (NSMutableArray *arr_2 in tablePointArr) {
            NSMutableArray *arr_3 = [NSMutableArray array];
            for (NSValue *value in arr_2) {
                NSString *pointStr = [NSString stringWithFormat:@"%@", value];
                [arr_3 addObject:pointStr];
            }
            NSArray *brr_1 = [NSArray arrayWithArray:arr_3];
            [arr_1 addObject:brr_1];
        }
        NSArray *bigPointArr = [NSArray arrayWithArray:arr_1];
        [totalPointArr addObject:bigPointArr];
    }
    NSArray *finalPointArr = [NSArray arrayWithArray:totalPointArr];
    
    
    
    [self.sourceDict setObject:finalTotalSectionArr forKey:@"sourceDict"];
    [self.sourceDict setObject:finalPointArr forKey:@"signArr"];
    [self.sourceDict setObject:finalPlaceArr forKey:@"place"];
    [self.sourceDict setObject:self.travelsTitle forKey:@"title"];
    [self.sourceDict setObject:self.secondTitle forKey:@"secondTitle"];
    [self.sourceDict setObject:self.days forKey:@"allDays"];
    [self.sourceDict setObject:self.beginDate forKey:@"beginDate"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.sourceDict];
    
    [self.travelsSourceArr addObject:dict];
    NSArray *bigArrNow = [NSArray arrayWithArray:self.travelsSourceArr];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    // 获得完整文件名
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"Travels.plist"];
    [bigArrNow writeToFile:fileName atomically:YES];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
        
        [dict writeToFile:fileName atomically:YES];
        //        NSLog(@"文件写入完成");
    }
        NSLog(@"%@", fileName);
    
        NSArray *myPlaceArr = [NSArray arrayWithContentsOfFile:fileName];
        NSLog(@"%@", myPlaceArr);
    
    
}


#pragma mark - 创建数据源
- (void)creatSource {
    
    NSInteger days = [self.numOfRow integerValue];
    for (int i = 0; i < days; i++) {
        NSMutableArray *sectionArr = [NSMutableArray array];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [sectionArr addObject:dict];
        [self.sectionArr addObject:sectionArr];

        NSMutableArray *pointArr = [NSMutableArray array];
        NSMutableArray *arr = [NSMutableArray array];
        [pointArr addObject:arr];
        [self.markArr addObject:pointArr];

        NSMutableArray *collectionPlaceArr = [NSMutableArray array];
        NSString *place = @"点击添加景点";
        [collectionPlaceArr addObject:place];
        [self.placeArr addObject:collectionPlaceArr];

        NSInteger collectionSection = 1;
        NSNumber *num = [NSNumber numberWithInteger:collectionSection];
        [self.numArr addObject:num];

    }
}

- (void)choseMyPlace:(NSNotification *)notification {
    NSInteger str = [notification.userInfo[@"section"] integerValue];
    
    PlaceChoseController *PCVC = [[PlaceChoseController alloc] init];
    PCVC.sectionNum = str;
    [self.navigationController pushViewController:PCVC animated:YES];
    
}

// 储存封面
- (void)coverImageSave:(NSNotification *)notification {
    UIImage *image = notification.userInfo[@"image"];
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    [self.sourceDict setObject:imageData forKey:@"coverImage"];
    self.coverImageV.titleLabel.text = self.travelsTitle;
    self.coverImageV.secondTitleLabel.text = self.secondTitle;
    self.coverImageV.secondTitleLabel.textColor = [UIColor whiteColor];
    [self.tableView reloadData];
    
}


#pragma mark - UIImagePickerControllerDelegate方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 获取系统相册照片
    // 这个image可以用于给外界传值
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    TravelsImageController *TIVC = [[TravelsImageController alloc] init];
    TIVC.image = image;
    TIVC.section = self.collectionSection;
    [self.navigationController pushViewController:TIVC animated:YES];
    
}


#pragma mark - 数据源数组、字典的懒加载

- (NSMutableDictionary *)totalDict {
    
    if (!_totalDict) {
        self.totalDict = [NSMutableDictionary dictionary];
    }
    return _totalDict;
    
}


- (NSMutableArray *)sectionArr {
    
    if (!_sectionArr) {
        self.sectionArr = [NSMutableArray array];
    }
    return _sectionArr;
    
}

- (NSMutableArray *)markArr {
    
    if (!_markArr) {
        self.markArr = [NSMutableArray array];
    }
    return _markArr;
    
}

- (NSMutableArray *)numArr {
    
    if (!_numArr) {
        self.numArr = [NSMutableArray array];
    }
    return _numArr;
    
}

- (NSMutableArray *)placeArr {
    
    if (!_placeArr) {
        self.placeArr = [NSMutableArray array];
    }
    return _placeArr;
    
}

- (NSMutableArray *)travelsSourceArr {
    
    if (!_travelsSourceArr) {
        self.travelsSourceArr = [NSMutableArray array];
    }
    return _travelsSourceArr;
    
}

- (NSMutableDictionary *)sourceDict {
    
    if (!_sourceDict) {
        self.sourceDict = [NSMutableDictionary dictionary];
    }
    return _sourceDict;
    
}

#pragma mark - 移除通知观察者
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showAddModule" object:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
