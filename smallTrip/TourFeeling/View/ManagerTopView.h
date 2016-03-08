//
//  ManagerTopView.h
//  smallTrip
//
//  Created by 唐桂樯 on 16/2/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TourModel;

@interface ManagerTopView : UIView

@property(nonatomic, strong) UIButton *imageButton;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *countLabel;

@property(nonatomic, strong) TourModel *tourModel;

@end
