//
//  AddModuleController.m
//  smallTrip
//
//  Created by 纪宇驰 on 16/2/25.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "AddModuleController.h"
#import "TextController.h"




@interface AddModuleController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong)UIButton *textButton;
@property (nonatomic, strong)UIButton *pictureButton;
@property (nonatomic, strong)UIButton *mapButton;



@end

@implementation AddModuleController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择模块";
    self.view.backgroundColor = [UIColor whiteColor];
    self.textButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NSArray *buttonArr = @[self.textButton, self.pictureButton, self.mapButton];
//    NSArray *iconArr = @[@"text", @"picture", @"position"];
    
    for (int i = 0; i < buttonArr.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH / 32, KWIDTH / 32, KWIDTH / 16 * 15, (KHEIGHT - TABBARHEIGHT - 20) / 3 - KWIDTH / 16)];
        imageView.backgroundColor = [UIColor redColor];
        imageView.layer.cornerRadius = 6;
        
        UIButton *button = buttonArr[i];
//        button.frame = CGRectMake(KWIDTH / 16 + KWIDTH / 16 * 5 * i, KHEIGHT / 7 * 2, KWIDTH / 4, KWIDTH / 4);
        button.frame = CGRectMake(0, TABBARHEIGHT  + 20 + (KHEIGHT - TABBARHEIGHT - 20) / 3 * i, KWIDTH, (KHEIGHT - TABBARHEIGHT) / 3);
        button.backgroundColor = [UIColor cyanColor];
        button.tag = 1000 + i;
//        [button setImage:[UIImage imageNamed:iconArr[i]] forState:UIControlStateNormal];
        [button addSubview:imageView];
        [self.view addSubview:button];
        
    }
    
    [self.textButton addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.pictureButton addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
    self.pictureButton.backgroundColor = [UIColor blueColor];
    [self.mapButton addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];

    
    
    
}








- (void)changeVC:(UIButton *)button{
    
    TextController *TVC = [[TextController alloc] init];
    UIImagePickerController *imagePickerC = [[UIImagePickerController alloc] init];
    // 设置图片来源
    imagePickerC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePickerC.delegate = self;
    
    
    switch (button.tag) {
        case 1000:
            TVC.section = self.section;
            [self.navigationController pushViewController:TVC animated:YES];
            break;
        case 1001:
            [self.navigationController presentViewController:imagePickerC animated:YES completion:nil];
            break;
        case 1002:
            
            break;
            
        default:
            break;
    }
    
    
    
    
}

#pragma mark - UIImagePickerControllerDelegate方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 获取系统相册照片
    // 这个image可以用于给外界传值
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    NSDictionary *dict = @{@"image":image, @"sign":@"1", @"section":self.section};
    // 发送传递image的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"image" object:self userInfo:dict];
    NSLog(@"%@", image);
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
