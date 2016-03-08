//
//  HotDestinationCell.h
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/3.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
#import "HotCountryModel.h"

@interface HotDestinationCell : UITableViewCell

@property(nonatomic, strong, readonly) CustomButton *button1;
@property(nonatomic, strong, readonly) CustomButton *button2;
//@property(nonatomic, strong, readonly) CustomButton *button3;
//@property(nonatomic, strong, readonly) CustomButton *button4;
//@property(nonatomic, strong, readonly) CustomButton *button5;
//@property(nonatomic, strong, readonly) CustomButton *button6;
//@property(nonatomic, strong, readonly) CustomButton *button7;
//@property(nonatomic, strong, readonly) CustomButton *button8;

@property(nonatomic, strong) HotCountryModel *hotCountryModel;

- (void)configuireHotDestinationCellByModelArr:(NSArray *)modelArr withTag:(NSInteger)tag;

@end
