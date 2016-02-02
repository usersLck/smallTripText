//
//  tabbarView.h
//  smallTrip
//
//  Created by 刘常凯 on 16/1/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabbarView : UIView


@property (nonatomic, assign)id delegate;

- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id)delegate;

@end
