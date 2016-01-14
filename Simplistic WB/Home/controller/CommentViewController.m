//
//  CommentViewController.m
//  Simplistic WB
//
//  Created by wzk on 15/12/10.
//  Copyright (c) 2015年 Ibokan1. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentTool.h"
#import "User.h"
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height
#define CommentSpace 10
@interface CommentViewController ()
{
    UILabel *_titleLable; //中心文本
    
    UILabel *_userNameLable; // 用户名
    
    UILabel * _placeholder;//提示文本
    
    UIButton *_sendBtn; //发送按钮
    
    UIToolbar *_toolBar; //工具栏
    
    UITextView *_commentTextView;    //回复评论框
    
}

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //设置不延伸
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initWithTextView];
    
    [self initWithSendBtn];
    

    //发送按钮
    _sendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_sendBtn setFrame:CGRectMake(0, 0, 38, 25)];
    [_sendBtn setBackgroundColor:[UIColor whiteColor]];
    [_sendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    _sendBtn.layer.cornerRadius = 2;
    [_sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cancelBtn setFrame:CGRectMake(0, 0, 38, 25)];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.layer.cornerRadius = 2;
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc]initWithCustomView:cancelBtn];
    self.navigationItem.leftBarButtonItem = cancelBtnItem;

    
    UIBarButtonItem *sendBtnItem = [[UIBarButtonItem alloc]initWithCustomView:_sendBtn];
    self.navigationItem.rightBarButtonItem = sendBtnItem;
    
    //键盘出现通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    
    //键盘消失通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self initWithWillAppealTextBtn];
}
#pragma -mark- 视图将消失的时候
-(void)viewWillDisappear:(BOOL)animated
{
    
    [_titleLable removeFromSuperview];
    
    [_userNameLable removeFromSuperview];
}

#pragma -mark- 回复评论框
-(void)initWithTextView
{
    
    _commentTextView  = [[UITextView alloc]initWithFrame:CGRectMake(CommentSpace, CommentSpace, self.view.frame.size.width - CommentSpace * 2, self.view.frame.size.height - CGRectGetMaxY(self.navigationController.navigationBar.frame))];
    _commentTextView.font = [UIFont systemFontOfSize:15.f];
    
    //获得焦点
    [_commentTextView becomeFirstResponder];
    
    [_commentTextView isFirstResponder];
    
    _commentTextView.delegate = self;
    
    [self.view addSubview:_commentTextView];
    
    //添加提示文本
    _placeholder = [[UILabel alloc]init];
    
    
    _placeholder.frame = CGRectMake(5, 2, 150, 30);
    
    //添加提示文本
    _placeholder.text = @"写评论...";
    
    _placeholder.alpha = 0.3;
    
    _placeholder.font = [UIFont systemFontOfSize:15];
    
    [_commentTextView addSubview:_placeholder];
    
    //添加滑动手势
    UISwipeGestureRecognizer *slide = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SlideAction)];
    
    slide.direction = UISwipeGestureRecognizerDirectionDown;
    
    [_commentTextView addGestureRecognizer:slide];
    
    //添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAction)];
    
    [_commentTextView addGestureRecognizer:tap];
    
    
}

#pragma -mark- 滑动手势
-(void)SlideAction
{
    
    //回收键盘
    [_commentTextView resignFirstResponder];
    
}

#pragma -mark- 点击手势
-(void)TapAction
{
    
    //弹出键盘
    [_commentTextView becomeFirstResponder];
    
    
}

