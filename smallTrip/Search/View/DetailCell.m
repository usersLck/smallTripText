
//
//  DetailCell.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/6.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "DetailCell.h"
#import "ScenicDetailModel.h"

@interface DetailCell ()

/**
 *  城市中文名
 */
@property (nonatomic, strong) UILabel *cityCnname;
/**
 *  城市英文名
 */
@property (nonatomic, strong) UILabel *cityEnname;
/**
 *  多少人去过
 */
@property (nonatomic, strong) UILabel *beentoCount;
/**
 *  简介标题
 */
@property (nonatomic, strong) UILabel *introduceTitle;
/**
 *  简介详情
 */
@property (nonatomic, strong) UILabel *introduceDetail;
/**
 *  地址标题
 */
@property (nonatomic, strong) UILabel *addressTitle;
/**
 *  地址详情
 */
@property (nonatomic, strong) UILabel *addressDetail;
/**
 *  线路标题
 */
@property (nonatomic, strong) UILabel *routTitle;
/**
 *  线路详情
 */
@property (nonatomic, strong) UILabel *routDetail;
/**
 *  时间标题
 */
@property (nonatomic, strong) UILabel *timeTitle;
/**
 *  时间详情
 */
@property (nonatomic, strong) UILabel *timeDetail;
/**
 *  门票标题
 */
@property (nonatomic, strong) UILabel *ticketTitle;
/**
 *  门票详情
 */
@property (nonatomic, strong) UILabel *ticketDetail;
/**
 *  小贴士标题
 */
@property (nonatomic, strong) UILabel *tipsTitle;
/**
 *  小贴士详情
 */
@property (nonatomic, strong) UILabel *tipsDetail;

@end

@implementation DetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _cityCnname = [[UILabel alloc] init];
        _cityEnname = [[UILabel alloc] init];
        _introduceTitle = [[UILabel alloc] init];
        _introduceDetail = [[UILabel alloc] init];
        _addressTitle = [[UILabel alloc] init];
        _addressDetail = [[UILabel alloc] init];
        _routTitle = [[UILabel alloc] init];
        _routDetail = [[UILabel alloc] init];
        _timeTitle = [[UILabel alloc] init];
        _timeDetail = [[UILabel alloc] init];
        _ticketTitle = [[UILabel alloc] init];
        _ticketDetail = [[UILabel alloc] init];
        _tipsTitle = [[UILabel alloc] init];
        _tipsDetail = [[UILabel alloc] init];
        _beentoCount = [[UILabel alloc] init];
        
        _cityCnname.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_cityCnname];
        _cityEnname.font = [UIFont systemFontOfSize:15];
        _cityEnname.textColor = [UIColor grayColor];
        [self.contentView addSubview:_cityEnname];
        _beentoCount.font = [UIFont systemFontOfSize:15];
        _beentoCount.textColor = [UIColor grayColor];
        _beentoCount.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_beentoCount];
        
        NSArray *arr = @[_introduceTitle, _introduceDetail, _addressTitle, _addressDetail, _routTitle, _routDetail, _timeTitle, _timeDetail, _ticketTitle, _ticketDetail, _tipsTitle, _tipsDetail];
        NSArray *titleArr = @[@"简介", @"地址", @"线路", @"时间", @"门票", @"小贴士"];
        for (int i = 0; i < arr.count; i++) {
            [self.contentView addSubview:arr[i]];
            if (i % 2 == 0) {
                ((UILabel *)arr[i]).textColor = [UIColor blackColor];
                ((UILabel *)arr[i]).text = titleArr[i/2];
            } else {
                ((UILabel *)arr[i]).textColor = [UIColor grayColor];
                ((UILabel *)arr[i]).font = [UIFont systemFontOfSize:15];
                ((UILabel *)arr[i]).numberOfLines = 0;
            }
        }
        _tipsTitle.textColor = [UIColor redColor];
    }
    return self;
}

- (void)setDetailModel:(ScenicDetailModel *)detailModel {
    _detailModel = detailModel;
    _cityCnname.text = detailModel.chinesename;
    _cityEnname.text = detailModel.englishname;
    _beentoCount.text = [NSString stringWithFormat:@"%@人去过", detailModel.beentocounts];
    _introduceDetail.text = detailModel.introduction;
    _addressDetail.text = detailModel.address;
    _routDetail.text = detailModel.wayto;
    _timeDetail.text = detailModel.opentime;
    _ticketDetail.text = detailModel.price;
    _tipsDetail.text = detailModel.tips;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _cityCnname.frame = CGRectMake(KWIDTH/40, KWIDTH/40, KWIDTH - KWIDTH/20, 30);
    _cityEnname.frame = CGRectMake(KWIDTH/40, CGRectGetMaxY(_cityCnname.frame), KWIDTH - KWIDTH/20, 30);
    _beentoCount.frame = CGRectMake(KWIDTH/2, KWIDTH/30, KWIDTH/2-10, 25);
    NSArray *arr = @[_introduceTitle, _introduceDetail, _addressTitle, _addressDetail, _routTitle, _routDetail, _timeTitle, _timeDetail, _ticketTitle, _ticketDetail, _tipsTitle, _tipsDetail];
    for (int i = 0; i < arr.count; i++) {
        if (i % 2 == 0) {
            if (i == 0) {
                ((UILabel *)arr[i]).frame = CGRectMake(KWIDTH/40, CGRectGetMaxY(_cityEnname.frame) + 30, KWIDTH - KWIDTH/20, 30);
            } else {
                ((UILabel *)arr[i]).frame = CGRectMake(KWIDTH/40, CGRectGetMaxY(((UILabel *)arr[i-1]).frame) + 20, KWIDTH - KWIDTH/20, 30);
            }
        } else {
            CGFloat height = [self calculateHeightWithString:((UILabel *)arr[i]).text];
            ((UILabel *)arr[i]).frame = CGRectMake(KWIDTH/40, CGRectGetMaxY(((UILabel *)arr[i-1]).frame), KWIDTH - KWIDTH/20, height);
        }
    }
}

- (CGFloat)calculateHeightWithString:(NSString *)string {
    CGRect rect = [string boundingRectWithSize:CGSizeMake(KWIDTH - KWIDTH/20, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
    return rect.size.height;
}








@end



