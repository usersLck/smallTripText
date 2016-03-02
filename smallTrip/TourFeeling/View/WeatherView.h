//
//  WeatherView.h
//  smallTrip
//
//  Created by 刘常凯 on 16/2/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherView : UIView

@property (nonatomic, retain)NSMutableArray *pointArray;

@property (nonatomic, retain)UILabel *label1;

@property (nonatomic, retain)UILabel *label2;

@property (nonatomic, retain)UILabel *label3;

@property (nonatomic, retain)UIImageView *image;


- (instancetype)initWithFrame:(CGRect)frame;

@end
