//
//  AddDiaryCell.h
//  smallTrip
//
//  Created by 纪宇驰 on 16/2/24.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/NSFileManager.h>


@interface AddDiaryCell : UITableViewCell

// 判断是tableView上第几行
@property (nonatomic, assign)NSInteger sectionNum;

// 存储cell类型和顺序的数组
@property (nonatomic, strong)NSMutableArray *pointArr;
// 分区标记
@property (nonatomic, assign)NSInteger section;
// 存储不同section数据源字典的数组
@property (nonatomic, strong)NSMutableArray *sectionArr;

@property (nonatomic, strong)NSMutableArray *placeArr;

@property (nonatomic, retain)UICollectionView *collectionView;
@property (nonatomic, retain)NSMutableArray *cellArr;
@property (nonatomic, assign)NSInteger itemNum;

@end
