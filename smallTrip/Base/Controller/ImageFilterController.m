//
//  ImageFilterController.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/2/26.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "ImageFilterController.h"

@interface ImageFilterController ()

//@property(nonatomic, strong) UIImageView *imageView;
//@property(nonatomic, strong) UIImage *originImage;
//@property(nonatomic, strong) UIImage *buttonImage;

@property(nonatomic, strong) UIScrollView *scrollview;

@property(nonatomic, strong) NSArray *filterEnNameArr;
@property(nonatomic, strong) NSArray *filterCnNameArr;

@end

@implementation ImageFilterController

- (NSArray *)filterEnNameArr {
    if (!_filterEnNameArr) {
        self.filterEnNameArr = [NSArray arrayWithObjects:@"OriginImage", @"CIPhotoEffectChrome", @"CIPhotoEffectFade",@"CIPhotoEffectInstant",@"CIPhotoEffectMono",@"CIPhotoEffectNoir",@"CIPhotoEffectProcess",@"CIPhotoEffectTonal",@"CIPhotoEffectTransfer",@"CISRGBToneCurveToLinear", nil];
    }
    
    return _filterEnNameArr;
}

- (NSArray *)filterCnName {
    if (!_filterCnNameArr) {
        self.filterCnNameArr = [NSArray arrayWithObjects:@"原始", @"柔光",@"褪色",@"原始",@"黑白",@"深沉",@"原始",@"灰白",@"原始",@"原始", nil];
    }
    return _filterCnNameArr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
//    self.imageView.image = [UIImage imageNamed:@"filter"];
    [self.view addSubview:self.imageView];
    
//    self.originImage = [UIImage imageNamed:@"filter.png"];
    
    [self createFilterScrollView];
    [self createNavBarButton];
    
}

- (void)createNavBarButton {
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}
- (void)cancel:(UIBarButtonItem *)barButtonItem {
    NSLog(@"cancel");
//    [self.imageView removeObserver:self forKeyPath:@"image"];
}
- (void)save:(UIBarButtonItem *)barButtonItem {
    [self.imageView removeObserver:self forKeyPath:@"image"];
    
}


- (void)createFilterScrollView {
    self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KHEIGHT *6/7, KWIDTH, KHEIGHT / 8)];
    self.scrollview.contentSize = CGSizeMake(2*KWIDTH , 0);
//    [self.view addSubview:self.scrollview];
    
    self.scrollview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    for (int i = 0; i < self.filterCnName.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(KWIDTH/40 + i * (KWIDTH/20 + (self.scrollview.contentSize.width- 13*KWIDTH/40)/11 ), 5, (self.scrollview.contentSize.width- 13*KWIDTH/40)/11, (self.scrollview.contentSize.width- 13*KWIDTH/40)/11);
        
        button.tag = 1000+i;
        [button addTarget:self action:@selector(dobutton:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            self.buttonImage = [UIImage imageNamed:@"filter.png"];
        } else {
            self.buttonImage = [self imageHandleByFilter:self.filterEnNameArr[i] withImage:[UIImage imageNamed:@"filter.png"]];
        }
        [button setImage:_buttonImage forState:UIControlStateNormal];
        [self.scrollview addSubview:button];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.bounds.size.height, button.bounds.size.width, self.scrollview.bounds.size.height - button.bounds.size.height)];
        label.text = self.filterCnNameArr[i];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        [self.scrollview addSubview:label];
        
        [self.imageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        
    }
}

// self.imageView.image有值时才出现滤镜的选择
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"image"]) {
        UIImage *image = change[@"new"];
        if (image) {
            [self.view addSubview:_scrollview];
        } else {
            [self.imageView removeObserver:self forKeyPath:@"image"];
            [_scrollview removeFromSuperview];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.imageView removeObserver:self forKeyPath:@"image"];
    [_scrollview removeFromSuperview];
}


// 图片滤镜效果
- (UIImage *)imageHandleByFilter:(NSString *)filterName withImage:(UIImage *)image{
    // 把UIImage转化成CIImage
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    // 创建滤镜
    CIFilter *filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setDefaults];// 已有的值不变，其他设置为默认值
    // 获取绘制上下文
    CIContext *context = [CIContext contextWithOptions:nil];// 传nil表示使用默认值，足够
    // 渲染并输出ciimage
    CIImage *outputImage = [filter outputImage];
    // 创建CGImage句柄
    CGImageRef imageRef = [context createCGImage:outputImage fromRect:[outputImage extent]];
    // 获取图片
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    // 释放句柄 --》这个一个C语言接口，需要手动释放
    CGImageRelease(imageRef);
    return newImage;
}

// 选择滤镜按钮
- (void)dobutton:(UIButton *)button {
    switch (button.tag) {
        case 1000:
            self.imageView.image = self.originImage;
            break;
        case 1001:
            self.imageView.image =  [self imageHandleByFilter:_filterEnNameArr[button.tag - 1000] withImage:self.originImage];
            break;
        case 1002:
            self.imageView.image = [self imageHandleByFilter:_filterEnNameArr[button.tag - 1000] withImage:self.originImage];
            break;
        case 1003:
            self.imageView.image = [self imageHandleByFilter:_filterEnNameArr[button.tag - 1000] withImage:self.originImage];
            break;
        case 1004:
            self.imageView.image = [self imageHandleByFilter:_filterEnNameArr[button.tag - 1000] withImage:self.originImage];
            break;
        case 1005:
            self.imageView.image = [self imageHandleByFilter:_filterEnNameArr[button.tag - 1000] withImage:self.originImage];
            break;
        case 1006:
            self.imageView.image = [self imageHandleByFilter:_filterEnNameArr[button.tag - 1000] withImage:self.originImage];
            break;
        case 1007:
            self.imageView.image = [self imageHandleByFilter:_filterEnNameArr[button.tag - 1000] withImage:self.originImage];
            break;
        case 1008:
            self.imageView.image = [self imageHandleByFilter:_filterEnNameArr[button.tag - 1000] withImage:self.originImage];
            break;
        case 1009:
            self.imageView.image = [self imageHandleByFilter:_filterEnNameArr[button.tag - 1000] withImage:self.originImage];
            break;
            
            
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end