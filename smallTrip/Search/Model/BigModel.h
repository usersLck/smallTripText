//
//  BigModel.h
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/4.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HotCountryModel.h"
#import "OtherCountryModel.h"

@interface BigModel : NSObject

@property(nonatomic, copy) NSString *ID;
@property(nonatomic, copy) NSString *cnname;// 中文名
@property(nonatomic, copy) NSString *enname;// 中文名
@property(nonatomic, copy) NSString *hot_country;// 热门国家
@property(nonatomic, copy) NSString *country;// 其他国家

@property(nonatomic, strong) NSMutableArray *hotCountryArr;
@property(nonatomic, strong) NSMutableArray *otherCountryArr;






@end
