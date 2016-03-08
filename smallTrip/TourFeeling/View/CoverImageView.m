//
//  CoverImageView.m
//  smallTrip
//
//  Created by 纪宇驰 on 16/3/8.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "CoverImageView.h"
#import "FXLabel.h"

@interface CoverImageView ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end


@implementation CoverImageView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        self.imageV.backgroundColor = [UIColor clearColor];
        self.imageV.image = [UIImage imageNamed:@"CoverPic"];
        [self addSubview:self.imageV];
        
        self.titleLabel = [[FXLabel alloc] init];
        self.titleLabel.frame = CGRectMake(0, self.bounds.size.height / 3, self.bounds.size.width, self.bounds.size.height / 6);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.75f];
        self.titleLabel.shadowOffset = CGSizeMake(0.0f, 5.0f);
        self.titleLabel.shadowBlur = 5.0f;
        [self addSubview:self.titleLabel];
        
        self.secondTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height / 2, self.bounds.size.width, self.bounds.size.height / 6)];
        self.secondTitleLabel.textColor = [UIColor blackColor];
        self.secondTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.secondTitleLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.75f];
        self.secondTitleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.secondTitleLabel];
        
        UITapGestureRecognizer *aTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
        aTapGR.numberOfTapsRequired = 1;
        aTapGR.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:aTapGR];
        
        
    }
    
    return self;
}


- (void)tapGestureRecognizer:(UITapGestureRecognizer *)aTapGR {
    // 进入图片选择页面
    
    UIImagePickerController *imagePickerC = [[UIImagePickerController alloc] init];
    // 设置图片来源
    imagePickerC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerC.delegate = self;
//    imagePickerC.allowsEditing = YES;
    imagePickerC.title = @"1";
    UIViewController *myController = [self viewController];
    [myController presentViewController:imagePickerC animated:YES completion:nil];
    
}

#pragma mark - 寻找响应链上的controller 用来模态到新的界面
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - UIImagePickerControllerDelegate方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 获取系统相册照片
    // 这个image可以用于给外界传值
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    
    self.imageV.image = image;
    
    NSDictionary *dict = @{@"image":image};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"coverImage" object:self userInfo:dict];
    UIViewController *myController = [self viewController];
    [myController dismissViewControllerAnimated:YES completion:nil];
    
    
    
}


@end
