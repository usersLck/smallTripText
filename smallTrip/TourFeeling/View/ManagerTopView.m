//
//  ManagerTopView.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/2/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "ManagerTopView.h"

@implementation ManagerTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
//        self.backgroundColor = [UIColor orangeColor];
        
        _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imageButton setImage:[UIImage imageNamed:@"test"] forState:UIControlStateNormal];
        _imageButton.frame = CGRectMake(KWIDTH/40, KWIDTH/40, KWIDTH/8, KWIDTH/8);
        _imageButton.layer.cornerRadius = KWIDTH/16;
        [self addSubview:_imageButton];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageButton.frame) + KWIDTH/40, _imageButton.frame.origin.y, KWIDTH/2, _imageButton.bounds.size.height/2)];
        _nameLabel.text = @"test";
        [self addSubview:_nameLabel];
        
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageButton.frame) + KWIDTH/40, CGRectGetMaxY(_nameLabel.frame), KWIDTH/2, _imageButton.bounds.size.height/2)];
        _countLabel.text = @"test";
        [self addSubview:_countLabel];
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
