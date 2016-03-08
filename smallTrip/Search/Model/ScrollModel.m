//
//  ScrollModel.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/5.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "ScrollModel.h"

@implementation ScrollModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"photos"]) {
        _photoArr = [NSMutableArray arrayWithArray:value];
    } else if ([key isEqualToString:@"id"]) {
        _countryID = value;
    }
}

@end
