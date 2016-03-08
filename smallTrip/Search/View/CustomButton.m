//
//  CustomButton.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/3.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width*1.5/3, frame.size.width/20, frame.size.width - frame.size.width*1.5/3 - frame.size.width/20, frame.size.height/5)];
        _countLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _countLabel.layer.cornerRadius = 6;
        _countLabel.clipsToBounds = YES;
        _countLabel.textColor = [UIColor whiteColor];
        [self addSubview:_countLabel];
        
        _countryCn = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/80, self.bounds.size.height*3.5/5, frame.size.width - frame.size.width/40, 30)];
        _countryCn.textColor = [UIColor whiteColor];
        [self addSubview:_countryCn];
        
        _countryEn = [[UILabel alloc] initWithFrame:CGRectMake(_countryCn.frame.origin.x, CGRectGetMaxY(_countryCn.frame), _countryCn.bounds.size.width, 20)];
        _countryEn.textColor = [UIColor whiteColor];
        [self addSubview:_countryEn];
        
    }
    return self;
}


@end
