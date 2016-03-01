//
//  CurveView.m
//  smallTrip
//
//  Created by 刘常凯 on 16/2/25.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <math.h>

#import "CurveView.h"

#import "weatherDetail.h"

@interface CurveView ()

@property (nonatomic, assign)NSInteger type;

@property (nonatomic, retain)NSMutableArray *pointArray;

@property (nonatomic, assign)NSInteger sum;

@property (nonatomic, assign)NSInteger min;

@end

@implementation CurveView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSInteger)type{
    if (!_type) {
        self.type = 0;
    }
    return _type;
}

- (NSMutableArray *)pointArray{
    if (!_pointArray) {
        self.pointArray = [NSMutableArray array];
    }
    return _pointArray;
}

- (void)setArray:(NSMutableArray *)array{
    _array = array;
    self.type = 1;
    NSMutableArray *arr= [NSMutableArray array];
    for (int i = 0; i < self.array.count; i++) {
        WeatherDetail *detail = self.array[i];
        NSInteger temp = (detail.highestTemperature + detail.lowerestTemperature) / 2;
        [arr addObject: [NSNumber numberWithInteger:temp]];
    }
    NSArray *sort = [arr sortedArrayUsingSelector:@selector(compare:)];
    NSInteger max = ((NSNumber *)sort[self.array.count - 1]).integerValue;
    _min = ((NSNumber *)sort[0]).integerValue;
    _sum = 0;
    if((max * _min) >= 0){
        _sum = max - _min;
    }else{
        _sum = fabs(max) + fabs(_min);
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    if (self.type != 0) {
       for (int i = 0; i < 7; i++) {
           [self drawData:i];
           [self drawBack:i];
       }
    }
}

- (void)drawBack:(NSInteger)i{
    UIBezierPath *bezier = UIBezierPath.bezierPath;
    if (i != 0) {
        WeatherDetail *detail = self.array[i];
        NSInteger temp = (detail.highestTemperature + detail.lowerestTemperature) / 2 - _min;
        [bezier moveToPoint:CGPointMake((i - 1) * KWIDTH / 6, ((NSNumber *)_pointArray[i - 1]).doubleValue)];
        [bezier addLineToPoint:CGPointMake((i - 1) * KWIDTH / 6 ,  100)];
        [bezier addLineToPoint:CGPointMake(i * KWIDTH / 6 ,  100)];
        [bezier addLineToPoint:CGPointMake(i * KWIDTH / 6 ,  100 - 30 / _sum * temp)];
//        [bezier addLineToPoint:CGPointMake((i - 1) * KWIDTH / 6 ,  ((NSNumber *)_pointArray[i - 1]).doubleValue)];
        [bezier closePath];
        UIColor *backColor = [UIColor whiteColor];
        [backColor set];
        bezier.lineCapStyle = kCGLineCapRound;
        bezier.lineJoinStyle = kCGLineJoinRound;
        bezier.lineWidth = 1;
        [bezier fill];
    }
    
}

- (void)drawData:(NSInteger)i{
    UIBezierPath *bezierPath = UIBezierPath.bezierPath;
    WeatherDetail *detail = self.array[i];
    NSInteger temp = (detail.highestTemperature + detail.lowerestTemperature) / 2 - _min;
    CGFloat center = 0.0;
    if (((NSNumber *)_pointArray[i - 1]).doubleValue < (100 - 30 / _sum * temp)) {
        center = ((100 - 30 / _sum * temp) - ((NSNumber *)_pointArray[i - 1]).doubleValue) / 2 + ((NSNumber *)_pointArray[i - 1]).doubleValue - 3;
    }else{
        center = (((NSNumber *)_pointArray[i - 1]).doubleValue - (100 - 30 / _sum * temp)) / 2 + 100 - 30 / _sum * temp - 3;
    }
    [bezierPath moveToPoint:CGPointMake((i - 1) * KWIDTH / 6, ((NSNumber *)_pointArray[i - 1]).doubleValue)];
    [bezierPath addQuadCurveToPoint:CGPointMake(i * KWIDTH / 6 ,  100 - 30 / _sum * temp) controlPoint:CGPointMake(i * KWIDTH / 6 - KWIDTH / 12 - 3,  center)];
    [self.pointArray addObject:[NSNumber numberWithDouble:100 - 30 / _sum * temp]];
    UIColor *strokeColor = [UIColor whiteColor];
    [strokeColor set];
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    [bezierPath fill];
}

@end
