//
//  travelNotesCell.h
//  rangeOfTourists
//
//  Created by  K-Dragon on 16/3/3.
//  Copyright © 2016年  K-Dragon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface travelNotesCell : UITableViewCell
@property (nonatomic, strong) UIImageView *travelImage; // 游记展示图片
@property (nonatomic, strong) UILabel *travelNotesTitle; // 游记标题
@property (nonatomic, strong) UILabel *verticalLine; // 竖分割线
@property (nonatomic, strong) UILabel *travelBeginDate; // 旅行开始日期
@property (nonatomic, strong) UILabel *travelDays; // 旅行天数
@property (nonatomic, strong) UILabel *readingNumbers; // 游记阅读数
@property (nonatomic, strong) UILabel *travelDestination; // 旅游目的地
@property (nonatomic, strong) UILabel *touristName; // 用户名
@property (nonatomic, strong) UIImageView *touristImage; // 用户头像
@end
