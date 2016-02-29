//
//  FirstTourCell.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/2/24.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "FirstTourCell.h"

@implementation FirstTourCell
/*
@property(nonatomic, strong) UIImageView *headImageView;// 头像
@property(nonatomic, strong) UILabel *nameLabel;// 昵称
@property(nonatomic, strong) UILabel *dateLabel;// 发表时间
//@property(nonatomic, strong) UIImageView *pictureImageView;// 图片
//@property(nonatomic, strong) UILabel *titleLabel;// 标题
@property(nonatomic, strong) UILabel *contentLabel;// 内容
@property(nonatomic, strong) UIButton *attentionButton;// 关注
@property(nonatomic, strong) UIButton *commentButton;// 评论
@property(nonatomic, strong) UIButton *praiseButton;// 点赞
*/

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH/40, KWIDTH/40, KWIDTH/10, KWIDTH/10)];
        _headImageView.backgroundColor = [UIColor yellowColor];
        _headImageView.layer.cornerRadius = _headImageView.bounds.size.width / 2;// 圆形展示头像
        [self.contentView addSubview:_headImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_headImageView.frame.origin.x + _headImageView.bounds.size.width + 5, _headImageView.frame.origin.y, KWIDTH/2, _headImageView.bounds.size.height/2)];
        _nameLabel.text = @"昵称";
        [self.contentView addSubview:_nameLabel];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.origin.y + _nameLabel.bounds.size.height, _nameLabel.bounds.size.width, _nameLabel.bounds.size.height)];
        NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:10];
        _dateLabel.text = [NSString stringWithFormat:@"几分钟前"];
        _dateLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_dateLabel];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_headImageView.frame.origin.x, _headImageView.frame.origin.y + _headImageView.bounds.size.height + 5, KWIDTH - 2 * _headImageView.frame.origin.x, 60)];
        _contentLabel.text = @"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
        _contentLabel.numberOfLines = 0;
        [_contentLabel sizeToFit];
        [self.contentView addSubview:_contentLabel];
        
        self.attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _attentionButton.frame = CGRectMake(_headImageView.frame.origin.x, _contentLabel.frame.origin.y + _contentLabel.bounds.size.height + 10, KWIDTH/20, KWIDTH/20);
        [_attentionButton setBackgroundImage:[UIImage imageNamed:@"shoucang.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:_attentionButton];
        
        self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.frame = CGRectMake(KWIDTH *2/ 3, _attentionButton.frame.origin.y, _attentionButton.bounds.size.width, _attentionButton.bounds.size.height);
        [_commentButton setBackgroundImage:[UIImage imageNamed:@"pinglun.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:_commentButton];
        
        self.commentCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(_commentButton.frame.origin.x + _commentButton.bounds.size.width, _attentionButton.frame.origin.y, KWIDTH/10, KWIDTH/10)];
        _commentCountLabel.text = @"888";
        [self.contentView addSubview:_commentCountLabel];
        
        
        self.praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _praiseButton.frame = CGRectMake(_commentCountLabel.frame.origin.x + _commentCountLabel.bounds.size.width, _attentionButton.frame.origin.y, _attentionButton.bounds.size.width, _attentionButton.bounds.size.height);
        [_praiseButton setBackgroundImage:[UIImage imageNamed:@"dianzan.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:_praiseButton];
        
        self.praiseCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(_praiseButton.frame.origin.x + _praiseButton.bounds.size.width, _attentionButton.frame.origin.y, KWIDTH/10, KWIDTH/10)];
        _praiseCountLabel.text = @"1232222";
        [self.contentView addSubview:_praiseCountLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.headImageView.frame = CGRectMake(KWIDTH/40, KWIDTH/40, KWIDTH/10, KWIDTH/10);
    
    self.nameLabel.frame = CGRectMake(_headImageView.frame.origin.x + _headImageView.bounds.size.width + 5, _headImageView.frame.origin.y, KWIDTH/2, _headImageView.bounds.size.height/2);

    self.dateLabel.frame = CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.origin.y + _nameLabel.bounds.size.height, _nameLabel.bounds.size.width, _nameLabel.bounds.size.height);
    
    
    self.contentLabel.frame = CGRectMake(_headImageView.frame.origin.x, _headImageView.frame.origin.y + _headImageView.bounds.size.height + 5, KWIDTH - 2 * _headImageView.frame.origin.x, 60);
    
    
    self.attentionButton.frame = CGRectMake(_headImageView.frame.origin.x, _contentLabel.frame.origin.y + _contentLabel.bounds.size.height + 10, KWIDTH/20, KWIDTH/20);
    
    
    
    self.commentButton.frame = CGRectMake(KWIDTH * 2 / 3, _attentionButton.frame.origin.y, _attentionButton.bounds.size.width, _attentionButton.bounds.size.height);
    
    
    self.commentCountLabel.frame = CGRectMake(_commentButton.frame.origin.x + _commentButton.bounds.size.width, _attentionButton.frame.origin.y, KWIDTH/10, _attentionButton.bounds.size.height);
    
    
    
    self.praiseButton.frame = CGRectMake(_commentCountLabel.frame.origin.x + _commentCountLabel.bounds.size.width, _attentionButton.frame.origin.y, _attentionButton.bounds.size.width, _attentionButton.bounds.size.height);
    
    
    self.praiseCountLabel.frame = CGRectMake(_praiseButton.frame.origin.x + _praiseButton.bounds.size.width, _attentionButton.frame.origin.y, KWIDTH/10, _attentionButton.bounds.size.height);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
