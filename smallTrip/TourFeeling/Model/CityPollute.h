//
//  CityPollute.h
//  smallTrip
//
//  Created by 刘常凯 on 16/2/23.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityPollute : NSObject

@property (nonatomic, retain)NSString *pm25; //pm2.5

@property (nonatomic, retain)NSString *pm10; //pm10

@property (nonatomic, retain)NSString *quality; //空气质量

@property (nonatomic, retain)NSString *aqi; //空气指数

@end
