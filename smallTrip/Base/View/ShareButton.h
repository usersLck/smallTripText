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
- (id)initShareButton:(id)delegate;

/*
    分享按钮用法：
            ShareButton *button = [ShareButton alloc] initShareButton:self];
            button.frame = CGRectMake(100, 100, 40, 30);
            [self.view addSubview:button];
*/
@end
