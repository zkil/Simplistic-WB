//
//  RepostViewController.m
//  Simplistic WB
//
//  Created by wzk on 15/12/10.
//  Copyright (c) 2015年 Ibokan1. All rights reserved.
//

#import "RepostViewController.h"
#import "RepostCellView.h"
#import "StatusTool.h"
#import "User.h"
@interface RepostViewController ()
{
    UILabel *_titleLable; //中心文本
    
    UILabel *_userNameLable; // 用户名
    
    UILabel *_placeholder; //提示文本
    
    UITextView *_repostTextView;
    RepostCellView *_repostStatus;
    //键盘高度
    CGFloat keyboardHeight;
    
    UIButton *_sendBtn; //发送按钮
    
    
    UIToolbar *_toolBar; //工具栏
}
@end

@implementation RepostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置不延伸
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    //输入文本框
    _repostTextView = [[UITextView alloc]initWithFrame:CGRectMake(RepostSpace, RepostSpace, SCREEN_WIDTH - RepostSpace * 2, 200)];
    [_repostTextView becomeFirstResponder];
    _repostTextView.delegate = self;
    _repostTextView.font = [UIFont systemFontOfSize:15.f];
    [self.view addSubview:_repostTextView];
    
    
    
    //展示微博
    _repostStatus = [[RepostCellView alloc]init];
    CGRect repostCellFrame = _repostStatus.frame;
    repostCellFrame.origin.y = CGRectGetMaxY(_repostTextView.frame) + RepostSpace;
    _repostStatus.frame = repostCellFrame;
    [self.view addSubview:_repostStatus];
    
    //发送按钮
    _sendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_sendBtn setFrame:CGRectMake(0, 0, 38, 25)];
    [_sendBtn setBackgroundColor:[UIColor orangeColor]];
    [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    _sendBtn.layer.cornerRadius = 2;
    _sendBtn.enabled = NO;
    [_sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sendBtnItem = [[UIBarButtonItem alloc]initWithCustomView:_sendBtn];
    self.navigationItem.rightBarButtonItem = sendBtnItem;
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cancelBtn setFrame:CGRectMake(0, 0, 38, 25)];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
     cancelBtn.layer.cornerRadius = 2;
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc]initWithCustomView:cancelBtn];
    self.navigationItem.leftBarButtonItem = cancelBtnItem;

    
    //提示文本
    _placeholder = [UILabel new];
    _placeholder.frame = CGRectMake(5, 2, 150, 30);
    _placeholder.font = [UIFont systemFontOfSize:15.f];
    _placeholder.alpha = 0.3;
    _placeholder.text = @"分享新鲜事...";
    [_repostTextView addSubview:_placeholder];
    
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - CGRectGetMaxY(self.navigationController.navigationBar.frame) - 44, CGRectGetWidth(self.view.frame), 44)];
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
    
    //预输入
    //是否是转发微博
    if (self.status.status) {
        _repostTextView.text = [NSString stringWithFormat:@"//@%@:%@",self.status.user.screen_name,self.status.text];
        //展示原微博
        _repostStatus.status = self.status.status;
        
        //设置焦点位置
        NSRange range;
        range.location = 0;
        range.length = 0;
        _repostTextView.selectedRange = range;
        _placeholder.hidden = YES;
    }
    else
    {
        _repostStatus.status = self.status;
    }
    
    
    //添加滑动手势
    UISwipeGestureRecognizer *slide = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SlideAction)];
    slide.direction = UISwipeGestureRecognizerDirectionDown;
    [_repostTextView addGestureRecognizer:slide];

    
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //键盘消失通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}
-(void)viewWillAppear:(BOOL)animated
{
    //导航中心label
    _titleLable = [UILabel new];
    _titleLable.text = @"转发微博";
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
-(void)viewWillDisappear:(BOOL)animated
{
    [_titleLable removeFromSuperview];
    [_userNameLable removeFromSuperview];
}
#pragma -mark- 滑动手势
-(void)SlideAction
{
    
    //回收键盘
    [_repostTextView resignFirstResponder];
    
}
//发送事件
-(void)sendAction
{
    [StatusTool statusToolRepostWithID:self.status.ID text:_repostTextView.text success:^(id JSON) {
    
      } failure:^(NSError *error) {
        NSLog(@"sendAction %@",error);
    }];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)cancelAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma -mark- 键盘即将出现通知
-(void)keyboardWillShow:(NSNotification *)notication
{
    //获取键盘的高度
    NSDictionary *userInfo = [notication userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardHeight = keyboardRect.size.height;
    
    //textView新的frame
    CGRect newframe = CGRectMake(0, CGRectGetHeight(self.view.frame) - keyboardHeight - 44, _toolBar.frame.size.width, 44);
    
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
    
    
    //收缩
    if (CGRectGetMaxY(_repostTextView.frame) > (self.view.frame.size.height - CGRectGetHeight(_toolBar.frame) -  keyboardHeight) - 30) {
        CGRect textFrame = _repostTextView.frame;
        textFrame.size.height = (self.view.frame.size.height - CGRectGetHeight(_toolBar.frame) -  keyboardHeight) - 30;
        _repostTextView.frame = textFrame;
        
        CGRect repostCellFrame = _repostStatus.frame;
        repostCellFrame.origin.y = CGRectGetMaxY(_repostTextView.frame) + RepostSpace;
        _repostStatus.frame = repostCellFrame;

    }
    

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
    
    //是否压缩状态
    if (_repostTextView.contentSize.height - 30 > _repostTextView.frame.size.height) {
        //伸开
        [UIView beginAnimations:nil context:nil];
        if (CGRectGetHeight(self.view.frame) - CGRectGetMaxY(self.navigationController.navigationBar.frame)  - CGRectGetHeight(_repostStatus.frame) + RepostSpace - 30> _repostTextView.contentSize.height) {
            CGRect textFrame = _repostTextView.frame;
            textFrame.size.height = _repostTextView.contentSize.height - 30;
            _repostTextView.frame = textFrame;
            
            CGRect repostCellFrame = _repostStatus.frame;
            repostCellFrame.origin.y = CGRectGetMaxY(_repostTextView.frame) + RepostSpace;
            _repostStatus.frame = repostCellFrame;
        }
        else
        {
            CGRect textFrame = _repostTextView.frame;
            textFrame.size.height = CGRectGetHeight(self.view.frame) - CGRectGetHeight(_toolBar.frame)  - CGRectGetHeight(_repostStatus.frame);
            _repostTextView.frame = textFrame;
            
            CGRect repostCellFrame = _repostStatus.frame;
            repostCellFrame.origin.y = CGRectGetMaxY(_repostTextView.frame) + RepostSpace;
            _repostStatus.frame = repostCellFrame;

        }
        [UIView commitAnimations];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_repostTextView resignFirstResponder];
}
-(void)textViewDidChange:(UITextView *)textView
{
    if (![textView.text isEqualToString:@""])
    {
        _placeholder.hidden = YES;
        
        //发送按钮背景颜色橙色
        [_sendBtn setBackgroundColor:[UIColor orangeColor]];
        [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _sendBtn.enabled = YES;
        
    }
    else
    {
        _placeholder.hidden = NO;
        
        //颜色为
        [_sendBtn setBackgroundColor:[UIColor whiteColor]];
        [_sendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _sendBtn.enabled = NO;
        
    }

    //展示微博下移
    if (textView.contentSize.height > 200) {
        if (textView.contentSize.height > (self.view.frame.size.height - CGRectGetHeight(_toolBar.frame) -  keyboardHeight) - 30) {
            return;
        }
        CGRect textFrame = textView.frame;
        textFrame.size.height = textView.contentSize.height;
        textView.frame = textFrame;
        CGRect repostCellFrame = _repostStatus.frame;
        repostCellFrame.origin.y = CGRectGetMaxY(_repostTextView.frame) + RepostSpace;
        _repostStatus.frame = repostCellFrame;
    }
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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
