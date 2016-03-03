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



@interface AddDiaryCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

{
    NSInteger _sign; // 判断使用哪种cell的标志
    NSInteger _num; // 字典中元素个数
}



@property (nonatomic, strong)UICollectionViewFlowLayout *layout;

// 存储判断cell依据
@property (nonatomic, strong)NSMutableArray *signArr;

// 数据源字典
//@property (nonatomic, strong)NSMutableDictionary *sourcrDict;

// 存储cell类型和顺序的数组
@property (nonatomic, strong)NSMutableArray *pointArr;

// 存储不同section数据源字典的数组
@property (nonatomic, strong)NSMutableArray *sectionArr;

// 存储不同字典元素个数的数组
@property (nonatomic, strong)NSMutableArray * numberArr;

// 数据包字典
@property (nonatomic, strong)NSMutableDictionary *packetDict;

// 存储数据包字典的数组
@property (nonatomic, strong)NSMutableArray *sourceArr;

@end


@implementation AddDiaryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        // 注册成为观察者
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addItemNum:) name:@"addNum" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addImageCell:) name:@"image" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(amendCell:) name:@"amend" object:nil];
        [self creatSectionArr];
        self.layout = [[UICollectionViewFlowLayout alloc] init];
        self.layout.itemSize = CGSizeMake(KWIDTH/4, KWIDTH/4);
        self.layout.minimumLineSpacing = KWIDTH / 12;
        self.layout.minimumInteritemSpacing = 0;
        self.layout.sectionInset = UIEdgeInsetsMake(10, KWIDTH / 12, 0, KWIDTH / 12);
        NSInteger height = [self calculateHeight];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, height) collectionViewLayout:self.layout];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        
        [self.contentView addSubview:self.collectionView];
        [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"sum"];
        [self.collectionView registerClass:[AddModuleCell class] forCellWithReuseIdentifier:@"add"];
        [self.collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:@"image"];
        
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

#warning source -- 数据源没改变
// 改动源数据 -- 最重要的一步
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSMutableArray *arr1 = self.pointArr[sourceIndexPath.section];
    NSMutableArray *arr2 = self.pointArr[destinationIndexPath.section];
    NSMutableDictionary *dict1 = self.sectionArr[sourceIndexPath.section];
    NSMutableDictionary *dict2 = self.sectionArr[destinationIndexPath.section];
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
    [collectionView reloadData];
 
}

// 设置分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionArr.count;
}

// 设置每个分区的Item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSMutableDictionary *dict = self.sectionArr[section];
    
    return dict.count + 1;
}

