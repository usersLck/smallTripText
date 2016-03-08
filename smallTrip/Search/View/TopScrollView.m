//
//  TopScrollView.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/3/5.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TopScrollView.h"
#import <UIImageView+WebCache.h>
#import "ScrollModel.h"

@interface TopScrollView ()

@property(nonatomic, strong) UIImageView *imageV1;
@property(nonatomic, strong) UIImageView *imageV2;
@property(nonatomic, strong) UIImageView *imageV3;
@property(nonatomic, strong) UIImageView *imageV4;
@property(nonatomic, strong) UIImageView *imageV5;

@property(nonatomic, strong) NSArray *arr;

@end
int i = 0;
NSString *oldCountryId;
@implementation TopScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        _imageV1 = [[UIImageView alloc] init];
        _imageV2 = [[UIImageView alloc] init];
        _imageV3 = [[UIImageView alloc] init];
        _imageV4 = [[UIImageView alloc] init];
        _imageV5 = [[UIImageView alloc] init];
        self.arr = @[_imageV1, _imageV2, _imageV3, _imageV4, _imageV5];
        for (int i = 0; i < _arr.count; i++) {
            ((UIImageView *)_arr[i]).frame = CGRectMake(KWIDTH*i, 0, KWIDTH, self.bounds.size.height);
            [self addSubview:(UIImageView *)_arr[i]];
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(change:) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)setScrollModel:(ScrollModel *)scrollModel {
    _scrollModel = scrollModel;
    self.contentSize = CGSizeMake(KWIDTH *_scrollModel.photoArr.count, 0);
    for (int i = 0; i < _scrollModel.photoArr.count; i++) {
        [(UIImageView *)_arr[i] sd_setImageWithURL:[NSURL URLWithString:_scrollModel.photoArr[i]] placeholderImage:[UIImage imageNamed:@"place"]];
    }
}

- (NSTimer *)timer {
    if (!_timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(change:) userInfo:nil repeats:YES];
    }
    return _timer;
}

/**
 *  自动轮播
 *
 *  @param timer
 */
- (void)change:(NSTimer *)timer {
    NSLog(@"%d", i);
    NSString *newId = _scrollModel.countryID;
    if ([newId isEqualToString:oldCountryId]) {
        if (i < _scrollModel.photoArr.count) {
            [self setContentOffset:CGPointMake(KWIDTH*i, 0) animated:YES];
        } else if (i >= _scrollModel.photoArr.count) {
            i = 0;
            self.contentOffset = CGPointMake(0, 0);
        }
        i++;
    } else {
        i = 1;
    }
    oldCountryId = _scrollModel.countryID;
}

@end
