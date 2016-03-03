//
//  ImageFilterController.h
//  smallTrip
//
//  Created by 唐桂樯 on 16/2/26.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageFilterController : UIViewController

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIImage *originImage;
@property(nonatomic, strong) UIImage *buttonImage;

// 测试上传
- (void)testUpload;

@end
