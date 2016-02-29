//
//  weatherDetail.h
//  smallTrip
//
//  Created by 刘常凯 on 16/2/23.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherDetail : NSObject

@property (nonatomic, assign)NSInteger highestTemperature;

@property (nonatomic, assign)NSInteger lowerestTemperature;

@property (nonatomic, retain)NSString *startTime; //开始时间

@property (nonatomic, retain)NSString *endTime; //结束时间

@property (nonatomic, retain)NSString *weather; //实时天气

//@property (nonatomic, assign)NSString *highestTemperature; //温度上限

//@property (nonatomic, retain)NSString *lowerestTemperature; //温度下限

@end
