//
//  TopReusableView.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/5.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TopReusableView.h"
#import "TopScrollView.h"
#import "ScrollModel.h"
#import "FXLabel.h"

@interface TopReusableView ()


@property(nonatomic, strong) UILabel *cnName;
@property(nonatomic, strong) UILabel *enName;
@property(nonatomic, strong) UILabel *descrip;

@end

@implementation TopReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _scrollView = [[TopScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:_scrollView];
        
//        _cnName = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH/20, self.bounds.size.height*2.3/5, KWIDTH - KWIDTH/15, 30)];
//        [self addSubview:_cnName];
        
        FXLabel *label = [[FXLabel alloc] init];
        label.frame = CGRectMake(KWIDTH/20, self.bounds.size.height*2.3/5, KWIDTH - KWIDTH/15, 30);
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
        label.textColor = [UIColor whiteColor];
        label.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
        label.shadowOffset = CGSizeMake(0.0f, 2.0f);
        label.shadowBlur = 5.0f;
        _cnName = label;
        [self addSubview:_cnName];
        
        
        _enName = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH/20, CGRectGetMaxY(_cnName.frame) + 5, CGRectGetWidth(_cnName.frame), 20)];
        _enName.font = [UIFont systemFontOfSize:12];
        [self addSubview:_enName];
        
        _descrip = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH/20, CGRectGetMaxY(_enName.frame) + 10, KWIDTH - KWIDTH/10, 40)];
        _descrip.font = [UIFont systemFontOfSize:13];
        _descrip.numberOfLines = 0;
        [self addSubview:_descrip];
        
        _cnName.textColor = [UIColor whiteColor];
        _enName.textColor = [UIColor whiteColor];
        _descrip.textColor = [UIColor whiteColor];
        
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(KWIDTH/41, 25, 30, 30);
        [_backButton setBackgroundImage:[UIImage imageNamed:@"Secondback"] forState:UIControlStateNormal];
        [self addSubview:_backButton];
        
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreButton.frame = CGRectMake(KWIDTH*3.7/5, CGRectGetMaxY(_descrip.frame)+10, 100, 30);
//        [_moreButton setTitle:@"城市景点" forState:UIControlStateNormal];
        [self addSubview:_moreButton];
    }
    return self;
}

- (void)setScrollModel:(ScrollModel *)scrollModel {
    _scrollModel = scrollModel;
    _cnName.text = scrollModel.cnname;
    _enName.text = scrollModel.enname;
    _descrip.text = scrollModel.entryCont;
    
}

@end
