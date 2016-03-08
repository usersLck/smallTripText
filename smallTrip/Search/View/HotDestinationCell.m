//
//  HotDestinationCell.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/3.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "HotDestinationCell.h"
#import <UIButton+WebCache.h>
#import "BigModel.h"

@implementation HotDestinationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _button1 = [[CustomButton alloc] initWithFrame:CGRectMake(KWIDTH/40, 10, KWIDTH/2 - KWIDTH/40-KWIDTH/80,  KHEIGHT/3 -20)];
        
        _button2 = [[CustomButton alloc] initWithFrame:CGRectMake(KWIDTH/2+KWIDTH/80, _button1.frame.origin.y, _button1.bounds.size.width, _button1.bounds.size.height)];
//        _button1.tag = 2000;
//        _button2.tag = 2001;
        [self.contentView addSubview:_button1];
        [self.contentView addSubview:_button2];
        
        
    }
    return self;
}
// 配置cell
- (void)configuireHotDestinationCellByModelArr:(NSArray *)modelArr withTag:(NSInteger)tag {
    if (modelArr.count < 2) {
        [_button1 sd_setBackgroundImageWithURL:[NSURL URLWithString:((HotCountryModel *)modelArr[0]).photo] forState:UIControlStateNormal placeholderImage:nil];
        [_button2 sd_setBackgroundImageWithURL:nil forState:UIControlStateNormal placeholderImage:nil];
        [self configuireButtonLabelByArr:modelArr];
        
    } else {
        [_button1 sd_setBackgroundImageWithURL:[NSURL URLWithString:((HotCountryModel *)modelArr[0]).photo] forState:UIControlStateNormal placeholderImage:nil];
        
        [_button2 sd_setBackgroundImageWithURL:[NSURL URLWithString:((HotCountryModel *)modelArr[1]).photo] forState:UIControlStateNormal placeholderImage:nil];
        
        [self configuireButtonLabelByArr:modelArr];
    }
    }
// 配置button
- (void)configuireButtonLabelByArr:(NSArray *)arr {
    if (arr.count < 2) {
        HotCountryModel *model1 = arr[0];
        [self configuireButton:_button1 ByModel:model1];
        [self configuireButton:_button2 ByModel:nil];
    } else {
        HotCountryModel *model1 = arr[0];
        [self configuireButton:_button1 ByModel:model1];
        
        HotCountryModel *model2 = arr[1];
        [self configuireButton:_button2 ByModel:model2];
    }
}
// button上label文字的显示
- (void)configuireButton:(CustomButton *)button ByModel:(HotCountryModel *)model {
    if (model == nil) {
        button.countLabel.text = @"";
        button.countLabel.backgroundColor = [UIColor clearColor];
    } else {
        button.countLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        NSString *countStr = [NSString stringWithFormat:@" %@ %@ ", model.count, model.label];
        button.countLabel.text = countStr;
        button.countryCn.text = model.cnname;
        button.countryEn.text = model.enname;
        [self calculateButton:button ByString:countStr];
    }
}

// label自适应宽度
- (void)calculateButton:(CustomButton *)button ByString:(NSString *)str {
    CGRect rect1 = [str boundingRectWithSize:CGSizeMake(0, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    button.countLabel.frame = CGRectMake(button.bounds.size.width - rect1.size.width - 10, 10, rect1.size.width, 44);
}



@end
