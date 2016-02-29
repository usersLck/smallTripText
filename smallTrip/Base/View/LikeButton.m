//
//  LikeButton.m
//  smallTrip
//
//  Created by Aaslte on 16/1/28.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "LikeButton.h"

@interface LikeButton ()

@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, assign) BOOL isTap;

@end

@implementation LikeButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.isTap = NO;
        
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _likeButton.frame = CGRectMake(0, 0, frame.size.height, frame.size.height);
        [_likeButton setImage:[UIImage imageNamed:@"weather"] forState:UIControlStateNormal];
        [_likeButton addTarget:self action:@selector(doTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_likeButton];
        
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(_likeButton.frame.size.width + 10, 0, frame.size.width - _likeButton.frame.size.width - 10, frame.size.height)];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_countLabel];
    }
    return self;
}

- (void)doTap:(UIButton *)button {
    _countLabel.text = [self getString];
    if ([self viewController]) {
        // 请求服务器修改数据
    }
}


- (NSString *)getString {
    NSString *string = nil;
    
    if (![_countLabel.text containsString:@"."]) {
        CGFloat value = 0.0;
        if (!_isTap) {
            value = [_countLabel.text floatValue] + 1;
        } else {
            value = [_countLabel.text floatValue] - 1;
        }

        if (value > 9999) {
            string = [NSString stringWithFormat:@"%.1f万", value / 10000];
        } else {
            string = [NSString stringWithFormat:@"%.0f", value];
        }
    } else {
        NSRange range = [_countLabel.text rangeOfString:@"."];
        NSString *frontStr = [_countLabel.text substringToIndex:range.location];
        NSString *backStr = [_countLabel.text substringWithRange:NSMakeRange(range.location + 1, _countLabel.text.length - range.location - 2)];
        CGFloat backValue = 0.0;
        if (!_isTap) {
            backValue = [backStr floatValue] + 1;
        } else {
            backValue = [backStr floatValue] - 1;
        }
        CGFloat frontValue = [frontStr floatValue] * 10000;
        CGFloat value = frontValue + backValue;
        if (value > 9999) {
            string = [NSString stringWithFormat:@"%.1f万", value / 10000];
        } else {
            string = [NSString stringWithFormat:@"%.0f", value];
        }
    }
    
    if (!_isTap) {
        _countLabel.textColor = [UIColor redColor];
        _isTap = YES;
    } else {
        _countLabel.textColor = [UIColor blackColor];
        _isTap = NO;
    }
    
    return string;
}
// 获取响应链中的controller 用来调用模态方法
- (UIViewController *)viewController {
//    for (UIView *next = [self superview]; next; next = [next superview]) {
//        UIResponder *responder = [next nextResponder];
//        if ([responder isKindOfClass:[UIViewController class]]) {
//            return (UIViewController *)responder;
//        }
//    }
//    return nil;
    id object = [self nextResponder];
    while (![object isKindOfClass:[UIViewController class]] && object != nil) {
        object = [object nextResponder];
    }
    return (UIViewController *)object;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
