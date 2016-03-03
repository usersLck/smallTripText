//
//  TourModel.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/28.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TourModel.h"

@implementation TourModel

- (NSMutableArray *)listArr {
    if (_listArr == nil) {
        self.listArr = [NSMutableArray array];
    }
    return _listArr;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"detailList"]) {
        for (NSDictionary *dict in value) {
            DetailTourModel *detailTourModel = [[DetailTourModel alloc] init];
            [detailTourModel setValuesForKeysWithDictionary:dict];
            [self.listArr addObject:detailTourModel];
        }
    }
}

//- (void)setValue:(id)value forKey:(NSString *)key {
//    [super setValue:value forKey:key];
//    
//}

@end
