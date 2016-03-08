//
//  AddModuleCell.m
//  smallTrip
//
//  Created by 纪宇驰 on 16/2/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "AddModuleCell.h"

@implementation AddModuleCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        myImageView.image = [UIImage imageNamed:@"add"];
        [self.contentView addSubview:myImageView];
        
        
        
        
        
    }
    
    return self;
}






@end
