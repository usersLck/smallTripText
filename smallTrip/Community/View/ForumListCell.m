//
//  ForumListCell.m
//  smallTrip
//
//  Created by Aaslte on 16/2/25.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "ForumListCell.h"
#import "LikeButton.h"
@interface ForumListCell ()

@property (nonatomic, strong) UIButton *photo;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *timer;
@property (nonatomic, strong) LikeButton *likeButton;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *descriptions;

@end

@implementation ForumListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _photo = [UIButton buttonWithType:UIButtonTypeCustom];
        _photo.frame = CGRectMake(10, 10, BUTTONWIDTH, BUTTONWIDTH);
        [self.contentView addSubview:_photo];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(_photo.frame.size.width + 20, _photo.frame.origin.y, KWIDTH / 2, 20)];
        [self.contentView addSubview:_name];
        
        _timer = [[UILabel alloc] initWithFrame:CGRectMake(_name.frame.origin.x, CGRectGetMaxY(_name.frame), 200, 20)];
        _timer.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_timer];
        
        _likeButton = [[LikeButton alloc] initWithFrame:CGRectMake(KWIDTH - BUTTONWIDTH, 10, 30, 20)];
        [self.contentView addSubview:_likeButton];
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(_name.frame.origin.x, CGRectGetMaxY(_name.frame) + 30, KWIDTH - BUTTONWIDTH - 30, 30)];
        _title.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_title];
        
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
