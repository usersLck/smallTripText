//
//  OtherDestinationCell.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/4.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "OtherDestinationCell.h"

@implementation OtherDestinationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _CnNameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_CnNameLabel];
        
        _EnNameLabel = [[UILabel alloc] init];
        _EnNameLabel.alpha = 0.6;
        _EnNameLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_EnNameLabel];
    }
    return self;
}

- (void)setOtherModel:(OtherCountryModel *)otherModel {
    _otherModel = otherModel;
    _CnNameLabel.text = otherModel.cnname;
    _EnNameLabel.text = otherModel.enname;
    
    CGRect rect = [otherModel.cnname boundingRectWithSize:CGSizeMake(0, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    _CnNameLabel.frame = CGRectMake(KWIDTH/40, 0, rect.size.width, 44);
    _EnNameLabel.frame = CGRectMake(CGRectGetMaxX(_CnNameLabel.frame) + KWIDTH/35, 0, KWIDTH - rect.size.width - KWIDTH/20, 44);
}




@end
