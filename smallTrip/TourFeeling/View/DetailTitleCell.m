//
//  DetailTitleCell.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/3.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "DetailTitleCell.h"



@implementation DetailTitleCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor blackColor];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:22];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor orangeColor];
        [self.contentView addSubview:_titleLabel];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(KWIDTH/20, 0, KWIDTH - KWIDTH/10, self.bounds.size.height);
}

- (void)setTourModel:(TourModel *)tourModel {
    _tourModel = tourModel;
    _titleLabel.text = tourModel.name;
}

@end
