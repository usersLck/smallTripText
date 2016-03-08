//
//  AddDiaryCell.m
//  smallTrip
//
//  Created by 纪宇驰 on 16/2/24.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "AddDiaryCell.h"
#import "AddModuleController.h"
#import "CollectionViewCell.h"
#import "AddModuleCell.h"
#import "ImageCell.h"
#import "TextController.h"
#import "HeaderView.h"
#import "PlaceChoseController.h"

@interface AddDiaryCell ()<UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

{
//    NSInteger _sign; // 判断使用哪种cell的标志
    NSInteger _num; // 字典中元素个数
}



@property (nonatomic, strong)UICollectionViewFlowLayout *layout;

// 存储判断cell依据
@property (nonatomic, strong)NSMutableArray *signArr;

// 存储不同字典元素个数的数组
@property (nonatomic, strong)NSMutableArray * numberArr;

// 数据包字典
@property (nonatomic, strong)NSMutableDictionary *packetDict;

// 测试字典
@property (nonatomic, strong)NSMutableDictionary *testDict;


@end


@implementation AddDiaryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.layout = [[UICollectionViewFlowLayout alloc] init];
        self.layout.itemSize = CGSizeMake(KWIDTH/4, KWIDTH/4);
        self.layout.minimumLineSpacing = KWIDTH / 12;
        self.layout.minimumInteritemSpacing = 0;
        self.layout.sectionInset = UIEdgeInsetsMake(10, KWIDTH / 12, 0, KWIDTH / 12);
        
        // 设置分区头大小
        self.layout.headerReferenceSize = CGSizeMake(KWIDTH, KHEIGHT / 20);
        
        
        NSInteger height = [self calculateHeight];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, height) collectionViewLayout:self.layout];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.backgroundColor = [UIColor BACKCOLOR];
        
        
        [self.contentView addSubview:self.collectionView];
        [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"sum"];
        [self.collectionView registerClass:[AddModuleCell class] forCellWithReuseIdentifier:@"add"];
        [self.collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:@"image"];
        [self.collectionView registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        // 添加长按手势
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
        [self.collectionView addGestureRecognizer:longGesture];
        
    }
    
    return self;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    // 返回YES 允许Item移动
    
    return YES;
}


// 设置分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    if (_section == 0) {
//        return _section + 1;
//    }else{
//        return _section;
//    }
    return self.section;
    
}

//- (NSInteger)section{
//    if (!_section) {
//        self.section = 1;
//    }
//    return _section;
//}

// 设置每个分区的Item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ((self.sectionArr.count != 0) && (((NSDictionary *)self.sectionArr[section]).allKeys.count != 0)) {
        NSLog(@"%@", self.sectionArr);
        NSMutableDictionary *dict = self.sectionArr[section];
        return dict.count;
    }else{
        return 0;
    }
    
}

// 对collectionView的Cell进行设置
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 动态获取对应的数据源字典和标记数组
//    NSMutableDictionary *dict = self.sectionArr[indexPath.section];
//    NSMutableArray *arr = self.pointArr[indexPath.section];
    NSMutableDictionary *dict = self.sectionArr[indexPath.section];
    NSMutableArray *arr = self.pointArr[indexPath.section];
    // 做保护，如果取出的标记数组为nil，则返回的也是nil
    if (arr.count != 0) {
        // 取出对应的标记值点
        CGPoint point = ((NSValue *)arr[indexPath.row]).CGPointValue;
        // strX是cell类型标记
        NSString *strX = [NSString stringWithFormat:@"%d", (int)point.x];
        // strY是数据源字典中对应value的key
        NSString *strY = [NSString stringWithFormat:@"%d", (int)point.y];
        // 对cell类型进行判断
        if ([strX isEqualToString:@"0"]) {
            CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sum" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor cyanColor];
            cell.myLabel.text = dict[strY];
            return cell;
        }else{
            ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"image" forIndexPath:indexPath];
            cell.myImageV.image = dict[strY];
            return cell;
        }
    }else{
        return nil;
    }

}

