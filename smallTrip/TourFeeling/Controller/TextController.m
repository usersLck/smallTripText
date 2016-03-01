//
//  TextController.m
//  smallTrip
//
//  Created by 纪宇驰 on 16/2/25.
//  Copyright © 2016年 刘常凯. All rights reserved.
//

#import "TextController.h"

@interface TextController ()<UITextViewDelegate>

@property (nonatomic, strong)UILabel *remainText;


@end

@implementation TextController



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
// 在页面即将出现的时候给键盘添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
// 在页面已经消失的时候移除键盘的观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    
}

// 观察者方法--键盘即将出现
- (void)keyBoardWillShow:(NSNotification *)aNotification{
    
    // 获取键盘尺寸
    CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 创建中间量 用于textView.frame的改变
    CGRect frame = self.textView.frame;
    frame.size.height -= keyboardRect.size.height;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.textView.frame = frame;
    self.remainText.frame = CGRectMake(KWIDTH/4*3, self.textView.bounds.size.height - KHEIGHT / 20 + TABBARHEIGHT + 20, KWIDTH/4, KHEIGHT/20);
    [UIView commitAnimations];

}
// 观察者方法--键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)aNotification{
    
    CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.textView.frame;
    frame.size.height += keyboardRect.size.height;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.textView.frame = frame;
    self.remainText.frame = CGRectMake(KWIDTH/4*3, self.textView.bounds.size.height - KHEIGHT / 20 + TABBARHEIGHT + 20, KWIDTH/4, KHEIGHT/20);
    [UIView commitAnimations];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加创建imageView -- 用做textView的背景
    UIImageView *myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, KWIDTH, KHEIGHT)];
    myImageView.image = [UIImage imageNamed:@"YPZ"];
    
    [self.view addSubview:myImageView];
    
    // 创建textView
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, TABBARHEIGHT + 20, KWIDTH, (KHEIGHT - TABBARHEIGHT - 20))];
//    textView.backgroundColor = [UIColor cyanColor];
    self.textView.delegate = self;
    self.textView.scrollEnabled = YES;
    self.textView.editable = YES; // 是否允许编辑内容，默认为YES
    self.textView.font = [UIFont fontWithName:@"Arial" size:18]; // 设置字体和字号
    self.textView.returnKeyType = UIReturnKeyNext; // return键样式
    self.textView.keyboardType = UIKeyboardTypeDefault; // 键盘样式
    self.textView.dataDetectorTypes = UIDataDetectorTypeAll; // 显示数据类型的链接模式（如电话号码、网址、地址等）
    self.textView.textColor =[UIColor orangeColor]; // 字体颜色
    self.textView.backgroundColor = [UIColor clearColor];
    
    
    [self.view addSubview:self.textView];
    
    // 创建保存按钮
//    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveText:)];
//    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    // 提示剩余字数的小label
    self.remainText = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH/4*3, self.textView.bounds.size.height - KHEIGHT / 20 + TABBARHEIGHT + 20, KWIDTH/4, KHEIGHT/20)];
    self.remainText.font = [UIFont systemFontOfSize:15];
//    self.remainText.text = @"(限制500字)";
    [self.view addSubview:self.remainText];
    [self getText];
}

// textView 代理方法，用于限制输入字数
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
    if (range.location >= 500) {
        return NO;
    }else{
        
        return YES;
    }

}

// 滑动textView的时候 取消textView的第一响应者身份 -- 收回键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.textView resignFirstResponder];
    
}

// 在输入文字的时候更改剩余字数
- (void)textViewDidChange:(UITextView *)textView {
    
    if (textView.text.length != 0) {
        UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveText:)];
        self.navigationItem.rightBarButtonItem = rightButtonItem;
    }else{
        
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    
    NSInteger length = 500 - textView.text.length;
    self.remainText.text = [NSString stringWithFormat:@"还可输入%ld字", length];
    
    
    
}

- (void)saveText:(UIBarButtonItem *)barButtonItem {
    // 保存并传值
    
    NSString *content = self.textView.text;
    
    [self.navigationController popToViewController:[self.navigationController viewControllers][5] animated:YES];
    if (self.text.length == 0) {
        NSDictionary *dict = @{@"text":content, @"sign":@"0"};
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addNum" object:self userInfo:dict];
    }else{
        NSDictionary *dict = @{@"text":content, @"key":self.key};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"amend" object:self userInfo:dict];
    }

    
}
// 设置textView的text
- (void)getText{
    if (self.text.length != 0) {
        self.textView.text = self.text;
    }
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
