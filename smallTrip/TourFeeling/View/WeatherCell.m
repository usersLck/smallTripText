//
//  WeatherCell.m
//  smallTrip
//
//  Created by 刘常凯 on 16/2/24.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "WeatherCell.h"

#import "WeatherView.h"

#import "weatherDetail.h"

#import "ShareButton.h"

#import "CurveView.h"

#import "CityWeather.h"

#import "Weather.h"

#import "WeatherController.h"

#import "SearchWeatherController.h"

#import <Accelerate/Accelerate.h>

@interface WeatherCell ()

@property (nonatomic, retain)UIImageView *images;

@property (nonatomic, retain)CurveView *curve;

@property (nonatomic, retain)UIImageView *weatherImage;

@end

@implementation WeatherCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)setArray:(NSMutableArray *)array{
    _array = array;
    _curve.array = array;
    [self.contentView addSubview:_curve];

    WeatherDetail *detail = self.array[0];
    _weatherLabel.text = detail.weather;
    
    NSString *weather = @"";
    if ([detail.weather rangeOfString:@"雪"].location != NSNotFound) {
        weather = @"snow1";
        _weatherImage.image = [UIImage imageNamed:weather];
    }else if ([detail.weather rangeOfString:@"雨"].location != NSNotFound){
        weather = @"rain1";
        _weatherImage.image = [UIImage imageNamed:weather];
    }else if ([detail.weather rangeOfString:@"霾"].location != NSNotFound){
        weather = @"haze1";
        _weatherImage.image = [UIImage imageNamed:weather];
    }else if ([detail.weather rangeOfString:@"雾"].location != NSNotFound){
        weather = @"fog";
        _weatherImage.image = [UIImage imageNamed:weather];
    }else if ([detail.weather rangeOfString:@"沙尘"].location != NSNotFound){
        weather = @"storm";
        _weatherImage.image = [UIImage imageNamed:weather];
    }else if ([detail.weather rangeOfString:@"阴"].location != NSNotFound){
        weather = @"cloudy11";
        _weatherImage.image = [UIImage imageNamed:weather];
    }else if ([detail.weather rangeOfString:@"多云"].location != NSNotFound){
        weather = @"cloudys";
        _weatherImage.image = [UIImage imageNamed:weather];
    }else if ([detail.weather isEqualToString:@"晴"]){
        weather = @"fine1";
        _weatherImage.image = [UIImage imageNamed:weather];
    }
    else{
        weather = @"weather";
        _weatherImage.image = [UIImage imageNamed:weather];
    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:weather forKey:@"weatherImage"];
    NSInteger temp = (detail.highestTemperature + detail.lowerestTemperature) / 2;
    _temperatureLabel.text = [NSString stringWithFormat:@"%ld°", temp] ;
    
}