// 设置分区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
        HeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        [view.placeNameButton setTitle:self.placeArr[indexPath.section] forState:UIControlStateNormal];
        view.placeNameButton.tag = indexPath.section + 1020;
        view.addButton.tag = indexPath.section + 1030;
        [view.addButton addTarget:self action:@selector(sendInform:) forControlEvents:UIControlEventTouchUpInside];
        [view.placeNameButton addTarget:self action:@selector(chosePlace:) forControlEvents:UIControlEventTouchUpInside];
        return view;
    }else{
        return nil;
    }

}

// 实现collectionView的Cell点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *arr = self.pointArr[indexPath.section];
    NSMutableDictionary *dict = self.sectionArr[indexPath.section];
    UIViewController *myVC = [self viewController];
    
    CGPoint point = ((NSValue *)arr[indexPath.row]).CGPointValue;
    NSString *strX = [NSString stringWithFormat:@"%d", (int)point.x];
    NSString *strY = [NSString stringWithFormat:@"%d", (int)point.y];
    
    if ([strX isEqualToString:@"0"]) {
        TextController *textC = [[TextController alloc] init];
        textC.text = dict[strY];
        textC.key = strY;
        [myVC.navigationController pushViewController:textC animated:YES];
    }else{
        
    }
}

#pragma mark - 实现collectionView重排的重要方法(拖动手势方法，修改数据源)
// 改动源数据 -- 最重要的一步
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSMutableArray *arr1 = [NSMutableArray arrayWithArray:self.pointArr[sourceIndexPath.section]];
    NSMutableArray *arr2 = [NSMutableArray arrayWithArray:self.pointArr[destinationIndexPath.section]];
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionaryWithDictionary:self.sectionArr[sourceIndexPath.section]];
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionaryWithDictionary:self.sectionArr[destinationIndexPath.section]];
    //取出源item数据
    CGPoint point1 = ((NSValue *)arr1[sourceIndexPath.row]).CGPointValue;
    NSString *str = [NSString stringWithFormat:@"%ld", (NSInteger)point1.y];
    id objc = [arr1 objectAtIndex:sourceIndexPath.row];
    id objc1 = [dict1 objectForKey:str];
    //从资源数组中移除该数据
    [arr1 removeObject:objc];
    [dict1 removeObjectForKey:str];
    //将数据插入到资源数组中的目标位置上
    [arr2 insertObject:objc atIndex:destinationIndexPath.row];
    [dict2 setObject:objc1 forKey:str];
    
    [self.pointArr removeObjectAtIndex:sourceIndexPath.section];
    [self.pointArr insertObject:arr1 atIndex:sourceIndexPath.section];
    
    [self.pointArr removeObjectAtIndex:destinationIndexPath.section];
    [self.pointArr insertObject:arr2 atIndex:destinationIndexPath.section];
    
    [self.sectionArr removeObjectAtIndex:sourceIndexPath.section];
    [self.sectionArr insertObject:dict1 atIndex:sourceIndexPath.section];
    [self.sectionArr removeObjectAtIndex:destinationIndexPath.section];
    [self.sectionArr insertObject:dict2 atIndex:destinationIndexPath.section];
    
    NSString *tableSection = [NSString stringWithFormat:@"%ld", self.sectionNum];
    NSDictionary *newSource = @{@"section":self.sectionArr, @"point":self.pointArr, @"tableSection":tableSection};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"alterSource" object:self userInfo:newSource];
    [collectionView reloadData];
    
    
}

// 实现手势方法，实现长按拖动cell
- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture{
    
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
            
            //判断手势落点位置是否在路径上
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            if (indexPath == nil) {
                break;
            }
            //在路径上则开始移动该路径上的cell
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
            //移动过程当中随时更新cell位置
            
            [self.collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectionView]];
            NSLog(@"移动中。。。");
            break;
            
        case UIGestureRecognizerStateEnded:
            //移动结束后关闭cell移动
            [self.collectionView endInteractiveMovement];
            NSLog(@"拖动结束");
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            
            break;
    }
    
}

#pragma mark - 一些按钮方法
// 点击加号按钮发送通知
- (void)sendInform:(UIButton *)button {
    for (int i = 0; i < _section + 1; i++) {
        if (button.tag == (1030 + i)) {
            NSString *tableSection = [NSString stringWithFormat:@"%ld", self.sectionNum];
            NSString *collectionSection = [NSString stringWithFormat:@"%d", i];
            NSDictionary *dict = @{@"collectionSection":collectionSection, @"tableSection":tableSection};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showAddModule" object:self userInfo:dict];
        }
    }
}


