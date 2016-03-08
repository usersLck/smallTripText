//
//  TopReusableView.h
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/5.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScrollModel;
@class TopScrollView;

@interface TopReusableView : UICollectionReusableView

@property(nonatomic, strong) UIButton *backButton;
@property(nonatomic, strong) UIButton *moreButton;
@property(nonatomic, strong) ScrollModel *scrollModel;
@property(nonatomic, strong) TopScrollView *scrollView;

@end
