//
//  PhotoTextCell.m
//  smallTrip
//
//  Created by 刘常凯 on 16/2/19.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "PhotoTextCell.h"

@implementation PhotoTextCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andtype:(BOOL)type{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _images = [[UIImageView alloc] initWithFrame:CGRectMake(BUTTONHEIGHT, BUTTONHEIGHT / 2, KWIDTH - 2 * BUTTONHEIGHT, KHEIGHT / 3 * 1.3)];
        [self.contentView addSubview:_images];
        
        if (type) {
            _manageView = [[UIView alloc] initWithFrame:CGRectMake(_images.frame.origin.x, _images.frame.origin.y + _images.bounds.size.height, _images.bounds.size.width, BUTTONHEIGHT)];
        }else{
            _manageView = [[UIView alloc] initWithFrame:CGRectMake(_images.frame.origin.x, _images.frame.origin.y + _images.bounds.size.height - BUTTONHEIGHT, _images.bounds.size.width, BUTTONHEIGHT)];
        }
        _manageView.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:_manageView];
        
    }
    return self;
}

@end
