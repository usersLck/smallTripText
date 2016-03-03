//
//  DiaryDataController.m
//  smallTrip
//
//  Created by 纪宇驰 on 16/2/16.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "DiaryDataController.h"
#import "PrefixHeader.pch"
#import "AddDiaryCell.h"



@interface DiaryDataController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign)NSInteger height;

@end

@implementation DiaryDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"编辑游记";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRowHeight:) name:@"height" object:nil];
    
    
    
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH,KHEIGHT) style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor redColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.rowHeight = KHEIGHT / 3;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[AddDiaryCell class] forCellReuseIdentifier:@"register"];
    
    
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddDiaryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"register" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 这里需要自适应高度，根据collectionview的高度来判断，collectionview的高度根据item的高度和上下间隙的宽度来计算，item的个数是从当前的controller来获取的，
    
    return self.height;
}


- (void)updateRowHeight:(NSNotification *)notification {
    
    NSInteger num = [notification.userInfo[@"height"] integerValue];
    
    self.height = num;
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
