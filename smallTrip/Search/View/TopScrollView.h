//
//  TopScrollView.h
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/5.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScrollModel;
@interface TopScrollView : UIScrollView

//@property(nonatomic, strong) NSMutableArray *scrollArray;
@property(nonatomic, strong) ScrollModel *scrollModel;
@property(nonatomic, strong) NSTimer *timer;


@end
