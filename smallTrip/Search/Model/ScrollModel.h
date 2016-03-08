//
//  ScrollModel.h
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/5.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScrollModel : NSObject

@property(nonatomic, copy) NSString *countryID;
@property(nonatomic, copy) NSString *cnname;
@property(nonatomic, copy) NSString *enname;
@property(nonatomic, copy) NSString *entryCont;
@property(nonatomic, strong) NSMutableArray *photoArr;




@end
