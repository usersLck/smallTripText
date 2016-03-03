//
//  ForumModel.h
//  smallTrip
//
//  Created by Aaslte on 16/2/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForumModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, strong) NSArray *detailList;
@property (nonatomic, copy) NSString *time;





@end
