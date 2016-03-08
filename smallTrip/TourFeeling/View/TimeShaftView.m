//
//  TimeShaftView.m
//  smallTrip
//
//  Created by 纪宇驰 on 16/3/7.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TimeShaftView.h"
#import "TimeShaftCell.h"


#define VIEWWIDTH self.bounds.size.width
#define VIEWHEIGHT self.bounds.size.height

@interface TimeShaftView ()<UITableViewDataSource, UITableViewDelegate>



@end

@implementation TimeShaftView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.8;
        self.mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.mapButton.frame = CGRectMake(0, VIEWHEIGHT / 20 * 19, VIEWWIDTH / 2, VIEWHEIGHT / 20);
        self.mapButton.backgroundColor = [UIColor clearColor];
        [self.mapButton setTitle:@"地图" forState:UIControlStateNormal];
        [self addSubview:self.mapButton];
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancelButton.frame = CGRectMake(VIEWWIDTH / 4 * 3, VIEWHEIGHT / 20 * 19, VIEWWIDTH / 4, VIEWHEIGHT / 20);
        self.cancelButton.backgroundColor = [UIColor clearColor];
        [self.cancelButton setTitle:@"收起" forState:UIControlStateNormal];
        [self addSubview:self.cancelButton];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEWWIDTH, VIEWHEIGHT / 20 * 19) style:UITableViewStyleGrouped];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.rowHeight = VIEWHEIGHT / 15;
        [self addSubview:tableView];
        [tableView registerClass:[TimeShaftCell class] forCellReuseIdentifier:@"cell"];
        
    }
    
    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
//    NSInteger sectionNum = [self.tiemStr integerValue];
//    return sectionNum;
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    return self.placeArr.count;
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimeShaftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.label.text = @"PlaceTest";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

// 设置分区头
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return VIEWHEIGHT / 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEWWIDTH, VIEWHEIGHT / 15)];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(VIEWWIDTH / 10, 0, VIEWWIDTH / 10, VIEWHEIGHT / 15)];
    imageV.image = [UIImage imageNamed:@"point32"];
    imageV.contentMode = UIViewContentModeCenter;
    [view addSubview:imageV];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageV.frame.origin.x + imageV.bounds.size.width, 0, VIEWHEIGHT / 5 * 4, VIEWHEIGHT / 15)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.text = @"时间";
    [view addSubview:label];
    
    
    return view;
}

#pragma mark - 懒加载

- (NSArray *)placeArr {
    
    if (!_placeArr) {
        self.placeArr = [NSArray array];
    }
    
    return _placeArr;
}





@end