- (void)setWeekArray:(NSMutableArray *)weekArray{
    _weekArray = weekArray;
    for (int i = 0; i < _line.topArray.count; i++) {
        Weather *weather = weekArray[i];
        ((UILabel *)_line.topArray[i]).text = weather.week;
        if (_line.type) {
            ((UILabel *)_line.secondArray[i]).text = weather.weather;
        }else{
            UIImage *image = nil;
            if ([weather.weather rangeOfString:@"雪"].location != NSNotFound) {
                image = [UIImage imageNamed:@"snow"];
            }else if ([weather.weather rangeOfString:@"雨"].location != NSNotFound){
                image = [UIImage imageNamed:@"rain"];
            }else if ([weather.weather rangeOfString:@"霾"].location != NSNotFound){
                image = [UIImage imageNamed:@"haze"];
            }else if ([weather.weather rangeOfString:@"雾"].location != NSNotFound){
                image = [UIImage imageNamed:@"fog"];
            }else if ([weather.weather rangeOfString:@"沙尘"].location != NSNotFound){
                image = [UIImage imageNamed:@"storm"];
            }else if ([weather.weather rangeOfString:@"阴"].location != NSNotFound){
                image = [UIImage imageNamed:@"cloudy"];
            }else if ([weather.weather rangeOfString:@"多云"].location != NSNotFound){
                image = [UIImage imageNamed:@"cloudys"];
            }else if ([weather.weather isEqualToString:@"晴"]){
                image = [UIImage imageNamed:@"fine"];
            }
            else{
                image = [UIImage imageNamed:@"weather"];
            }
            
            ((UIImageView *)_line.secondArray[i]).image = image;
        }
        
        ((UILabel *)_line.lastArray[i]).text = [NSString stringWithFormat:@"%@°/%@°", weather.temp_day_c, weather.temp_night_c] ;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *weatherImage = [ user objectForKey:@"weatherImage"];
        _weatherImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT * 2 / 3) ];
        _weatherImage.image = [UIImage imageNamed:weatherImage];
        [self.contentView addSubview:_weatherImage];
        _weatherImage.userInteractionEnabled = YES;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(KWIDTH / 22, TABBARHEIGHT * 2, KWIDTH / 11, KWIDTH / 11);
        [_weatherImage addSubview:button];
        [button setImage:[UIImage imageNamed:@"magnifier"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(returnSearch:) forControlEvents:UIControlEventTouchUpInside];
        
        ShareButton *share = [[ShareButton alloc] initShareButton];
        share.frame = CGRectMake(KWIDTH - BUTTONHEIGHT * 1.5,  TABBARHEIGHT * 2, BUTTONHEIGHT, BUTTONHEIGHT);
        [_weatherImage addSubview:share];
        
        _cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KHEIGHT / 5, KWIDTH, TABBARHEIGHT)];
        [self.contentView addSubview:_cityNameLabel];
        _cityNameLabel.textAlignment = NSTextAlignmentCenter;
        _cityNameLabel.font = [UIFont systemFontOfSize:30];
        _cityNameLabel.textColor = [UIColor whiteColor];
        
        _weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _cityNameLabel.frame.origin.y + _cityNameLabel.bounds.size.height, KWIDTH, TABBARHEIGHT)];
        [self.contentView addSubview:_weatherLabel];
        _weatherLabel.textAlignment = NSTextAlignmentCenter;
        _weatherLabel.font = [UIFont systemFontOfSize:20];
        _weatherLabel.textColor = [UIColor whiteColor];
        
        _temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _weatherLabel.frame.origin.y + _weatherLabel.bounds.size.height, KWIDTH, KHEIGHT / 8)];
        [self.contentView addSubview:_temperatureLabel];
        _temperatureLabel.textAlignment = NSTextAlignmentCenter;
        _temperatureLabel.font = [UIFont systemFontOfSize:60];
        _temperatureLabel.textColor = [UIColor whiteColor];
        
        _qualityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _temperatureLabel.frame.origin.y + _temperatureLabel.bounds.size.height, KWIDTH, TABBARHEIGHT)];
        [self.contentView addSubview:_qualityLabel];
        _qualityLabel.textAlignment = NSTextAlignmentCenter;
        _qualityLabel.textColor = [UIColor whiteColor];
        
        _line = [[LineData alloc] initWithFrame:CGRectMake(10, KHEIGHT * 2 / 3 + TABBARHEIGHT, KWIDTH - 20, TABBARHEIGHT * 2) andArray:((CityWeather *)self.array[0]).detailArray andType:0];
        [self.contentView addSubview:_line];
        
        _curve = [[CurveView alloc] initWithFrame:CGRectMake(0, KHEIGHT * 2 / 3 - 100, KWIDTH, 400)];
//        [self.contentView addSubview:_curve];
    }
    return self;
}



- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)returnSearch:(UIButton *)sender{
    id controller = [self viewController];
    SearchWeatherController *search = [[SearchWeatherController alloc] init];
    [((WeatherController *)controller).navigationController pushViewController:search animated:YES];
}

@end
