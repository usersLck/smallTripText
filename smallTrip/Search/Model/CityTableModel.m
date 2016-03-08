//
//  CityTableModel.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/6.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "CityTableModel.h"

@implementation CityTableModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _ID = [NSString stringWithFormat:@"%@", value];
    }
}

@end
