//
//  LikeButton.h
//  smallTrip
//
//  Created by Aaslte on 16/1/28.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LikeButton : UIView

@property (nonatomic, strong) UILabel *countLabel;
- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate;

@end
