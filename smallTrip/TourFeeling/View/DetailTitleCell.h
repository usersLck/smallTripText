//
//  DetailTitleCell.h
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/3.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TourModel.h"

@interface DetailTitleCell : UITableViewCell

@property(nonatomic, strong) TourModel *tourModel;
@property(nonatomic, strong, readonly) UILabel *titleLabel;



@end
