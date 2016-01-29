//
//  TableViewCell.m
//  smallTrip
//
//  Created by Aaslte on 16/1/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"%@", self);
        
    }
    return self;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"%@", [self viewController]);
}
- (void)awakeFromNib {
    // Initialization code
    
}
- (UIViewController *)viewController {
//    for (UIView* next = [self superview]; next; next = next.superview) {
//        UIResponder *nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[UIViewController class]]) {
//            return (UIViewController *)nextResponder;
//        }
//    }
    
    id object = [self nextResponder];
    
    while (![object isKindOfClass:[UIViewController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    UIViewController *uc=(UIViewController*)object;
    return uc;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
