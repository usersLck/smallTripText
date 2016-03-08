//
//  DiaryTitleController.m
//  smallTrip
//
//  Created by 纪宇驰 on 16/2/14.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "DiaryTitleController.h"
#import "DiaryLTView.h"
#import "PrefixHeader.pch"
#import "DiaryDataController.h"

#define START_YEAR 1970



@interface DiaryTitleController ()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    // 年、月、日 全局变量

    NSInteger yearRange;
    NSInteger dayRange;
    NSInteger startYear;
    
    NSInteger selectedYear;
    NSInteger selectedMonth;
    NSInteger selectedDay;
    NSCalendar *calendar;
}


// pickerView
@property (nonatomic, retain)UIPickerView *pickerV;

// 组合控件属性
@property (nonatomic, retain)DiaryLTView *mainLTV; // 标题
@property (nonatomic, retain)DiaryLTView *secondLTV; // 副标题
@property (nonatomic, retain)DiaryLTView *allDate; // 旅程时间
@property (nonatomic, retain)DiaryLTView *beginDate; // 起始日期


@end

@implementation DiaryTitleController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"新建游记";

#warning -因为这个DLTV比较少，分开写比循环代码少，而且不用后期强转，就先分开写，当DLTV多的时候还是要用循环
    self.mainLTV = [[DiaryLTView alloc] initWithFrame:CGRectMake(KWIDTH/20, KHEIGHT/10, KWIDTH/5*4, KHEIGHT/15)];
    self.mainLTV.label.text = @"游记标题";
    self.mainLTV.textField.placeholder = @"请输入标题(必填)";
    [self.view addSubview:self.mainLTV];
    
    self.secondLTV = [[DiaryLTView alloc] initWithFrame:CGRectMake(KWIDTH/20, KHEIGHT/10*2, KWIDTH/5*4, KHEIGHT/15)];
    self.secondLTV.label.text = @"游记简述";
    self.secondLTV.textField.placeholder = @"请输入副标题";
    [self.view addSubview:self.secondLTV];
    
    self.allDate = [[DiaryLTView alloc] initWithFrame:CGRectMake(KWIDTH/20, KHEIGHT/10*3, KWIDTH/5*4, KHEIGHT/15)];
    self.allDate.label.text = @"旅行天数";
    self.allDate.textField.placeholder = @"-";
    [self.view addSubview:self.allDate];
    
    self.beginDate = [[DiaryLTView alloc] initWithFrame:CGRectMake(KWIDTH/20, KHEIGHT/10*4, KWIDTH/5*4, KHEIGHT/15)];
    self.beginDate.label.text = @"出发日期";
    self.beginDate.textField.placeholder = @"- - -";
    [self.view addSubview:self.beginDate];
    
    // 定义UIPickerView
    self.pickerV = [[UIPickerView alloc] initWithFrame:CGRectMake(KWIDTH / 20, KHEIGHT / 3, KWIDTH / 10 * 9, KHEIGHT / 3)];
    self.pickerV.dataSource = self;
    self.pickerV.delegate = self;
    self.pickerV.showsSelectionIndicator = YES;
    self.pickerV.backgroundColor = [UIColor whiteColor];
    self.beginDate.textField.inputView = self.pickerV;

    
    NSCalendar *calendar0 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    comps = [calendar0 components:unitFlags fromDate:[NSDate date]];
    NSInteger year = [comps year];
    
    startYear=year-15;
    yearRange=30;
    selectedYear=2000;
    selectedMonth=1;
    selectedDay=1;
    dayRange=[self isAllDay:startYear andMonth:1];
    
    [self dateForToday];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(toNextTemp:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
}

// 计算今天的日期
- (void)dateForToday {
    //获取当前时间
    NSCalendar *calendar0 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    comps = [calendar0 components:unitFlags fromDate:[NSDate date]];
    NSInteger year=[comps year];
    NSInteger month=[comps month];
    NSInteger day=[comps day];
    
    selectedYear=year;
    selectedMonth=month;
    selectedDay=day;
    
    
    dayRange=[self isAllDay:year andMonth:month];
    
    [self.pickerV selectRow:year-startYear inComponent:0 animated:true];
    [self.pickerV selectRow:month-1 inComponent:1 animated:true];
    [self.pickerV selectRow:day-1 inComponent:2 animated:true];
    
    
    [self.pickerV reloadAllComponents];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    // 选择器列数
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
            return yearRange;
            break;
        case 1:
            return 12;
            break;
        case 2:
            return dayRange;
            break;
            
        default:
            break;
    }
    return 0;  //返回每列的行数
}

// 设置选择器宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return KWIDTH / 10 * 3;
}

// 设置选择器行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return KHEIGHT / 9;
}

