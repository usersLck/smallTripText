//
//  ScenicCell.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/5.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "ScenicCell.h"
#import "DetailModel.h"
#import <UIImageView+WebCache.h>
#import "FXLabel.h"

@interface ScenicCell ()

@property(nonatomic, strong) UIImageView *imageV;
@property(nonatomic, strong) UILabel *cnName;
@property(nonatomic, strong) UILabel *enName;
@property(nonatomic, strong) UILabel *countLabel;
@property(nonatomic, strong) UILabel *outline;// 概要

@end

@implementation ScenicCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [self.contentView addSubview:_imageV];
//        _cnName = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/3, self.bounds.size.height/3, self.bounds.size.width/3, self.bounds.size.height/6)];
//        _cnName.textAlignment = NSTextAlignmentCenter;
//        [self.contentView addSubview:_cnName];
        
        _enName = [[UILabel alloc] initWithFrame:CGRectMake(_cnName.frame.origin.x, CGRectGetMaxY(_cnName.frame), CGRectGetWidth(_cnName.frame), CGRectGetHeight(_cnName.frame))];
        _enName.font = [UIFont systemFontOfSize:13];
        _enName.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_enName];
        
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/10, CGRectGetMaxY(_enName.frame)+10, self.bounds.size.width - self.bounds.size.width/5, self.bounds.size.height/5)];
        _countLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_countLabel];
        
        _outline = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH/20, CGRectGetMaxY(_enName.frame), KWIDTH - KWIDTH/10, 30)];
        [self.contentView addSubview:_outline];
        
        FXLabel *label = [[FXLabel alloc] init];
        label.frame = CGRectMake(self.bounds.size.width/3, self.bounds.size.height/3, self.bounds.size.width/3, self.bounds.size.height/6);
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        label.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.2f];
        label.shadowOffset = CGSizeMake(0.0f, 2.0f);
        label.shadowBlur = 5.0f;
        _cnName = label;
        [self.contentView addSubview:_cnName];
        _cnName.textAlignment = NSTextAlignmentCenter;
        _cnName.textColor = [UIColor whiteColor];
        _enName.textColor = [UIColor whiteColor];
        _countLabel.textColor = [UIColor whiteColor];

    }
    return self;
}

- (void)setDetailModel:(DetailModel *)detailModel {
    _detailModel = detailModel;
    _cnName.text = detailModel.catename;
    _enName.text = detailModel.catename_en;
    _countLabel.text = detailModel.beenstr;
    [_imageV sd_setImageWithURL:[NSURL URLWithString:detailModel.photo] placeholderImage:[UIImage imageNamed:@"place"]];
    CGFloat width = [self caculateWidthWithString:detailModel.catename height:self.bounds.size.height font:17];
    _cnName.frame = CGRectMake((self.bounds.size.width - width)/2, self.bounds.size.height/3, width, self.bounds.size.height/6);
    
    CGFloat width2 = [self caculateWidthWithString:detailModel.catename_en height:CGRectGetHeight(_cnName.frame) font:13];
    _enName.frame = CGRectMake((self.bounds.size.width - width2)/2, CGRectGetMaxY(_cnName.frame), width2, CGRectGetHeight(_cnName.frame) - 10);
    
    CGFloat width3 = [self caculateWidthWithString:detailModel.beenstr height:CGRectGetHeight(_enName.frame)+10 font:12];
    _countLabel.frame = CGRectMake((self.bounds.size.width - width3)/2, CGRectGetMaxY(_enName.frame)+10, width3, CGRectGetHeight(_enName.frame));
    
}
- (CGFloat)caculateWidthWithString:(NSString *)string height:(CGFloat)height font:(CGFloat)font {
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width;
}

@end
