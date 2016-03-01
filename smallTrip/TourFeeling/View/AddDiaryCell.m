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
@property (nonatomic, strong)NSMutableDictionary *sourcrDict;

// 存储cell类型和顺序的数组
@property (nonatomic, strong)NSMutableArray *pointArr;


@end


@implementation AddDiaryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        // 注册成为观察者
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addItemNum:) name:@"addNum" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addImageCell:) name:@"image" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(amendCell:) name:@"amend" object:nil];
        
        self.layout = [[UICollectionViewFlowLayout alloc] init];
        self.layout.itemSize = CGSizeMake(KWIDTH/4, KWIDTH/4);
        self.layout.minimumLineSpacing = KWIDTH / 12;
        self.layout.minimumInteritemSpacing = 0;
        self.layout.sectionInset = UIEdgeInsetsMake(10, KWIDTH / 12, 0, KWIDTH / 12);
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, (self.layout.itemSize.height + KWIDTH / 12) * (self.sourcrDict.count / 3 + 1)) collectionViewLayout:self.layout];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.backgroundColor = [UIColor yellowColor];
        
        
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

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    // 返回YES 允许Item移动
    
    return YES;
}

#warning source -- 数据源没改变
// 改动源数据 -- 最重要的一步
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    
    
    //取出源item数据
    id objc = [self.pointArr objectAtIndex:sourceIndexPath.row];
    //从资源数组中移除该数据
    [self.pointArr removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [self.pointArr insertObject:objc atIndex:destinationIndexPath.row];
    [collectionView reloadData];
 
}

// 设置分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 设置每个分区的Item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.sourcrDict.count + 1;
}

// 对collectionView的Cell进行设置
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.sourcrDict.count) {
        AddModuleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"add" forIndexPath:indexPath];
        return cell;
    }else{
        
        
        CGPoint point = ((NSValue *)self.pointArr[indexPath.row]).CGPointValue;
        NSLog(@"%@", NSStringFromCGPoint(point));
        NSString *strX = [NSString stringWithFormat:@"%d", (int)point.x];
        NSString *strY = [NSString stringWithFormat:@"%d", (int)point.y];
        if ([strX isEqualToString:@"0"]) {
            CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sum" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor cyanColor];
            cell.myLabel.text = self.sourcrDict[strY];
            return cell;
        }else{
            ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"image" forIndexPath:indexPath];
            cell.myImageV.image = self.sourcrDict[strY];
            return cell;
        }
        
    }

}

// 实现collectionView的Cell点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *myVC = [self viewController];
    if (indexPath.row == self.sourcrDict.count) {
        
        AddModuleController *AMC = [[AddModuleController alloc] init];
        [myVC.navigationController pushViewController:AMC animated:YES];
    }else{
        
        CGPoint point = ((NSValue *)self.pointArr[indexPath.row]).CGPointValue;
        NSString *strX = [NSString stringWithFormat:@"%d", (int)point.x];
        NSString *strY = [NSString stringWithFormat:@"%d", (int)point.y];
        
        if ([strX isEqualToString:@"0"]) {
            TextController *textC = [[TextController alloc] init];
            textC.text = self.sourcrDict[strY];
            textC.key = strY;
            [myVC.navigationController pushViewController:textC animated:YES];
        }else{
            
        }
    }
    
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
    [self.sourcrDict setObject:str forKey:key];
    // 重置collectionView的frame
    self.collectionView.frame = CGRectMake(0, 0, KWIDTH, (self.layout.itemSize.height + KWIDTH / 12) * (self.sourcrDict.count / 3 + 1));
    // 设置位置标记和类型标记的数组
    NSInteger sign = [notification.userInfo[@"sign"] integerValue];
    CGPoint point = CGPointMake(sign, _num);
    // 在数组中添加值对(CGPoint类型)，要注意CGPoint添加到数组中必须是NSValue类型
    [self.pointArr addObject:[NSValue valueWithCGPoint:point]];
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
        [self.sourcrDict setObject:image forKey:key];
        self.collectionView.frame = CGRectMake(0, 0, KWIDTH, (self.layout.itemSize.height + KWIDTH / 12) * (self.sourcrDict.count / 3 + 1));
        // 设置位置标记和类型标记的数组
        NSInteger sign = [notification.userInfo[@"sign"] integerValue];
        CGPoint point = CGPointMake(sign, _num);
        [self.pointArr addObject:[NSValue valueWithCGPoint:point]];
        [self.collectionView reloadData];
    }

}

- (void)amendCell:(NSNotification *)notification{
    // 此观察者方法是用来修改对应cell中的内容，并不需要增加数据源字典中的数据
    NSString *key = notification.userInfo[@"key"];
    NSString *text = notification.userInfo[@"text"];
    [self.sourcrDict setObject:text forKey:key];
    [self.collectionView reloadData];
    
}


// signArr的懒加载
- (NSMutableArray *)signArr {
    if (!_signArr) {
        self.signArr = [NSMutableArray array];
    }
    
    return _signArr;
}
// sourceDict(collectionView 的数据源)的懒加载
- (NSMutableDictionary *)sourcrDict {
    if (!_sourcrDict) {
        self.sourcrDict = [NSMutableDictionary dictionary];
    }
    
    return _sourcrDict;
}

// pointArr的懒加载
- (NSMutableArray *)pointArr {
    if (!_pointArr) {
        self.pointArr = [NSMutableArray array];
    }
    
    return _pointArr;
}

- (void)dealloc {
    // 移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"addNum" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"image" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"amend" object:nil];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
