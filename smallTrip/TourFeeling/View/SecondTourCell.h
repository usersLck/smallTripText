//
//  SecondTourCell.h
//  smallTrip
//
//  Created by 唐桂樯 on 16/2/24.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "FirstTourCell.h"

@interface SecondTourCell : FirstTourCell
@property(nonatomic, strong) UIImageView *pictureImageView;// 图片
@property(nonatomic, strong) UILabel *titleLabel;// 标题

- (void)cellRotation;

@end
