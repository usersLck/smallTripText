//
//  DetailImageCell.h
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/2.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailTourModel;

@interface DetailImageCell : UITableViewCell

@property(nonatomic, strong, readonly) UIImageView *imageV;
@property(nonatomic, strong) DetailTourModel *detailModel;


@end
