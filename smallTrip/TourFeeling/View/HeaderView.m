//
//  HeaderView.m
//  smallTrip
//
//  Created by 纪宇驰 on 16/3/3.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // 创建小图标
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width / 40, 0, self.bounds.size.width / 10, self.bounds.size.height)];
        self.imageView.backgroundColor = [UIColor BACKCOLOR];
        self.imageView.image = [UIImage imageNamed:@"location"];
        self.imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:self.imageView];
        // 创建地名按钮
        self.placeNameButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.placeNameButton.frame = CGRectMake(self.imageView.frame.origin.x + self.imageView.bounds.size.width, 0, self.bounds.size.width / 8 * 5 - self.imageView.bounds.size.width, self.bounds.size.height);
        [self.placeNameButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.placeNameButton.backgroundColor = [UIColor BACKCOLOR];
        self.placeNameButton.titleLabel.font = [UIFont systemFontOfSize:20];
        self.placeNameButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.placeNameButton];
        
        // 创建加号按钮
        self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addButton.frame = CGRectMake(self.bounds.size.width / 4 * 3, 0, self.bounds.size.width / 4, self.bounds.size.height);
        self.addButton.backgroundColor = [UIColor BACKCOLOR];
        [self.addButton setImage:[UIImage imageNamed:@"addModule"] forState:UIControlStateNormal];
        [self addSubview:self.addButton];
        
        
    }
    
    return self;
}


@end
