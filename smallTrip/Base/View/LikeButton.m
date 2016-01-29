//
//  LikeButton.m
//  smallTrip
//
//  Created by Aaslte on 16/1/28.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "LikeButton.h"

@interface LikeButton ()

@property (nonatomic, assign) id delegate;
@property (nonatomic, strong) UIButton *likeButton;

@property (nonatomic, assign) BOOL isTap;

@end

@implementation LikeButton

- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate {
    self = [super initWithFrame:frame];
    self.delegate = delegate;
    if (self) {
        self.isTap = NO;
        
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _likeButton.frame = CGRectMake(0, 0, frame.size.height, frame.size.height);
        [_likeButton setImage:[UIImage imageNamed:@"12"] forState:UIControlStateNormal];
        [_likeButton addTarget:self action:@selector(doTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_likeButton];
        
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(_likeButton.frame.size.width + 10, 0, frame.size.width - _likeButton.frame.size.width - 10, frame.size.height)];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_countLabel];
    }
    return self;
}

- (void)doTap:(UIButton *)button {
    if (!_isTap) {
        if (![_countLabel.text containsString:@"."]) {
            CGFloat value = [_countLabel.text floatValue] + 1;
            if (value > 9999) {
                _countLabel.text = [NSString stringWithFormat:@"%.1f万", value / 10000];
            } else {
                _countLabel.text = [NSString stringWithFormat:@"%.0f", value];
            }
        } else {
            NSRange range = [_countLabel.text rangeOfString:@"."];
            NSString *string = [_countLabel.text substringToIndex:range.location];
            NSString *str = [_countLabel.text substringWithRange:NSMakeRange(range.location + 1, _countLabel.text.length - range.location - 2)];
            NSInteger value = [str integerValue] + 1;
            _countLabel.text = [NSString stringWithFormat:@"%@.%ld万", string, value];
        }
        _countLabel.textColor = [UIColor redColor];
        _isTap = YES;
        
        if (_delegate) {
            // 请求服务器修改数据
        }
    } else {
        if (![_countLabel.text containsString:@"."]) {
            CGFloat value = [_countLabel.text floatValue] - 1;
            if (value > 9999) {
                _countLabel.text = [NSString stringWithFormat:@"%.1f万", value / 10000];
            } else {
                _countLabel.text = [NSString stringWithFormat:@"%.0f", value];
            }
        } else {
            NSRange range = [_countLabel.text rangeOfString:@"."];
            NSString *string = [_countLabel.text substringToIndex:range.location];
            NSString *str = [_countLabel.text substringWithRange:NSMakeRange(range.location + 1, _countLabel.text.length - range.location - 2)];
            NSInteger values = [string integerValue] * 10000 + [str integerValue];
            CGFloat value = values - 1;
            if (value > 9999) {
                _countLabel.text = [NSString stringWithFormat:@"%.1f万", value / 10000];
            } else {
                _countLabel.text = [NSString stringWithFormat:@"%.0f", value];
            }
        }

        _countLabel.textColor = [UIColor blackColor];
        _isTap = NO;
        
        if (_delegate) {
            // 请求服务器修改数据
        }
    }
  
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
