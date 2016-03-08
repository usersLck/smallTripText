//
//  OtherDestinationCell.h
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/4.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OtherCountryModel.h"

@interface OtherDestinationCell : UITableViewCell

@property(nonatomic, strong, readonly) UILabel *CnNameLabel;
@property(nonatomic, strong, readonly) UILabel *EnNameLabel;

@property(nonatomic, strong) OtherCountryModel *otherModel;

@end
