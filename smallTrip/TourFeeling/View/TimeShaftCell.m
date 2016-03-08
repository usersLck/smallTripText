//
//  TimeShaftCell.m
//  smallTrip
//
//  Created by 纪宇驰 on 16/3/7.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TimeShaftCell.h"

@implementation TimeShaftCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width / 10, 0, self.bounds.size.width / 10, self.bounds.size.height)];
        imageV.image = [UIImage imageNamed:@"point16"];
        imageV.backgroundColor = [UIColor clearColor];
        imageV.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:imageV];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(imageV.frame.origin.x + imageV.bounds.size.width, 0, self.bounds.size.width / 5 * 4, self.bounds.size.height)];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.label];
        
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
