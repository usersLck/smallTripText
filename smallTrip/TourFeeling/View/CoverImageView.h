//
//  CoverImageView.h
//  smallTrip
//
//  Created by 纪宇驰 on 16/3/8.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FXLabel;


@interface CoverImageView : UIView

// 背景图片
@property (nonatomic, strong)UIImageView *imageV;
// 标题
@property (nonatomic, strong)FXLabel *titleLabel;
// 副标题
@property (nonatomic, strong)UILabel *secondTitleLabel;




@end
