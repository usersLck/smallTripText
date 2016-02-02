//
//  ForumView.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/30.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "ForumView.h"

//  SegmentedControl中的问答专区页

@implementation ForumView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 200, 50)];
        [_button setTitle:@"问答专区" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_button];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
