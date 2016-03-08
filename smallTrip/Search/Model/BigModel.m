//
//  BigModel.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/4.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "BigModel.h"

@interface BigModel ()


@end


@implementation BigModel

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"hot_country"]) {
        [self configuireHotCountryArr:value];
    } else if ([key isEqualToString:@"country"]) {
        [self configuireOtherCountryArr:value];
        
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _ID = [NSString stringWithFormat:@"%@", value];
    }
}


/**
 *  配置热门国家数据
 *
 *  
 */
- (void)configuireHotCountryArr:(id)value {
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSDictionary *dict in value) {
        HotCountryModel *hotModel = [[HotCountryModel alloc] init];
        [hotModel setValuesForKeysWithDictionary:dict];
        [tempArr addObject:hotModel];
    }
    self.hotCountryArr = [NSMutableArray array];
    if (tempArr.count < 2) {
        [self.hotCountryArr addObject:tempArr];
    } else {
        for (int i = 0; i < tempArr.count /2; i++) {
            NSMutableArray *arr = [NSMutableArray array];
            for (int j = 0; j < 2; j ++) {
                [arr addObject:tempArr[j + i*2]];
            }
            [self.hotCountryArr addObject:arr];
        }
    }
}

/**
 *  配置其他国家数据
 *
 *
 */
- (void)configuireOtherCountryArr:(id)value {
    self.otherCountryArr = [NSMutableArray array];
    for (NSDictionary *dict in value) {
        OtherCountryModel *model = [[OtherCountryModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [self.otherCountryArr addObject:model];
    }
}




@end
