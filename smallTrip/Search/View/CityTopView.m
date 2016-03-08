//
//  CityTopView.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/6.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "CityTopView.h"
#import "CityTopModel.h"
#import "FXLabel.h"
@interface CityTopView ()
@property(nonatomic, strong) UILabel *enName;
@property(nonatomic, strong) UILabel *cnName;
@property(nonatomic, strong) UILabel *descrip;

@end

@implementation CityTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//        _cnName = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH/20, KWIDTH/5, KWIDTH - KWIDTH/15, 30)];
//        [self addSubview:_cnName];
//        _cnName.font = [UIFont systemFontOfSize:20];
        
        FXLabel *label = [[FXLabel alloc] init];
        label.frame = CGRectMake(KWIDTH/20, KWIDTH/5, KWIDTH - KWIDTH/15, 30);
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
        label.textColor = [UIColor whiteColor];
        label.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
        label.shadowOffset = CGSizeMake(0.0f, 2.0f);
        label.shadowBlur = 5.0f;
        _cnName = label;
        [self addSubview:_cnName];
        
        _enName = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH/20, CGRectGetMaxY(_cnName.frame) + 5, CGRectGetWidth(_cnName.frame), 20)];
        _enName.font = [UIFont systemFontOfSize:14];
        [self addSubview:_enName];
        
        _descrip = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH/20, CGRectGetMaxY(_enName.frame), KWIDTH - KWIDTH/10, 40)];
        _descrip.font = [UIFont systemFontOfSize:17];
        _descrip.numberOfLines = 0;
        [self addSubview:_descrip];
        
        _cnName.textColor = [UIColor whiteColor];
        _enName.textColor = [UIColor whiteColor];
        _descrip.textColor = [UIColor whiteColor];
        
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(KWIDTH/41, 25, 30, 30);
        [_backButton setBackgroundImage:[UIImage imageNamed:@"Secondback"] forState:UIControlStateNormal];
        [self addSubview:_backButton];
    }
    return self;
}

- (void)setTopModel:(CityTopModel *)topModel {
    _topModel = topModel;
    _cnName.text = topModel.cnname;
    _enName.text = topModel.enname;
    if (topModel.entryCont.length > 80) {
        _descrip.text = [topModel.entryCont stringByAppendingString:@"......"];
    } else {
        _descrip.text = topModel.entryCont;
    }
    CGRect rect = [_descrip.text boundingRectWithSize:CGSizeMake(KWIDTH - KWIDTH/10, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    _descrip.frame = CGRectMake(KWIDTH/20, CGRectGetMaxY(_enName.frame) + 15, KWIDTH-KWIDTH/10, rect.size.height);
    self.frame = CGRectMake(0, 0, KWIDTH, CGRectGetMaxY(_descrip.frame) + 40);
}

@end
