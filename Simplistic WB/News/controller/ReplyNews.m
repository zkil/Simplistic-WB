//
//  ReplyNews.m
//  Simplistic WB
//
//  Created by Ibokan1 on 12/3/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "ReplyNews.h"
#import "CommentTool.h"
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ReplyNews ()<UITextViewDelegate>

{
    UILabel *la; //中心文本
    
    UIButton *sendBtn; //发送按钮
    
    UIToolbar *toolBar; //工具栏
    
    UITextView *vi;    //回复评论框
    
}
@end

@implementation ReplyNews

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithTextView];
    
    [self initWithSendBtn];
    
    //键盘出现通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    

    //键盘消失通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.navigationItem.title = self.replyname;
    
    
}

#pragma -mark- 视图将出现的时候
-(void)viewWillAppear:(BOOL)animated
{
    
    [self initWithWillAppealTextBtn];
}

#pragma -mark- 视图将消失的时候
-(void)viewWillDisappear:(BOOL)animated
{
    
    [la removeFromSuperview];
    
    [sendBtn removeFromSuperview];
}

#pragma -mark- 回复评论框
-(void)initWithTextView
{

    vi  = [[UITextView alloc]initWithFrame:self.view.frame];
    
    vi.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-44);
    
    //获得焦点
    [vi becomeFirstResponder];
    
    [vi isFirstResponder];
    
    vi.font = [UIFont systemFontOfSize:15];
    
    vi.delegate = self;
    
    [self.view addSubview:vi];
    
    //添加提示文本
    UILabel * l = [[UILabel alloc]init];
    
    l.tag = 111;
    
    l.frame = CGRectMake(0, 0, 150, 30);
    
    //添加提示文本
    l.text = @"写评论...";
    
    l.alpha = 0.3;
    
    l.font = [UIFont systemFontOfSize:15];
    
    [vi addSubview:l];
    
    //添加滑动手势
    UISwipeGestureRecognizer *slide = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SlideAction)];
    
    slide.direction = UISwipeGestureRecognizerDirectionDown;
    
    [vi addGestureRecognizer:slide];
    
    //添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAction)];
    
    [vi addGestureRecognizer:tap];
    
    
}

#pragma -mark- 滑动手势
-(void)SlideAction
{
    
    //回收键盘
    [vi resignFirstResponder];
    
}

#pragma -mark- 点击手势
-(void)TapAction
{
    
    //弹出键盘
    [vi becomeFirstResponder];
    
    
}

#pragma -mark- 导航栏上出现的UI
-(void)initWithWillAppealTextBtn
{
    //导航中心label
    la = [UILabel new];
    
//    la.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height-35, 100, 15);
    
    la.tintColor = [UIColor grayColor];
    
    la.text = @"回复评论";
    
    la.font = [UIFont systemFontOfSize:13];
    
    [la sizeToFit];
    
       la.center = CGPointMake(self.navigationController.navigationBar.frame.size.width/2,self.navigationController.navigationBar.frame.size.height/6);
    
    [self.navigationController.navigationBar addSubview:la];
    
    //发送按钮
    sendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [sendBtn setFrame:CGRectMake(MainScreenWidth-70, self.navigationController.navigationBar.frame.size.height-35, 50, 20)];
    
    [sendBtn setBackgroundColor:[UIColor whiteColor]];
    
    [sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    
     sendBtn.enabled = NO;
    
    [sendBtn addTarget:self action:@selector(SendAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:sendBtn];

}
#pragma -mark- 发送按钮方法
-(void)SendAction
{
    
    [self.delegate sendActionWithText:vi.text];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma -mark- 添加toolbar栏
-(void)initWithSendBtn
{
    
    toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, MainScreenHeight-44-214-36, MainScreenWidth, 44)];
    
    
    //存五个按钮
    NSMutableArray *btnarr = [NSMutableArray new];
    
    //增加工具栏按钮
    for (int i = 0; i < 5; i++)
    {
    
    UIButton *toolBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
    [toolBtn setFrame:CGRectMake((i+1)*80, 0, 30, 30)];
    
    [toolBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"face%d",i]] forState:UIControlStateNormal];
    
    UIBarButtonItem * sendVector = [[UIBarButtonItem alloc] initWithCustomView:toolBtn];
    
    UIBarButtonItem *BA = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [btnarr addObject:sendVector];
        
     [btnarr addObject:BA];
        
        
    
    }
    [toolBar setItems:btnarr];
    
    [self.view addSubview:toolBar];
    
    [self.view bringSubviewToFront:toolBar];
    
}

#pragma -mark- 键盘出现通知
-(void)keyboardWillShow:(NSNotification*)nofication
{
    NSDictionary *userInfo = [nofication userInfo];
    
    //取出keyboard的frame
    NSValue *frameValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [frameValue CGRectValue];
    
    //textView新的frame
    CGRect newframe = CGRectMake(0, MainScreenHeight - keyboardRect.size.height-44, toolBar.frame.size.width, 44);
    
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
    
    toolBar.frame = newframe;
    
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
    
    toolBar.frame = CGRectMake(0,MainScreenHeight - 44 , MainScreenWidth, 44);
    
    [UIView commitAnimations];
}

#pragma -mark- 文本内容改变事件
-(void)textViewDidChange:(UITextView *)textView
{

    UILabel *l = (UILabel*)[textView viewWithTag:111];
    
    if ([textView.text isEqualToString:@""])
    {
        
        l.hidden = NO;
    }
    else
    {
        l.hidden = YES;
    }
    
    if (![textView.text isEqualToString:@""])
    {
        
        
        //发送按钮背景颜色橙色
         [sendBtn setBackgroundColor:[UIColor orangeColor]];
        
         sendBtn.enabled = YES;
        
    }
    
    else
    {
        //颜色为灰色
        [sendBtn setBackgroundColor:[UIColor whiteColor]];
        
        sendBtn.enabled = NO;
    
    }
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
