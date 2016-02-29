//
//  SecondTourCell.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/2/24.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "SecondTourCell.h"

@implementation SecondTourCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.pictureImageView = [[UIImageView alloc] init];
        _pictureImageView.image = [UIImage imageNamed:@"test.png"];
        [self insertSubview:_pictureImageView atIndex:0];

        
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"标题";
        _titleLabel.font = [UIFont systemFontOfSize:19];
        [self.contentView addSubview:_titleLabel];
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _pictureImageView.frame = CGRectMake(KWIDTH/80, 0, KWIDTH-KWIDTH/40, KHEIGHT/4);
    
//    _titleLabel.frame = CGRectMake(self.headImageView.frame.origin.x, _pictureImageView.frame.origin.y + _pictureImageView.bounds.size.height + 5, KWIDTH, KWIDTH/20);
 
    _titleLabel.frame = CGRectMake(self.headImageView.frame.origin.x, self.headImageView.frame.origin.y + self.headImageView.bounds.size.height + 5, KWIDTH, KWIDTH/25);
     
    self.contentLabel.frame = CGRectMake(self.headImageView.frame.origin.x, _titleLabel.frame.origin.y + _titleLabel.bounds.size.height , KWIDTH - 2 * self.headImageView.frame.origin.x, 60);
   
    self.attentionButton.frame = CGRectMake(self.headImageView.frame.origin.x, self.contentLabel.frame.origin.y + self.contentLabel.bounds.size.height + 10, KWIDTH/20, KWIDTH/20);
   
    self.commentButton.frame = CGRectMake(KWIDTH * 2 / 3, self.attentionButton.frame.origin.y, self.attentionButton.bounds.size.width, self.attentionButton.bounds.size.height);
    
    self.commentCountLabel.frame = CGRectMake(self.commentButton.frame.origin.x + self.commentButton.bounds.size.width, self.attentionButton.frame.origin.y, KWIDTH/10, self.attentionButton.bounds.size.height);
    
    self.praiseButton.frame = CGRectMake(self.commentCountLabel.frame.origin.x + self.commentCountLabel.bounds.size.width, self.attentionButton.frame.origin.y, self.attentionButton.bounds.size.width, self.attentionButton.bounds.size.height);
    
    self.praiseCountLabel.frame = CGRectMake(self.praiseButton.frame.origin.x + self.praiseButton.bounds.size.width, self.attentionButton.frame.origin.y, KWIDTH/10, self.attentionButton.bounds.size.height);
    
}

- (void)cellRotation {
    CATransform3D rotation;//3D旋转
    
    rotation = CATransform3DMakeTranslation(0 ,50 ,20);
    //                rotation = CATransform3DMakeRotation( M_PI_4 , 0.0, 0.7, 0.4);
    //逆时针旋转
    
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
