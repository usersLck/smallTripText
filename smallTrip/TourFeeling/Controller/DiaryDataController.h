//
//  DiaryDataController.h
//  smallTrip
//
//  Created by 纪宇驰 on 16/2/16.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/NSFileManager.h>

@interface DiaryDataController : UIViewController

// 接收行数
@property (nonatomic, strong)NSString *numOfRow;

// 标题
@property (nonatomic, strong)NSString *travelsTitle;
// 副标题
@property (nonatomic, strong)NSString *secondTitle;
// 旅行天数
@property (nonatomic, strong)NSString *days;
// 出发日期
@property (nonatomic, strong)NSString *beginDate;



@end
