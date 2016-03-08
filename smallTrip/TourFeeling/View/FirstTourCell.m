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
//        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH/40, KWIDTH/40, KWIDTH/10, KWIDTH/10)];
//        _headImageView.backgroundColor = [UIColor yellowColor];
//        _headImageView.layer.cornerRadius = _headImageView.bounds.size.width / 2;// 圆形展示头像
//        [self.contentView addSubview:_headImageView];
        
        _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _headButton.layer.cornerRadius = KWIDTH/20;
        _headButton.clipsToBounds = YES;
        [self.contentView addSubview:_headButton];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"昵称";
        [self.contentView addSubview:_nameLabel];
        
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_dateLabel];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
        _contentLabel.numberOfLines = 0;
        [_contentLabel sizeToFit];
        [self.contentView addSubview:_contentLabel];
        
        _attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_attentionButton setBackgroundImage:[UIImage imageNamed:@"shoucang.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:_attentionButton];
        
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentButton setBackgroundImage:[UIImage imageNamed:@"pinglun.png"] forState:UIControlStateNormal];
        
        [self.contentView addSubview:_commentButton];
        
        _commentCountLabel = [[UILabel alloc] init];
        _commentCountLabel.text = @"888";
        _commentCountLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:_commentCountLabel];
        
        
        _praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_praiseButton setBackgroundImage:[UIImage imageNamed:@"dianzan.png"] forState:UIControlStateNormal];
        [_praiseButton addTarget:self action:@selector(addParise:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_praiseButton];
        
        _praiseCountLabel = [[UILabel alloc] init];
        _praiseCountLabel.text = @"1232222";
        _praiseCountLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:_praiseCountLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    self.headImageView.frame = CGRectMake(KWIDTH/40, KWIDTH/40, KWIDTH/10, KWIDTH/10);
    self.headButton.frame = CGRectMake(KWIDTH/40, KWIDTH/40, KWIDTH/10, KWIDTH/10);
    
    self.nameLabel.frame = CGRectMake(_headButton.frame.origin.x + _headButton.bounds.size.width + 5, _headButton.frame.origin.y, KWIDTH/2, _headButton.bounds.size.height/2);

    self.dateLabel.frame = CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.origin.y + _nameLabel.bounds.size.height, _nameLabel.bounds.size.width, _nameLabel.bounds.size.height);
    
    
    self.contentLabel.frame = CGRectMake(_headButton.frame.origin.x, _headButton.frame.origin.y + _headButton.bounds.size.height + 5, KWIDTH - 2 * _headButton.frame.origin.x, 60);
    
    
    self.attentionButton.frame = CGRectMake(_headButton.frame.origin.x, _contentLabel.frame.origin.y + _contentLabel.bounds.size.height + 10, KWIDTH/20, KWIDTH/20);
    
    
    
    self.commentButton.frame = CGRectMake(KWIDTH * 2 / 3, _attentionButton.frame.origin.y, _attentionButton.bounds.size.width, _attentionButton.bounds.size.height);
    
    
    self.commentCountLabel.frame = CGRectMake(_commentButton.frame.origin.x + _commentButton.bounds.size.width + 5, _attentionButton.frame.origin.y, KWIDTH/10, _attentionButton.bounds.size.height);
    
    
    
    self.praiseButton.frame = CGRectMake(_commentCountLabel.frame.origin.x + _commentCountLabel.bounds.size.width , _attentionButton.frame.origin.y, _attentionButton.bounds.size.width, _attentionButton.bounds.size.height);
    
    
    self.praiseCountLabel.frame = CGRectMake(_praiseButton.frame.origin.x + _praiseButton.bounds.size.width + 5, _attentionButton.frame.origin.y, KWIDTH/10, _attentionButton.bounds.size.height);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)addParise:(UIButton *)button {
    NSLog(@"点赞");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
