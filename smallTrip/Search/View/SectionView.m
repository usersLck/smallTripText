//
//  SectionView.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/4.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "SectionView.h"
#import "FXLabel.h"

@implementation SectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH/40, 0, KWIDTH - KWIDTH/20, 44)];
//        _titleLabel.textColor = [UIColor blackColor];
//        _titleLabel.text = @"亚洲其他地区";
//        [self addSubview:_titleLabel];
        
        FXLabel *label = [[FXLabel alloc] init];
        label.frame = CGRectMake(KWIDTH/40, 0, KWIDTH - KWIDTH/20, 44);
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        label.text = @"亚洲其他地区";
        label.textColor = [UIColor blackColor];
        label.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.2f];
        label.shadowOffset = CGSizeMake(0.0f, 2.0f);
        label.shadowBlur = 5.0f;
        _titleLabel = label;
        [self addSubview:_titleLabel];
        
        
    }
    return self;
}

@end
