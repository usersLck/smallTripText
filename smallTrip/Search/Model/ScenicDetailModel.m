//
//  ScenicDetailModel.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/6.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "ScenicDetailModel.h"

@implementation ScenicDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"beentocounts"]) {
        _beentocounts = [NSString stringWithFormat:@"%@", value];
    }
}

@end
