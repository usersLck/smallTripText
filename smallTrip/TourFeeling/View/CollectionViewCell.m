//
//  CollectionViewCell.m
//  smallTrip
//
//  Created by 纪宇驰 on 16/2/24.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        self.myLabel.backgroundColor = [UIColor clearColor];
        self.myLabel.font = [UIFont systemFontOfSize:13];
        self.myLabel.textAlignment = NSTextAlignmentCenter;
        self.myLabel.numberOfLines = 0;
        self.myLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.myLabel.text = @"😂";
        [self.contentView addSubview:self.myLabel];
        
        
    }
    
    return self;
}









@end
