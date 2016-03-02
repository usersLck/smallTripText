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
        self.imageView.image = info[@"UIImagePickerControllerOriginalImage"];
        self.originImage = info[@"UIImagePickerControllerOriginalImage"];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)testUpload {
    [super testUpload];
    
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    mager.responseSerializer = [AFJSONResponseSerializer serializer];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@"000" forKey:@"userName"];
    [parameters setObject:@"2" forKey:@"type"];
    
    [mager POST:kUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 0.5);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        NSString *name = @"shenme";
        
        [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/jpeg"];
        NSLog(@"forma %@", formData);
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功");
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
