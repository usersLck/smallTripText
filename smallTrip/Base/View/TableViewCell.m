//
//  TableViewCell.m
//  smallTrip
//
//  Created by Aaslte on 16/1/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TableViewCell.h"
#import "ShareButton.h"
#import <UIImageView+WebCache.h>

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imageViews = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        [_imageViews sd_setImageWithURL:[NSURL URLWithString:@"http://i2.sinaimg.cn/gm/2014/1231/U8776P115DT20141231160820.jpg"]];
        _imageViews.userInteractionEnabled = YES;
        ShareButton *button = [[ShareButton alloc] initShareButton];
        button.frame = CGRectMake(0, 0, 40, 30);
        [_imageViews addSubview:button];
        [self addSubview:_imageViews];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
