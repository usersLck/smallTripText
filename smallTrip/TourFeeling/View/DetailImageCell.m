//
//  DetailImageCell.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/2.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "DetailImageCell.h"
#import <UIImageView+WebCache.h>
#import "DetailTourModel.h"

@implementation DetailImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor blackColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_imageV];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _imageV.frame = CGRectMake(KWIDTH/40, KWIDTH/40, KWIDTH - KWIDTH/20, self.bounds.size.height - KWIDTH/20);
}

- (void)setDetailModel:(DetailTourModel *)detailModel {
    _detailModel = detailModel;
    [_imageV sd_setImageWithURL:[NSURL URLWithString:detailModel.description0] placeholderImage:nil];
}

@end
