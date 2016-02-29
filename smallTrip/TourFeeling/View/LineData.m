//
//  LineData.m
//  smallTrip
//
//  Created by 刘常凯 on 16/2/24.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "LineData.h"

@implementation LineData

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)array andType:(NSInteger *)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.topArray = [NSMutableArray array];
        self.secondArray = [NSMutableArray array];
        self.lastArray = [NSMutableArray array];
        for (int i = 0; i < 6; i++) {
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width / 6 * i , 0, frame.size.width / 6, frame.size.height / 3)];
            label1.backgroundColor = [UIColor greenColor];
            [self addSubview:label1];
            label1.textAlignment = NSTextAlignmentCenter;
            [self.topArray addObject:label1];
            if (type) {
                UILabel *view2 = [[UILabel alloc] initWithFrame:CGRectMake(label1.frame.origin.x, label1.frame.origin.y + label1.frame.size.height, label1.bounds.size.width, label1.bounds.size.height)];
                [self addSubview:view2];
                view2.backgroundColor = [UIColor blueColor];
                view2.textAlignment = NSTextAlignmentCenter;
                [self.secondArray addObject:view2];
            }else{
                UIImageView * view2 = [[UIImageView alloc] initWithFrame:CGRectMake(label1.frame.origin.x, label1.frame.origin.y + label1.frame.size.height, label1.bounds.size.height, label1.bounds.size.height)];
                [self addSubview:view2];
                view2.image = [UIImage imageNamed:@"weather"];
                view2.backgroundColor = [UIColor blueColor];
                [self.secondArray addObject:view2];
            }
            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(label1.frame.origin.x, frame.size.height * 2 / 3, label1.bounds.size.width, label1.bounds.size.height)];
            [self addSubview:label3];
            label3.backgroundColor = [UIColor purpleColor];
            label3.textAlignment = NSTextAlignmentCenter;
            [self.lastArray addObject:label3];
        }
    }
    return self;
}

@end
