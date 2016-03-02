//
//  SecondTourCell.h
//  smallTrip
//
//  Created by 唐桂樯 on 16/2/24.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "FirstTourCell.h"
#import "TourModel.h"

@interface SecondTourCell : FirstTourCell

@property(nonatomic, strong) TourModel *tourModel;

- (void)cellRotation;

@end