//设置所在列每行的显示标题，与设置所在列的行数一样，天数的标题设置仍旧需要费一番功夫
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [NSString stringWithFormat:@"%ld年",(long)(startYear + row)];;
            break;
        case 1:
            return [NSString stringWithFormat:@"%ld月",(long)row+1];
            break;
        case 2:
            return [NSString stringWithFormat:@"%ld日",(long)row+1];
            break;
        default:
            break;
    }
    return 0;
}
//当选择的行数改变时触发的方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
#pragma mark - 下面几行是每滑动一个选择器，次一级选择器中数据刷新，从第一个开始

    switch (component) {
        case 0:
        {
            selectedYear=startYear + row;
            dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
            [pickerView reloadComponent:2];
        }
            break;
        case 1:
        {
            selectedMonth=row+1;
            dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
            [pickerView reloadComponent:2];
        }
            break;
        case 2:
        {
            selectedDay=row+1;
        }
            break;
            
        default:
            break;
    }

    
    
    
    // 定义所选中的年月日
    NSString *yearSelected = [NSString string];
    NSString *monthSelected = [NSString string];
    NSString *daySelected = [NSString string];
//     根据不同列的选择器的变动，来判断年月日的数值
    if (component == 0) {
        [pickerView reloadComponent:1];
        yearSelected = [NSString stringWithFormat:@"%ld", (row + startYear)];
    }else{
        yearSelected = [NSString stringWithFormat:@"%ld", selectedYear];
    }
    
    if (component == 1) {
        [pickerView reloadComponent:2];
        monthSelected = [NSString stringWithFormat:@"%ld", (row + 1)];
    }else{
        monthSelected = [NSString stringWithFormat:@"%ld", selectedMonth];
    }
    
    if (component == 2) {
        
        daySelected = [NSString stringWithFormat:@"%ld", (row + 1)];
    }else{
        daySelected = [NSString stringWithFormat:@"%ld", selectedDay];
    }
    
    // 将选中的日期显示到关联的textfield上面
    self.beginDate.textField.text = [NSString stringWithFormat:@"%@-%@-%@", yearSelected, monthSelected, daySelected];
}




//判断是否闰年
- (BOOL)isLeapYear:(int)year
{
    if ((year % 400 == 0) || ((year % 4 == 0) && (year % 100 != 0)))
    {
        return YES; //是闰年返回 YES
    }
    
    return NO; //不是闰年，返回 NO
}




- (void)toNextTemp:(UIBarButtonItem *)Item {
    
//    DiaryDataController *DDC = [[DiaryDataController alloc] init];
//    [self.navigationController pushViewController:DDC animated:YES];
    // 对各个textfile内容进行判断
    if (self.mainLTV.textField.text.length > 0 && self.mainLTV.textField.text.length <= 10) {
        if (self.secondLTV.textField.text.length <=15) {
            if (self.allDate.textField.text.length >0) {
                if ([self.allDate.textField.text intValue] >= 1 && [self.allDate.textField.text intValue] <= 99) {
                    if (self.beginDate.textField.text.length != 0) {
                        // 所有条件都符合，则跳入下一个页面
                        DiaryDataController *DDC = [[DiaryDataController alloc] init];
                        DDC.numOfRow = self.allDate.textField.text;
                        DDC.days = self.beginDate.textField.text;
                        DDC.travelsTitle = self.mainLTV.textField.text;
                        DDC.secondTitle = self.secondLTV.textField.text;
                        DDC.beginDate = self.beginDate.textField.text;
                        
                        
                        [self.navigationController pushViewController:DDC animated:YES];
                        
                    } else {
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择出发日期" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *leftAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                        [alertController addAction:leftAction];
                        [self presentViewController:alertController animated:YES completion:nil];
                    }
                }else{
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"旅行天数必须是(0~99)的整数" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *leftAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:leftAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                
            } else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"旅行天数不能为空" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *leftAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:leftAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"副标题长度不能大于15个字符" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *leftAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:leftAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"游记标题不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *leftAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:leftAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

- (NSInteger)isAllDay:(NSInteger)year andMonth:(NSInteger)month {
    int days = 0;
    switch (month) {
        case 1:
            days = 31;
            break;
        case 2:
            if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) {
                days = 29;
            }else{
                days = 28;
            }
            break;
        case 3:
            days = 31;
            break;
        case 4:
            days = 30;
            break;
        case 5:
            days = 31;
            break;
        case 6:
            days = 30;
            break;
        case 7:
            days = 31;
            break;
        case 8:
            days = 31;
            break;
        case 9:
            days = 30;
            break;
        case 10:
            days = 31;
            break;
        case 11:
            days = 30;
            break;
        case 12:
            days = 31;
            break;
        
        default:
            break;
    }
    
    return days;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
