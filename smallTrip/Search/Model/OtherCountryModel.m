//
//  OtherCountryModel.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/4.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "OtherCountryModel.h"

@implementation OtherCountryModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _ID = [NSString stringWithFormat:@"%@", value];
    }
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"count"]) {
        _count = [NSString stringWithFormat:@"%@", value];
    }
    if ([key isEqualToString:@"flag"]) {
        _flag = [NSString stringWithFormat:@"%@", value];
    }
}



@end
