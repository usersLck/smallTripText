//
//  TestViewController.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/2/26.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TestViewController.h"
#import <AFNetworking.h>

#define kUrl @"http://10.80.12.36:8080/text/travels"

@interface TestViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if (picker.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum) {
        self.showImage = info[@"UIImagePickerControllerOriginalImage"];
        self.originImage = info[@"UIImagePickerControllerOriginalImage"];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#warning 图片上传
// 图片上传
- (void)testUpload {
    [super testUpload];
    
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    mager.responseSerializer = [AFJSONResponseSerializer serializer];
    
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    [mager setSecurityPolicy:securityPolicy];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [mager POST:kUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData = UIImageJPEGRepresentation(self.showImage, 0.5);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        NSString *name = @"type=2";
        
        [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败 %@", error);
    }];
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
