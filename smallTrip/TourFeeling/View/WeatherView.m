//
//  WeatherView.m
//  smallTrip
//
//  Created by 刘常凯 on 16/2/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "WeatherView.h"

@implementation WeatherView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height / 4)];
        [self addSubview:_label1];
        _label1.textAlignment = NSTextAlignmentCenter;
        _label1.font = [UIFont systemFontOfSize:13];
        _label1.textColor = [UIColor whiteColor];
        
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake(_label1.frame.origin.x, frame.size.height / 4, _label1.bounds.size.width, _label1.bounds.size.height)];
        [self addSubview:_label2];
        _label2.textAlignment = NSTextAlignmentCenter;
        _label2.font = [UIFont systemFontOfSize:13];
        _label2.textColor = [UIColor whiteColor];
        
        _label3 = [[UILabel alloc] initWithFrame:CGRectMake(_label1.frame.origin.x, frame.size.height * 1 / 2, _label1.bounds.size.width, _label1.bounds.size.height)];
        [self addSubview:_label3];
        _label3.textAlignment = NSTextAlignmentCenter;
        _label3.font = [UIFont systemFontOfSize:13];
        _label3.textColor = [UIColor whiteColor];
        
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(_label1.frame.origin.x + _label1.bounds.size.width / 2 - _label1.bounds.size.height / 2, frame.size.height * 3 / 4, _label1.bounds.size.height, _label1.bounds.size.height)];
        _image.image = [UIImage imageNamed:@"dian"];
        [self addSubview:_image];
        
    }
    return self;
}

@end
