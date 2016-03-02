//
//  TourManageController.m
//  smallTrip
//
//  Created by 刘常凯 on 16/1/30.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TourManageController.h"
#import "RootTabBarViewController.h"
#import "TemplateController.h"

#import "SecondTourCell.h"
#import "ManagerTopView.h"
#import "TourDetailController.h"


//  个人游记主页
@interface TourManageController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *managerView;
@property(nonatomic, strong) NSMutableArray *arr;

@end

@implementation TourManageController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    ((RootTabBarViewController *)self.tabBarController).tabBarView.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"游记管理";
    self.view.backgroundColor = [UIColor magentaColor];
    
    // 加判断是否已经登陆
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(returnAdd:)];
    self.navigationItem.rightBarButtonItem = button;
    
    [self createTableView];
    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
}

- (void)returnAdd:(UIButton *)sender{
    TemplateController *temp = [[TemplateController alloc] init];
    [self.navigationController pushViewController:temp animated:YES];
}


// 创建tableView
- (void)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    _managerView = tableView;
    [tableView registerClass:[SecondTourCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_managerView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 70;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ManagerTopView *topView = [[ManagerTopView alloc] init];
    return topView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondTourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    cell.titleLabel.text = @"wode";
//    cell.pictureImageView.image = nil;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

// 侧滑删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 现修改数据，再操作UI
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.arr removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
    
}
// 编辑完成
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
// Delete改为删除
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TourDetailController *tourDetailVC = [[TourDetailController alloc] init];
    // 通过model传值
//    tourDetailVC.tourModel = 
    [self.navigationController pushViewController:tourDetailVC animated:YES];
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
