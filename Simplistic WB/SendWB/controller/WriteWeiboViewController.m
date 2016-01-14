//
//  WriteWeiboViewController.m
//  Simplistic WB
//
//  Created by LXF on 15/12/9.
//  Copyright (c) 2015年 Ibokan1. All rights reserved.
//


#import "WriteWeiboViewController.h"
#import "SendTool.h"
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height


@interface WriteWeiboViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    UILabel *la; //中心文本
    
    UIButton *sendBtn; //发送按钮
    
    UIToolbar *toolBar; //工具栏
    
    UITextView *vi;    // 写微博文本框
    
    UIButton *cancelBtn; //取消按钮
    
    UIToolbar *headtoolBar; //头部工具栏
    
    UIImageView *imageview; //微博图片
}

@end

@implementation WriteWeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];

    headtoolBar = [[UIToolbar alloc] initWithFrame: CGRectMake(0,0, MainScreenWidth, 60)];
    
    headtoolBar.backgroundColor = [UIColor whiteColor];
    
    imageview = [[UIImageView alloc]initWithFrame:CGRectMake(20, MainScreenHeight-390, 80, 80)];
    
    //imageview.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:imageview];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithTextView];
    
    [self initWithSendBtn ];
    
    [self initWithWillAppealTextBtn];
    
}

//回复评论框
-(void)initWithTextView
{
    vi  = [[UITextView alloc]initWithFrame:self.view.frame];
    
    vi.frame = CGRectMake(0, 60, MainScreenWidth, MainScreenHeight-450);
    
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
    l.text = @"分享新鲜事...";
    
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

//滑动手势
-(void)SlideAction
{
    
    //回收键盘
    [vi resignFirstResponder];
    
    //设置动画
    [UIView beginAnimations:@"aaaa" context:@"move"];
    
    [UIView setAnimationDuration:0.5];
    
    toolBar.frame = CGRectMake(0,MainScreenHeight-44 , MainScreenWidth, 44);
    
    [UIView commitAnimations];
    
    
}

//点击手势
-(void)TapAction
{
    
    //弹出键盘
    [vi becomeFirstResponder];
    
    //设置动画
    [UIView beginAnimations:@"bb" context:@"move"];
    
    [UIView setAnimationDuration:0.5];
    
    toolBar.frame = CGRectMake(0,MainScreenHeight-44-214-36, MainScreenWidth, 44);
    
    
    [UIView commitAnimations];
    
    
}

//导航栏上出现的UI
-(void)initWithWillAppealTextBtn
{
    //导航中心label
    la = [UILabel new];
    
    la.frame = CGRectMake(MainScreenWidth/3+30, headtoolBar.frame.size.height-35, 100, 20);
    
    la.text = @"发微博";
    
    [headtoolBar addSubview:la];
    
    //取消按钮

    cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [cancelBtn setFrame:CGRectMake(20, headtoolBar.frame.size.height-35, 50, 20)];
    
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //[cancelBtn setBackgroundColor:[UIColor grayColor]];
    
    //发送按钮
    
    sendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [sendBtn setFrame:CGRectMake(MainScreenWidth-70, headtoolBar.frame.size.height-35, 50, 20)];
    
    [sendBtn setBackgroundColor:[UIColor grayColor]];
    
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    
    sendBtn.enabled = NO;
    
    [sendBtn addTarget:self action:@selector(SendAction) forControlEvents:UIControlEventTouchUpInside];
    
    [headtoolBar addSubview:sendBtn];
    [headtoolBar addSubview:cancelBtn];
    
    [self.view addSubview:headtoolBar];
    [self.view bringSubviewToFront:headtoolBar];
    
}

//发送按钮方法
-(void)SendAction
{
    
    [vi resignFirstResponder];
    
    if (vi.text != nil)
    {
        if (imageview.image == nil)
        {
            [SendTool sendToolSendStatus:vi.text];
        }
        else
        {
            [SendTool sendWithImage:imageview.image Withtext:vi.text];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

//取消按钮方法
-(void)cancelAction
{
    [vi resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}


//添加toolbar栏
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
        
        if (i==0)
        {
            [toolBtn addTarget:self action:@selector(imageAtion:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        UIBarButtonItem * sendVector = [[UIBarButtonItem alloc] initWithCustomView:toolBtn];
        
        UIBarButtonItem *BA = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(imageAtion:)];
        
        [btnarr addObject:sendVector];
        
        [btnarr addObject:BA];
        
        
    }
    [toolBar setItems:btnarr];
    
    [self.view addSubview:toolBar];
    
    [self.view bringSubviewToFront:toolBar];
    
}

-(void)imageAtion:(UIBarButtonItem*)sender
{
    UIImagePickerController*photo=[[UIImagePickerController alloc]init];
    photo.delegate=self;
    [photo setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [photo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [photo setAllowsEditing:YES];
    [self presentViewController:photo animated:YES completion:nil];
}

//成功获得相片还是视频后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //获取图片裁剪的图
    UIImage* edit = [info objectForKey:UIImagePickerControllerOriginalImage];
    imageview.image = edit;
    //模态方式退出uiimagepickercontroller
    [picker dismissViewControllerAnimated:YES completion:nil];
}

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
        [sendBtn setBackgroundColor:[UIColor grayColor]];
        
        sendBtn.enabled = NO;
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
