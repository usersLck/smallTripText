//
//  LineData.h
//  smallTrip
//
//  Created by 刘常凯 on 16/2/24.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineData : UIView

@property (nonatomic, retain)NSMutableArray *topArray;

@property (nonatomic, retain)NSMutableArray *secondArray;

@property (nonatomic, retain)NSMutableArray *lastArray;

- (instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)array andType:(NSInteger *)type;

@end
