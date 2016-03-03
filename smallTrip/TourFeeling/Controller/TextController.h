//
//  TextController.h
//  smallTrip
//
//  Created by 纪宇驰 on 16/2/25.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextController : UIViewController

@property (nonatomic, strong)UITextView *textView;
// 接收文本
@property (nonatomic, strong)NSString *text;
// 作为回传数据的标志
@property (nonatomic, strong)NSString *key;
// 分区标志
@property (nonatomic, strong)NSString *section;


@end
