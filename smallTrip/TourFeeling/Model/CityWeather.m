//
//  CityWeather.m
//  smallTrip
//
//  Created by 刘常凯 on 16/2/23.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "CityWeather.h"

#import "WeatherDetail.h"

#import "IndexDetail.h"

#import "CityPollute.h"

#import "Weather.h"


@implementation CityWeather

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"weatherDetailsInfo"]){
        NSArray *arrs = value[@"weather3HoursDetailsInfos"];
        NSMutableArray *arr1 = [NSMutableArray array];
        for (NSDictionary *dic in arrs) {
            WeatherDetail *weather = [[WeatherDetail alloc] init];
            [weather setValuesForKeysWithDictionary:dic];
            [arr1 addObject:weather];
        }
        _detailArray = [NSMutableArray arrayWithArray:arr1];
    }
    if([key isEqualToString:@"indexes"]){
        NSMutableArray *arr1 = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            IndexDetail *index = [[IndexDetail alloc] init];
            [index setValuesForKeysWithDictionary:dic];
            [arr1 addObject:index];
        }
        _indexArray = [NSMutableArray arrayWithArray:arr1];
    }
    if ([key isEqualToString:@"pm25"]) {
        CityPollute *pollute = [[CityPollute alloc] init];
        [pollute setValuesForKeysWithDictionary:value];
        _pollute = pollute;
    }
    if ([key isEqualToString:@"weathers"]) {
        NSMutableArray *arr1 = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            Weather *weather = [[Weather alloc] init];
            [weather setValuesForKeysWithDictionary:dic];
            [arr1 addObject:weather];
        }
        _weatherArray = [NSMutableArray arrayWithArray:arr1];
    }
    
}

@end
