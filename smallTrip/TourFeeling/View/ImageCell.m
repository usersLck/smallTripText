//
//  ImageCell.m
//  smallTrip
//
//  Created by 纪宇驰 on 16/2/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.myImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        self.myImageV.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.myImageV];
        
    }
    
    return self;
}





@end
