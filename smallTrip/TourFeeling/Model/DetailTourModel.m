//
//  DetailTourModel.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/1.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "DetailTourModel.h"

@implementation DetailTourModel

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key {
    if ([key isEqualToString:@"descripion"]) {
        self.description0 = value;
    }
}

@end
