//
//  WeatherCell.m
//  smallTrip
//
//  Created by 刘常凯 on 16/2/24.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "WeatherCell.h"

#import "ShareButton.h"

#import "CurveView.h"

#import "SearchWeatherController.h"

@implementation WeatherCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setArray:(NSMutableArray *)array{
    _array = array;
    CurveView *curve = [[CurveView alloc] initWithFrame:CGRectMake(0, KHEIGHT * 2 / 3 - 100, KWIDTH, 400)];
    curve.array = array;
    [self.contentView addSubview:curve];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"%@", NSStringFromCGRect([UIScreen mainScreen].bounds));
        UIImageView *images = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weatherBack"]];
        images.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT * 2 / 3);
        [self.contentView addSubview:images];
        images.userInteractionEnabled = YES;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(KWIDTH / 22, 10, KWIDTH / 11, KWIDTH / 11);
        [images addSubview:button];
        [button setImage:[UIImage imageNamed:@"magnifier"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(returnSearch:) forControlEvents:UIControlEventTouchUpInside];
        
        ShareButton *share = [[ShareButton alloc] initShareButton];
        share.frame = CGRectMake(KWIDTH - BUTTONHEIGHT * 1.5,  10, BUTTONHEIGHT, BUTTONHEIGHT);
        [images addSubview:share];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, KHEIGHT, KWIDTH, KHEIGHT)];
        view.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:view];
        
    }
    return self;
}



- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)returnSearch:(UIButton *)sender{
    id controller = [self viewController];
    SearchWeatherController *search = [[SearchWeatherController alloc] init];
    [controller pushViewController:search animated:YES];
}

@end
