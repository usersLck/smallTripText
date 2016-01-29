//
//  ShareButton.h
//  smallTrip
//
//  Created by Aaslte on 16/1/28.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareButton : UIButton

// 初始化方法
- (id)initShareButton;

/*
    分享按钮用法：
            ShareButton *button = [ShareButton alloc] initShareButton];
            button.frame = CGRectMake(100, 100, 40, 30);
            [self.view addSubview:button];
 
 分享按钮添加在ImageView上时，应该打开ImageView的交互
*/
@end
