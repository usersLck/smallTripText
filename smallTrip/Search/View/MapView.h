//
//  MapView.h
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/3.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MapView : UIView

@property(nonatomic, strong, readonly) UIImageView *mapImageV;
@property(nonatomic, strong, readonly) UIButton *AsiaButton;// 亚洲
@property(nonatomic, strong, readonly) UIButton *EuropeButton;// 欧洲
@property(nonatomic, strong, readonly) UIButton *NorthAmericaButton;// 北美洲
@property(nonatomic, strong, readonly) UIButton *SouthAmericaButton;// 南美洲
@property(nonatomic, strong, readonly) UIButton *AfricaButton;// 非洲
@property(nonatomic, strong, readonly) UIButton *OceaniaButton;// 大洋洲
@property(nonatomic, strong, readonly) UIButton *AntarcticaButton;// 南极洲
@property(nonatomic, strong, readonly) UILabel *hottitleLabel;// 热门目的地
@property(nonatomic, strong, readonly) UIImageView *imageV;

@property (nonatomic, strong) NSMutableArray *buttonArr;

/**
 *  外界点击button后改变button的状态
 *
 *  @param button button
 */
- (void)setButtonState:(UIButton *)button;



@end
