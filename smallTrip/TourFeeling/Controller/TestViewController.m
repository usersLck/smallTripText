//
//  TestViewController.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/2/26.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //    [self dismissViewControllerAnimated:YES completion:nil];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    NSLog(@"info%@", info);
    if (picker.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum) {
        self.imageView.image = info[@"UIImagePickerControllerOriginalImage"];
        self.originImage = info[@"UIImagePickerControllerOriginalImage"];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
