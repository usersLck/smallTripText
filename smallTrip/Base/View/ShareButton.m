//
//  ShareButton.m
//  smallTrip
//
//  Created by Aaslte on 16/1/28.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "ShareButton.h"
#import "ViewController.h"
@interface ShareButton ()<UIAlertViewDelegate>

@property (nonatomic, assign) id delegate;

@end

@implementation ShareButton

/**
 *  分享button便利构造器
 *
 *  @param delegate 执行模态方法的代理
 *
 *  @return button对象
 */
- (id)initShareButton {
    // 创建button
    self = [ShareButton buttonWithType:UIButtonTypeCustom];
    // 给分享button设置图片
    [self setImage:[UIImage imageNamed:@"12"] forState:UIControlStateNormal];
    // 给分享button添加触发方法
    [self addTarget:self action:@selector(doTap:) forControlEvents:UIControlEventTouchUpInside];
    return self;
}

/**
 *  分享button的点击事件
 *
 *  @param button 被点击的button
 */
- (void)doTap:(UIButton *)button {
    // 获取本地user信息
    NSUserDefaults *uf = [NSUserDefaults standardUserDefaults];
    // 获取用户是否登录bool值
    BOOL isLogin = [uf boolForKey:@"login"];
    if (isLogin) {
        NSLog(@"用于已经登录，请调用第三方分享");
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您还未登录，是否登录帐号进行分享？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}

/**
 *  点击提示框触发事件
 *
 *  @param alertView   提示框
 *  @param buttonIndex 被点击的按钮
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSLog(@"用户选择要登录，请调用登录页面");
        id controller = [self viewController];
        if (controller) {
            // 模态到登录页面
            
        }
    }
}
// 寻找响应链上的controller 用来模态到新的界面
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
