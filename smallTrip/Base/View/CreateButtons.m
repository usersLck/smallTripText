//
//  CreateButtons.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/31.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "CreateButtons.h"

@implementation CreateButtons

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame andNSArray:(NSArray *)array andDelegate:(id)delegate andTag:(NSInteger)tag{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i = 0; i < array.count; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 50 + 50 * i, 200, 50)];
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self addSubview:button];
            [button addTarget:delegate action:@selector(returnVc:) forControlEvents:UIControlEventTouchUpInside];
            if (tag) {
                button.tag = tag + i;
            }
        }
    }
    return self;
}

@end
