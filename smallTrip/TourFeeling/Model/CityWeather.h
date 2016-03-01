//
//  CityWeather.h
//  smallTrip
//
//  Created by 刘常凯 on 16/2/23.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeatherDetail;

@class CityPollute;

@interface CityWeather : NSObject

@property (nonatomic, retain)NSString *city;

@property (nonatomic, retain)NSMutableArray *indexArray; //指数数组

@property (nonatomic, retain)NSMutableArray *weatherArray; //一周天气数组

@property (nonatomic, retain)CityPollute *pollute; //空气质量

@property (nonatomic, retain)NSMutableArray *detailArray; //实时天气数组

@end
