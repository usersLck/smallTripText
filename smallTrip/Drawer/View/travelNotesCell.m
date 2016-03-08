//
//  travelNotesCell.m
//  rangeOfTourists
//
//  Created by  K-Dragon on 16/3/3.
//  Copyright © 2016年  K-Dragon. All rights reserved.
//

#import "travelNotesCell.h"

@implementation travelNotesCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 游记图片
        self.travelImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 395, 230)];
        [self.contentView addSubview:self.travelImage];
        // 游记标题
        self.travelNotesTitle = [[UILabel alloc] init];
        self.travelNotesTitle.textColor = [UIColor whiteColor];
        self.travelNotesTitle.font = [UIFont systemFontOfSize:21];
        [self.contentView addSubview:self.travelNotesTitle];
        // 旅游开始日期
        self.travelBeginDate = [[UILabel alloc] init];
        self.travelBeginDate.textColor = [UIColor whiteColor];
        self.travelBeginDate.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.travelBeginDate];
        // 旅游持续时间
        self.travelDays = [[UILabel alloc] init];
        self.travelDays.textColor = [UIColor whiteColor];
        self.travelDays.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.travelDays];
        // 游记浏览数
        self.readingNumbers = [[UILabel alloc] init];
        self.readingNumbers.textColor = [UIColor whiteColor];
        self.readingNumbers.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.readingNumbers];
        // 旅游目的地
        self.travelDestination = [[UILabel alloc] init];
        self.travelDestination.textColor = [UIColor whiteColor];
        self.travelDestination.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.travelDestination];
        // 竖线
        self.verticalLine = [[UILabel alloc] init];
        self.verticalLine.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:self.verticalLine];
        // 游记作者头像
        self.touristImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.touristImage];
        // 游记作者用户名
        self.touristName = [[UILabel alloc] init];
        self.touristName.textColor = [UIColor whiteColor];
        self.touristName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.touristName];
        
    }
    return self;
}
// 在layoutSubViews中根据travelNotesTitles的自适应高度进行子视图布局
- (void)layoutSubviews
{
    self.travelNotesTitle.frame = CGRectMake(30, 20, self.frame.size.width - 40, 0);
    self.travelNotesTitle.numberOfLines = 0;
    [self.travelNotesTitle sizeToFit];
    
    self.travelBeginDate.frame = CGRectMake(40, self.travelNotesTitle.frame.origin.y + self.travelNotesTitle.frame.size.height, 80, 20);
    
    self.travelDays.frame = CGRectMake(self.travelBeginDate.frame.origin.x + self.travelBeginDate.frame.size.width, self.travelBeginDate.frame.origin.y, 40, 20);
    
    self.readingNumbers.frame = CGRectMake(self.travelDays.frame.origin.x + self.travelDays.frame.size.width, self.travelDays.frame.origin.y, 100, 20);
    
    self.travelDestination.frame = CGRectMake(self.travelBeginDate.frame.origin.x, self.travelBeginDate.frame.origin.y + self.travelBeginDate.frame.size.height + 5, 200, 20);
    
    self.verticalLine.frame = CGRectMake(30, self.travelBeginDate.frame.origin.y + 3, 3, self.travelBeginDate.frame.size.height + self.travelDestination.frame.size.height);
    
    self.touristImage.frame = CGRectMake(self.travelBeginDate.frame.origin.x, 190, 50, 50);
    
    self.touristName.frame = CGRectMake(self.touristImage.frame.origin.x + self.touristImage.frame.size.width + 10, 200, 200, 30);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
