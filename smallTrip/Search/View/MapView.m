//
//  MapView.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/3.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "MapView.h"
#import "BigModel.h"
#import "FXLabel.h"

@implementation MapView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _mapImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT/3.5)];
        _mapImageV.image = [UIImage imageNamed:@"mapworld.png"];
        [self addSubview:_mapImageV];
        
        _NorthAmericaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _NorthAmericaButton.frame = CGRectMake(KWIDTH/6, KHEIGHT/25, 45, 25);
        
        _EuropeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _EuropeButton.frame = CGRectMake(KWIDTH*3.3/6, KHEIGHT/25, 45, 25);
        
        _AsiaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _AsiaButton.frame = CGRectMake(KWIDTH*4.5/6, KHEIGHT/25, 45, 25);
        
        _SouthAmericaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _SouthAmericaButton.frame = CGRectMake(KWIDTH*1.8/6, KHEIGHT*3.5/25, 45, 25);
        
        _AfricaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _AfricaButton.frame = CGRectMake(KWIDTH*3/6, KHEIGHT*2.5/25, 45, 25);
        
        _OceaniaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _OceaniaButton.frame = CGRectMake(KWIDTH*5/6, KHEIGHT*4/25, 45, 25);
        
        _AntarcticaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _AntarcticaButton.frame = CGRectMake(KWIDTH*4/6, KHEIGHT*6/25, 45, 25);
        
        self.buttonArr = [NSMutableArray arrayWithObjects:_AsiaButton, _EuropeButton,_NorthAmericaButton, _SouthAmericaButton, _OceaniaButton, _AfricaButton, _AntarcticaButton, nil];
        NSArray *titleArr = @[@"亚洲", @"欧洲", @"北美洲", @"南美洲", @"大洋洲", @"非洲", @"南极洲"];
        for (int i = 0; i < _buttonArr.count; i++) {
            UIButton *button = _buttonArr[i];
            button.tag = 1000+i;
            [button setTitle:titleArr[i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            button.layer.cornerRadius = 4;
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor whiteColor];
            [self addSubview:button];
        }
        
//        _hottitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH/40, CGRectGetMaxY(_mapImageV.frame), KWIDTH, 44)];
//        _hottitleLabel.text = @"亚洲热门目的地";
//        [self addSubview:_hottitleLabel];
        
        FXLabel *label = [[FXLabel alloc] init];
         label.frame = CGRectMake(KWIDTH/40, CGRectGetMaxY(_mapImageV.frame), KWIDTH, 44);
         label.backgroundColor = [UIColor clearColor];
         label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
         label.text = @"亚洲热门目的地";
         label.textColor = [UIColor blackColor];
         label.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.2f];
         label.shadowOffset = CGSizeMake(0.0f, 2.0f);
        label.shadowBlur = 5.0f;
        _hottitleLabel = label;
        [self addSubview: _hottitleLabel];
        /**
         *  secondLabel = [[FXLabel alloc] init];
         secondLabel.frame = CGRectMake(40, 140, 240, 80);
         secondLabel.backgroundColor = [UIColor clearColor];
         secondLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:35];
         secondLabel.text = @"第二种效果";
         secondLabel.textColor = [UIColor whiteColor];
         secondLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.75f];
         secondLabel.shadowOffset = CGSizeMake(0.0f, 5.0f);
         secondLabel.shadowBlur = 5.0f;
         [self.view addSubview:secondLabel];
         */

    }
    return self;
}
#pragma mark - 选择大洲后button的状态
- (void)setButtonState:(UIButton *)button {
    for (int i = 0; i < _buttonArr.count; i++) {
        if (button.tag == 1000 + i) {
            UIButton *button = _buttonArr[i];
            button.backgroundColor = [UIColor orangeColor];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionRepeat animations:^{
                [UIView setAnimationRepeatAutoreverses:YES];
                [UIView setAnimationRepeatCount:LLONG_MAX];
                button.transform = CGAffineTransformMakeScale(1.4, 1.4);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:1.5 animations:^{
                    button.transform = CGAffineTransformMakeScale(1, 1);
                }];
            }];
        } else {
            UIButton *button = _buttonArr[i];
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [button.layer removeAllAnimations ];
        }
    }
}



@end
