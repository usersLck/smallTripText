//
//  TourModel.h
//  smallTrip
//
//  Created by 刘常凯 on 16/1/28.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailTourModel.h"

@interface TourModel : NSObject

@property(nonatomic, copy) NSString *goodNumber;// 点赞数
@property(nonatomic, copy) NSString *userName;// 用户名
@property(nonatomic, copy) NSString *photo;// 头像图片
@property(nonatomic, copy) NSString *time;// 发表时间
@property(nonatomic, copy) NSString *name;// 标题？
@property(nonatomic, copy) NSString *commentNumber;// 评论数
//@property(nonatomic, strong) NSMutableArray *detailList;

@property(nonatomic, strong) NSMutableArray *listArr;
//@property(nonatomic, strong) DetailTourModel *detailTourModel;










@end
