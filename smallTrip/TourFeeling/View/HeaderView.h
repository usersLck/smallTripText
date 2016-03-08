//
//  HeaderView.h
//  smallTrip
//
//  Created by 纪宇驰 on 16/3/3.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UICollectionReusableView

// 小图标
@property (nonatomic, strong)UIImageView *imageView;
// 地名label
@property (nonatomic, strong)UIButton *placeNameButton;
// 添加按钮
@property (nonatomic, strong)UIButton *addButton;


@end
