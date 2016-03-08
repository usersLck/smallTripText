//
//  tabbarView.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TabbarView.h"

#import "TourDetailController.h"

#import "WeatherController.h"

#import "MapController.h"

//  tabbar组件

@implementation TabbarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id)delegate{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        self.delegate = delegate;
        
        UIImage *strategyIcon = [UIImage imageNamed:@"strategy"];
        UIImage *weatherIcon = [UIImage imageNamed:@"weather"];
        UIImage *mapIcon = [UIImage imageNamed:@"map"];
        
        NSArray *imageArr = @[strategyIcon, weatherIcon, mapIcon];
        
        for (int i = 0; i < imageArr.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(frame.size.width / imageArr.count / imageArr.count + frame.size.width / imageArr.count * i, 0, frame.size.width / imageArr.count / imageArr.count, frame.size.width / imageArr.count / imageArr.count);
            [self addSubview:button];
            button.tag = 2000 + i;
            [button setImage:imageArr[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(changeVc:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

- (void)changeVc:(UIButton *)sender{
    
    UIViewController *vc = [self viewController];
    
    TourDetailController *tour = [[TourDetailController alloc] init];
    
    WeatherController *weather = [[WeatherController alloc] init];
    
    MapController *map = [[MapController alloc] init];
    if (sender.tag % 1000 == 0 && [TourDetailController class] != [[self viewController] class]) {
        
        [[self viewController].navigationController pushViewController:tour animated:YES];
    }else if (sender.tag % 1000 == 1 && [WeatherController class] != [[self viewController] class]) {
        [[self viewController].navigationController pushViewController:weather animated:YES];
    }else if (sender.tag % 1000 == 2 && [MapController class] != [[self viewController] class]) {
        [vc.navigationController pushViewController:map animated:YES];
    }
    
    
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


@end