// 对collectionView的Cell进行设置
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 动态获取对应的数据源字典和标记数组
    NSMutableDictionary *dict = self.sectionArr[indexPath.section];
    NSMutableArray *arr = self.pointArr[indexPath.section];
    // 判断第几个cell
    if (indexPath.row == dict.count) {
        AddModuleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"add" forIndexPath:indexPath];
        return cell;
    }else{
        // 做保护，如果取出的标记数组为nil，则返回的也是nil
        if (arr != nil) {
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

}

// 实现collectionView的Cell点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *section = [NSString stringWithFormat:@"%ld", indexPath.section];
    NSMutableArray *arr = self.pointArr[indexPath.section];
    NSMutableDictionary *dict = self.sectionArr[indexPath.section];
    UIViewController *myVC = [self viewController];
    // 判断是cell位置，如果是最后一个就进入添加页面，否则进入编辑页面并传值
    if (indexPath.row == dict.count) {
        
        AddModuleController *AMC = [[AddModuleController alloc] init];
        AMC.section = section;
        [myVC.navigationController pushViewController:AMC animated:YES];
    }else{
        
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


// 创建数据源数组
- (void)creatSectionArr {
    for (int i = 0; i < 3; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [self.sectionArr addObject:dict];
        NSMutableArray *arr = [NSMutableArray array];
        [self.pointArr addObject:arr];
        
    }
    [self.packetDict setObject:self.sectionArr forKey:@"sourceDict"];
    [self.packetDict setObject:self.pointArr forKey:@"signArr"];
}

// 计算collectionView高度
- (NSInteger)calculateHeight {
    
    NSInteger height = 0;
    NSLog(@"%ld", (NSInteger)self.layout.itemSize.height);
    for (int i = 0; i < self.sectionArr.count; i++) {
        NSMutableDictionary *dict = self.sectionArr[i];
        height += (self.layout.itemSize.height + KWIDTH / 12) * (dict.count / 3 + 1);
        NSLog(@"%ld", height);
        
    }
    NSString *heightStr = [NSString stringWithFormat:@"%ld", height];
    NSDictionary *dict = @{@"height":heightStr};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"height" object:self userInfo:dict];
    
    return height;
}


// 寻找响应链上的controller 用来模态到新的界面
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

// 实现通知方法
- (void)addItemNum:(NSNotification *)notification {
    
    // 添加区分cell类型的标记
    [self.signArr addObject:notification.userInfo[@"sign"]];
    // 添加cell个数
    _num +=1;
    // 获取外界传来的文本
    NSString *str = notification.userInfo[@"text"];
    // 设置key
    NSString *key = [NSString stringWithFormat:@"%ld", _num];
    // 将文本和对应key添加到数据源字典中
    NSInteger section = [notification.userInfo[@"section"] integerValue];
    NSMutableDictionary *dict = self.sectionArr[section];
    [dict setObject:str forKey:key];
    // 重置collectionView的frame
    NSInteger height = [self calculateHeight];
    self.collectionView.frame = CGRectMake(0, 0, KWIDTH, height);
    // 设置位置标记和类型标记的数组
    NSInteger sign = [notification.userInfo[@"sign"] integerValue];
    CGPoint point = CGPointMake(sign, _num);
    // 在数组中添加值对(CGPoint类型)，要注意CGPoint添加到数组中必须是NSValue类型
    NSMutableArray *arr = self.pointArr[section];
    [arr addObject:[NSValue valueWithCGPoint:point]];
    // 本地存储
    [self saveSourceDict];
    // 每次增加新数据，都要刷新collectionView
    [self.collectionView reloadData];
}

- (void)addImageCell:(NSNotification *)notification {
    // 此方法原理同上
    [self.signArr addObject:notification.userInfo[@"sign"]];
    _num += 1;
    UIImage *image = notification.userInfo[@"image"];
    if (image != nil) {
        NSString *key = [NSString stringWithFormat:@"%ld", _num];
        NSInteger section = [notification.userInfo[@"section"] integerValue];
        NSMutableDictionary *dict = self.sectionArr[section];
        [dict setObject:image forKey:key];
        NSInteger height = [self calculateHeight];
        self.collectionView.frame = CGRectMake(0, 0, KWIDTH, height);
        // 设置位置标记和类型标记的数组
        NSInteger sign = [notification.userInfo[@"sign"] integerValue];
        CGPoint point = CGPointMake(sign, _num);
        NSMutableArray *arr = self.pointArr[section];
        [arr addObject:[NSValue valueWithCGPoint:point]];
        // 本地存储
        [self saveSourceDict];
        [self.collectionView reloadData];
    }

}

- (void)amendCell:(NSNotification *)notification{
    // 此观察者方法是用来修改对应cell中的内容，并不需要增加数据源字典中的数据
    NSString *key = notification.userInfo[@"key"];
    NSString *text = notification.userInfo[@"text"];
    NSInteger section = [notification.userInfo[@"section"] integerValue];
    NSMutableDictionary *dict = self.sectionArr[section];
    [dict setObject:text forKey:key];
    [self.collectionView reloadData];
    
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

#pragma mark - signArr的懒加载
- (NSMutableArray *)signArr {
    if (!_signArr) {
        self.signArr = [NSMutableArray array];
    }
    
    return _signArr;
}

#pragma mark - sourceDict(collectionView 的数据源)的懒加载
//- (NSMutableDictionary *)sourcrDict {
//    if (!_sourcrDict) {
//        self.sourcrDict = [NSMutableDictionary dictionary];
//    }
//    
//    return _sourcrDict;
//}
#pragma mark - pointArr的懒加载
- (NSMutableArray *)pointArr {
    if (!_pointArr) {
        self.pointArr = [NSMutableArray array];
    }
    
    return _pointArr;
}

#pragma mark - sectionArr的懒加载
- (NSMutableArray *)sectionArr{
    
    if (!_sectionArr) {
        self.sectionArr = [NSMutableArray array];
    }
    
    return _sectionArr;
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







- (void)dealloc {
    // 移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"addNum" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"image" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"amend" object:nil];
    
}

#pragma mark - plist文件






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
