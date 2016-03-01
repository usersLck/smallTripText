//
//  PhotoTextCell.h
//  smallTrip
//
//  Created by 刘常凯 on 16/2/19.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoTextCell : UITableViewCell

@property (nonatomic, retain)UIImageView *images;

@property (nonatomic, retain)UIView *manageView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andtype:(BOOL)type;

@end
