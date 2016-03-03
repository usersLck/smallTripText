//
//  FirstTourCell.h
//  smallTrip
//
//  Created by 唐桂樯 on 16/2/24.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstTourCell : UITableViewCell

@property(nonatomic, strong) UIButton *headButton;// 头像
@property(nonatomic, strong) UIImageView *headImageView;// 头像
@property(nonatomic, strong) UILabel *nameLabel;// 昵称
@property(nonatomic, strong) UILabel *dateLabel;// 发表时间
//@property(nonatomic, strong) UIImageView *pictureImageView;// 图片
//@property(nonatomic, strong) UILabel *titleLabel;// 标题
@property(nonatomic, strong) UILabel *contentLabel;// 内容
@property(nonatomic, strong) UIButton *attentionButton;// 关注
@property(nonatomic, strong) UIButton *commentButton;// 评论
@property(nonatomic, strong) UIButton *praiseButton;// 点赞

@property(nonatomic, strong) UILabel *commentCountLabel;// 评论数
@property(nonatomic, strong) UILabel *praiseCountLabel;// 点赞数




@end
