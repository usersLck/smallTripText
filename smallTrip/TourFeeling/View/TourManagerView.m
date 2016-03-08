//
//  TourManagerView.m
//  smallTrip
//
//  Created by 唐桂樯 on 16/2/29.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TourManagerView.h"
#import "SecondTourCell.h"

@interface TourManagerView ()<UITableViewDataSource>

@end

@implementation TourManagerView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        [self registerClass:[SecondTourCell class] forCellReuseIdentifier:@"cell"];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondTourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
