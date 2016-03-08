//
//  ManagerTopView.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/2/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "ManagerTopView.h"
#import "TourModel.h"
#import <UIButton+WebCache.h>
@implementation ManagerTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor orangeColor];
        
        _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageButton.frame = CGRectMake(KWIDTH/40, KWIDTH/40, KWIDTH/8, KWIDTH/8);
        _imageButton.layer.cornerRadius = KWIDTH/16;
        _imageButton.clipsToBounds = YES;
        [self addSubview:_imageButton];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageButton.frame) + KWIDTH/40, _imageButton.frame.origin.y, KWIDTH/2, _imageButton.bounds.size.height/2)];
        [self addSubview:_nameLabel];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageButton.frame) + KWIDTH/40, CGRectGetMaxY(_nameLabel.frame), KWIDTH/2, _imageButton.bounds.size.height/2)];
        [self addSubview:_dateLabel];
        
        
    }
    return self;
}

- (void)setTourModel:(TourModel *)tourModel {
    _tourModel = tourModel;
    [_imageButton sd_setImageWithURL:[NSURL URLWithString:tourModel.photo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"back"]];
    _nameLabel.text = tourModel.userName;
    _dateLabel.text = [tourModel.time substringToIndex:10];
}


@end
