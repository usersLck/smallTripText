//
//  DetailTextCell.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/2.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "DetailTextCell.h"
#import "DetailTourModel.h"

@implementation DetailTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor blackColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_label];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _label.frame = CGRectMake(KWIDTH/40, KWIDTH/40, KWIDTH - KWIDTH/20, self.bounds.size.height - KWIDTH/20);
}

- (void)setDetailModel:(DetailTourModel *)detailModel {
    _detailModel = detailModel;
    _label.text = detailModel.description0;
}

@end
