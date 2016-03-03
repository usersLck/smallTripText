//
//  Weather.h
//  smallTrip
//
//  Created by 刘常凯 on 16/2/23.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property (nonatomic ,retain)NSString *temp_day_c; //高温

@property (nonatomic, retain)NSString *temp_night_c;  //低温

@property (nonatomic, retain)NSString *week; //星期

@property (nonatomic, retain)NSString *date; //日期

@property (nonatomic, retain)NSString *weather; //天气

//@property (nonatomic, retain)NSString *sunUpTime; //太阳升起时间

//@property (nonatomic, retain)NSString *sunDownTime; //太阳落下时间

@property (nonatomic, retain)NSString *wd; //风向

@property (nonatomic, retain)NSString *ws; //风力

//@property (nonatomic, retain)NSString *tourIndex; //旅游指数

//@property (nonatomic, retain)NSString *shoppingIndex; //逛街指数

//@property (nonatomic, retain)NSString *sunscreenIndex; //防晒指数

//@property (nonatomic, retain)NSString *dressIndex; //穿衣指数



//@property (nonatomic, retain)NSArray *array;

@end
