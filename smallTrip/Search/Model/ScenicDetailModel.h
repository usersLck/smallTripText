//
//  ScenicDetailModel.h
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/6.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScenicDetailModel : NSObject

/**
 *  中文名
 */
@property (nonatomic, copy) NSString *chinesename;

/**
 *  英文名
 */
@property (nonatomic, copy) NSString *englishname;
/**
 *  简介
 */
@property (nonatomic, copy) NSString *introduction;

/**
 *  地址
 */
@property (nonatomic, copy) NSString *address;
/**
 *  线路
 */
@property (nonatomic, copy) NSString *wayto;

/**
 *  时间
 */
@property (nonatomic, copy) NSString *opentime;
/**
 *  门票
 */
@property (nonatomic, copy) NSString *price;

/**
 *  小贴士
 */
@property (nonatomic, copy) NSString *tips;
/**
 *  图片
 */
@property (nonatomic, copy) NSString *photo;
/**
 *  多少人去过
 */
@property (nonatomic, copy) NSString *beentocounts;


@end
