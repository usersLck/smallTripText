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

@property (nonatomic, retain)UICollectionView *collectionView;
@property (nonatomic, retain)NSMutableArray *cellArr;
@property (nonatomic, assign)NSInteger itemNum;


@end
