//
//  SecondTourCell.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/2/24.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "SecondTourCell.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import "DetailTourModel.h"

@interface SecondTourCell ()
@property(nonatomic, strong) UIImageView *pictureImageView;// 图片
@property(nonatomic, strong) UILabel *titleLabel;// 标题
@end

@implementation SecondTourCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.pictureImageView = [[UIImageView alloc] init];
        _pictureImageView.image = [UIImage imageNamed:@"test.png"];
        [self insertSubview:_pictureImageView atIndex:0];

        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:19];
        [self.contentView addSubview:_titleLabel];
        
        [self cellRotation];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _pictureImageView.frame = CGRectMake(KWIDTH/80, 5, KWIDTH-KWIDTH/40, KHEIGHT/4 - 5);
    
    _titleLabel.frame = CGRectMake(self.headButton.frame.origin.x, self.headButton.frame.origin.y + self.headButton.bounds.size.height + 10, KWIDTH, KWIDTH/25);
     
    self.contentLabel.frame = CGRectMake(self.headButton.frame.origin.x, _titleLabel.frame.origin.y + _titleLabel.bounds.size.height , KWIDTH - 2 * self.headButton.frame.origin.x, 60);
   
    self.attentionButton.frame = CGRectMake(self.headButton.frame.origin.x, self.contentLabel.frame.origin.y + self.contentLabel.bounds.size.height + 10, KWIDTH/20, KWIDTH/20);
   
    self.commentButton.frame = CGRectMake(KWIDTH * 2 / 3, self.attentionButton.frame.origin.y, self.attentionButton.bounds.size.width, self.attentionButton.bounds.size.height);
    
    self.commentCountLabel.frame = CGRectMake(self.commentButton.frame.origin.x + self.commentButton.bounds.size.width + 5, self.attentionButton.frame.origin.y, KWIDTH/10, self.attentionButton.bounds.size.height);
    
    self.praiseButton.frame = CGRectMake(self.commentCountLabel.frame.origin.x + self.commentCountLabel.bounds.size.width, self.attentionButton.frame.origin.y, self.attentionButton.bounds.size.width, self.attentionButton.bounds.size.height);
    
    self.praiseCountLabel.frame = CGRectMake(self.praiseButton.frame.origin.x + self.praiseButton.bounds.size.width + 5, self.attentionButton.frame.origin.y, KWIDTH/10, self.attentionButton.bounds.size.height);
    
}

- (void)cellRotation {
    CATransform3D rotation;//3D旋转
    
    rotation = CATransform3DMakeTranslation(0 ,50 ,20);
    //                rotation = CATransform3DMakeRotation( M_PI_4 , 0.0, 0.7, 0.4);
    //逆时针旋
    rotation = CATransform3DScale(rotation, 0.9, .9, 1);
    rotation.m34 = 1.0/ -600;
    self.layer.shadowColor = [[UIColor blackColor]CGColor];
    self.layer.shadowOffset = CGSizeMake(10, 10);
    self.alpha = 0;
    self.layer.transform = rotation;
    [UIView beginAnimations:@"rotation" context:NULL];
    //旋转时间
    [UIView setAnimationDuration:0.6];
    self.layer.transform = CATransform3DIdentity;
    self.alpha = 1;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    //    }
    //    [cell cellOffset];
}

- (void)setTourModel:(TourModel *)tourModel {
    _tourModel = tourModel;
    [self.headButton sd_setImageWithURL:[NSURL URLWithString:tourModel.photo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"header.png"]];
    self.nameLabel.text = tourModel.userName;
    self.dateLabel.text = [tourModel.time substringToIndex:10];
    self.titleLabel.text = tourModel.name;
    self.commentCountLabel.text = tourModel.commentNumber;
    self.praiseCountLabel.text = tourModel.goodNumber;
    for (DetailTourModel *detailModel in tourModel.listArr) {
        if ([detailModel.type isEqualToString:@"2"]) {
            [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.description0] placeholderImage:nil];
        } else {
            self.contentLabel.text = detailModel.description0;
        }
    }
}

@end