- (void)chosePlace:(UIButton *)button {
    
    for (int i = 0; i < _section + 1; i++) {
        if (button.tag == (1020 + i)) {
            // 跳转到选择地点页面
            NSString *row = [NSString stringWithFormat:@"%ld", self.sectionNum];
            NSDictionary *dict = @{@"section":row};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"position" object:self userInfo:dict];
        }
    }
}

#pragma mark - 一些set方法
@synthesize sectionArr = _sectionArr;
@synthesize pointArr = _pointArr;
- (void)setSectionArr:(NSMutableArray *)sectionArr {
    _sectionArr = sectionArr;
    NSLog(@"&&&%@", _sectionArr);
    [self.collectionView reloadData];
}

- (void)setPointArr:(NSMutableArray *)pointArr {
    _pointArr = pointArr;
    [self.collectionView reloadData];
}

// 计算collectionView高度
- (NSInteger)calculateHeight {
    
    NSInteger height = 0;
    if (_section > 0) {
        for (NSMutableDictionary *dict in self.sectionArr) {
            if (dict.count != 0) {
                height += (self.layout.itemSize.height + KWIDTH / 12) * (dict.count / 3 + 1);
            }
        }
    }else{
        height = KHEIGHT / 3;
    }
    NSString *heightStr = [NSString stringWithFormat:@"%ld", (long)(KHEIGHT / 15 * (_section + 1) + height)];
    NSDictionary *dict = @{@"height":heightStr};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"height" object:self userInfo:dict];
    return KHEIGHT / 15 * (_section + 1) + height;
}

#pragma mark - 寻找响应链上的controller 用来模态到新的界面
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)saveSourceDict {
    
    // 查找路径读取字典
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Travels" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    // 添加内容
    NSMutableArray *arrs = [NSMutableArray array];
    for (NSMutableDictionary *dic in self.sectionArr) {
        NSDictionary *dicc = [NSDictionary dictionaryWithDictionary:dic];
        [arrs addObject:dicc];
    }
    NSMutableArray *arr_1 = [NSMutableArray array];
    for (NSMutableArray *arr_2 in self.pointArr) {
        NSMutableArray *arr_3 = [NSMutableArray array];
        for (NSValue *value in arr_2) {
            NSString *pointStr = [NSString stringWithFormat:@"%@", value];
            [arr_3 addObject:pointStr];
        }
        NSArray *brr_1 = [NSArray arrayWithArray:arr_3];
        [arr_1 addObject:brr_1];
    }
    NSArray *bigPointArr = [NSArray arrayWithArray:arr_1];
    
    [data setObject:[NSArray arrayWithArray:arrs] forKey:@"sourceDict"];
    [data setObject:[NSArray arrayWithArray:bigPointArr] forKey:@"signArr"];
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:data];
    // 获取程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    // 获得完整文件名
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"Travels.plist"];
//    [dict writeToFile:fileName atomically:YES];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
        
        [dict writeToFile:fileName atomically:YES];
//        NSLog(@"文件写入完成");
    }
//    NSLog(@"%@", fileName);
    
//    NSDictionary *dict1 = [NSDictionary dictionaryWithContentsOfFile:fileName];
//    NSLog(@"%@", dict1);
    
}

#pragma mark - numberArr的懒加载
- (NSMutableArray *)numberArr {
    
    if (_numberArr) {
        self.numberArr = [NSMutableArray array];
    }
    
    return _numberArr;
}

#pragma mark - packetDict的懒加载

- (NSMutableDictionary *)packetDict {
    
    if (!_packetDict) {
        self.packetDict = [NSMutableDictionary dictionary];
    }
    return _packetDict;
}

- (NSMutableArray *)sectionArr {
    
    if (!_sectionArr) {
        self.sectionArr = [NSMutableArray array];
    }
    return _sectionArr;
}

- (NSMutableArray *)pointArr {
    
    if (!_pointArr) {
        self.pointArr = [NSMutableArray array];
    }
    return _pointArr;
}

- (NSMutableArray *)placeArr {
    
    if (!_placeArr) {
        self.placeArr = [NSMutableArray array];
    }
    return _placeArr;
    
}

- (void)awakeFromNib {
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
