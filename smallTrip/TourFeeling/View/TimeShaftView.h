//
//  TimeShaftView.h
//  smallTrip
//
//  Created by 纪宇驰 on 16/3/7.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeShaftView : UIView

// 地点
@property (nonatomic, strong)NSArray *placeArr;
// 时间
@property (nonatomic, strong)NSString *timeStr;
// 地图button
@property (nonatomic, strong)UIButton *mapButton;
// 取消按钮
@property (nonatomic, strong)UIButton *cancelButton;

@end