#pragma -mark- 导航栏上出现的UI
-(void)initWithWillAppealTextBtn
{
    //导航中心label
    _titleLable = [UILabel new];
    _titleLable.text = @"发评论";
    [_titleLable sizeToFit];
    _titleLable.center = CGPointMake((CGRectGetWidth(self.navigationController.navigationBar.frame))/2, 10);
    [self.navigationController.navigationBar addSubview:_titleLable];
    
    //用户名
    _userNameLable = [UILabel new];
    _userNameLable.text = self.status.user.screen_name;
    _userNameLable.font = [UIFont systemFontOfSize:15.f];
    [_userNameLable sizeToFit];
    _userNameLable.center = CGPointMake((CGRectGetWidth(self.navigationController.navigationBar.frame))/2, CGRectGetMaxY(_titleLable.frame) + 10);
    [self.navigationController.navigationBar addSubview:_titleLable];
    [self.navigationController.navigationBar addSubview:_userNameLable];
    
    
    
}
#pragma -mark- 发送按钮方法
-(void)sendAction
{
    
    
    [CommentTool CommentToolPostCreateWithComment:_commentTextView.text  ID:self.status.mid Comment_ori:1 Success:^(id json) {
        
    } failurs:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)cancelAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma -mark- 添加toolbar栏
-(void)initWithSendBtn
{
    
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 44, CGRectGetWidth(self.view.frame), 44)];
    //存五个按钮
    NSMutableArray *btnarr = [NSMutableArray new];
    UIBarButtonItem *BA = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [btnarr addObject:BA];
    //增加工具栏按钮
    for (int i = 0; i < 5; i++)
    {
        UIButton *toolBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [toolBtn setFrame:CGRectMake(0, 0, 30, 30)];
        [toolBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"face%d",i]] forState:UIControlStateNormal];
        UIBarButtonItem * sendVector = [[UIBarButtonItem alloc] initWithCustomView:toolBtn];
        UIBarButtonItem *BA = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [btnarr addObject:sendVector];
        [btnarr addObject:BA];
    }
    [_toolBar setItems:btnarr];
    [self.view addSubview:_toolBar];
    [self.view bringSubviewToFront:_toolBar];
    
}

#pragma -mark- 键盘出现通知
-(void)keyboardWillShow:(NSNotification*)nofication
{
    NSDictionary *userInfo = [nofication userInfo];
    
    //取出keyboard的frame
    NSValue *frameValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [frameValue CGRectValue];
    
    //textView新的frame
    CGRect newframe = CGRectMake(0, CGRectGetHeight(self.view.frame) - keyboardRect.size.height-44, _toolBar.frame.size.width, 44);
    
    //取出键盘出现所用时间
    NSValue *durationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSTimeInterval animationDuration;
    
    [durationValue getValue:&animationDuration];
    
    //取出键盘出现的数率
    NSValue *curveValue = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    NSTimeInterval animationCurve;
    
    [curveValue getValue:&animationCurve];
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    [UIView setAnimationDuration:animationCurve];
    
    _toolBar.frame = newframe;
    
    [UIView commitAnimations];
    
}
#pragma -mark- 键盘消失通知
-(void)keyboardWillHide:(NSNotification *)notification
{
    //获取通知信息
    NSDictionary *userInfo = [notification userInfo];
    
    //取出键盘消失所用时间
    NSValue *durationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSTimeInterval animationDuration;
    
    [durationValue getValue:&animationDuration];
    
    //取出键盘消失的数率
    NSValue *curveValue = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    NSTimeInterval animationCurve;
    
    [curveValue getValue:&animationCurve];
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    [UIView setAnimationDuration:animationCurve];
    
    _toolBar.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - 44, CGRectGetWidth(self.view.frame), 44);
    
    [UIView commitAnimations];
}

#pragma -mark- 文本内容改变事件
-(void)textViewDidChange:(UITextView *)textView
{
    
    
    if ([textView.text isEqualToString:@""])
    {
        
        _placeholder.hidden = NO;
    }
    else
    {
        _placeholder.hidden = YES;
    }
    
    if (![textView.text isEqualToString:@""])
    {
        
        
        //发送按钮背景颜色橙色
        [_sendBtn setBackgroundColor:[UIColor orangeColor]];
        [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _sendBtn.enabled = YES;
        
    }
    
    else
    {
        //颜色为
        [_sendBtn setBackgroundColor:[UIColor whiteColor]];
        [_sendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _sendBtn.enabled = NO;
        
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
