//
//  WeatherCell.h
//  smallTrip
//
//  Created by 刘常凯 on 16/2/24.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LineData.h"

@interface WeatherCell : UITableViewCell

@property (nonatomic, retain)NSMutableArray *array;

@property (nonatomic, retain)NSMutableArray *weekArray;

@property (nonatomic ,retain)LineData *line;

@property (nonatomic, retain)UILabel *cityNameLabel;

@property (nonatomic, retain)UILabel *weatherLabel;

@property (nonatomic, retain)UILabel *temperatureLabel;

@property (nonatomic, retain)UILabel *qualityLabel;

@end
