//
//  CityListCell.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/6.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "CityListCell.h"
#import "CityTableModel.h"
#import <UIImageView+WebCache.h>
#import "FXLabel.h"

@interface CityListCell ()
@property(nonatomic, strong) UIImageView *imageV;
@property(nonatomic, strong) UILabel *cnName;


@end

@implementation CityListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH/20, 0, KWIDTH - KWIDTH/10, KWIDTH/2.5)];
        _imageV.layer.cornerRadius = 5;
        _imageV.layer.borderWidth = 0.5;
        _imageV.clipsToBounds = YES;
        [self.contentView addSubview:_imageV];
        
//        _cnName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_imageV.frame)/10, CGRectGetHeight(_imageV.frame)/3, CGRectGetWidth(_imageV.frame) - CGRectGetWidth(_imageV.frame)/5, CGRectGetHeight(_imageV.frame)/3)];
//        _cnName.text = @"暂无名字";
//        _cnName.font = [UIFont systemFontOfSize:22];
//        _cnName.textAlignment = NSTextAlignmentCenter;
//        _cnName.textColor = [UIColor whiteColor];
//        [self.contentView addSubview:_cnName];
        
        FXLabel *label = [[FXLabel alloc] init];
        label.frame = CGRectMake(CGRectGetWidth(_imageV.frame)/10, CGRectGetHeight(_imageV.frame)/3, CGRectGetWidth(_imageV.frame) - CGRectGetWidth(_imageV.frame)/5, CGRectGetHeight(_imageV.frame)/3);
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
        label.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
        label.shadowOffset = CGSizeMake(0.0f, 2.0f);
        label.shadowBlur = 2.0f;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        _cnName = label;
        [self.contentView addSubview:_cnName];
    }
    return self;
}

- (void)setCityModel:(CityTableModel *)cityModel {
    _cityModel = cityModel;
    [_imageV sd_setImageWithURL:[NSURL URLWithString:cityModel.photo] placeholderImage:[UIImage imageNamed:@"place"]];
    _cnName.text = [NSString stringWithFormat:@"%@", cityModel.chinesename];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _imageV.frame = CGRectMake(KWIDTH/20, 0, KWIDTH - KWIDTH/10, self.bounds.size.height - 5);
    _cnName.frame = CGRectMake(CGRectGetWidth(_imageV.frame)/10, CGRectGetHeight(_imageV.frame)/3, CGRectGetWidth(_imageV.frame) - CGRectGetWidth(_imageV.frame)/10, CGRectGetHeight(_imageV.frame)/3);
}

@end
