//
//  DiaryLTView.m
//  smallTrip
//
//  Created by 纪宇驰 on 16/2/14.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "DiaryLTView.h"

@implementation DiaryLTView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width / 3, self.bounds.size.height / 2)];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(self.bounds.size.width / 3, 0, self.bounds.size.width / 3 * 2, self.bounds.size.height / 2)];
        self.textField.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textField];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width / 3, self.bounds.size.height / 2, self.bounds.size.width / 3 * 2, self.bounds.size.height / 2)];
        [self addSubview:_imageView];
        
    }
    
    return self;
}





@end
