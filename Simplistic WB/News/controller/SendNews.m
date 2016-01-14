//
//  SendNews.m
//  Simplistic WB
//
//  Created by Ibokan1 on 12/9/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "SendNews.h"
#import "SaveCountTool.h"
#import "InformationViewController.h"
#import "NewsScreen.h"
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height
@interface SendNews ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{

    UIToolbar *toolBar; //工具栏
    
    UITextField * enterTF; //文本框
    
    UITableView *ta; //发送表
    
    NSString *sendString; //获取发送的内容
    
    NSMutableArray *NewsArr; //内容数组
    
    NSArray *NameArr; //uesrdefault中的名字数组
    
}
@end

@implementation SendNews

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NameArr = @[[NSMutableArray new],[NSMutableArray new]];
    
    NewsArr = [NSMutableArray new];
    
   // self.view.backgroundColor = [UIColor lightGrayColor];
    
    SaveCountTool* st = [[SaveCountTool alloc]init];
    
    self.myName = st.username;
    
    self.myImg = st.userimg;
    
    [self checkHasData];
    
    [self initWithTableview];
    
    [self initWithToolBar];
    
    [self initWithNaviItem];
    
    //键盘出现通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    
    //键盘消失通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
}

#pragma -mark- 判断本地是否有数据
-(void)checkHasData
{
    //判断本地是否有此数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //取出
    NSArray *arr =[defaults arrayForKey:self.name];
    
    if (arr.count>0)
    {
        //赋值
        NewsArr = [NSMutableArray arrayWithArray:arr];
    }
    
    //取出
    NSArray *arr1 =[defaults arrayForKey:self.myName];
    
    if (arr1.count>0)
    {
        //赋值
        NameArr = [NSArray arrayWithArray:arr1];
    }
}

#pragma -mark- 初始化导航栏按钮
-(void)initWithNaviItem
{
    UIBarButtonItem *BA1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *BA2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *new = [[UIBarButtonItem alloc] initWithTitle:@"<消息" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    new.tintColor = [UIColor blackColor];
    
    UIBarButtonItem *opitonal =  [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    opitonal.tintColor = [UIColor blackColor];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:self.name style:UIBarButtonItemStylePlain target:self action:@selector(personByname)];
    
    back.tintColor = [UIColor blueColor];
    
    self.navigationItem.leftBarButtonItems =@[new,BA1,back,BA2,opitonal];
}

#pragma -mark- 初始化表
-(void)initWithTableview
{
    
    ta = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-toolBar.frame.size.height) style:UITableViewStyleGrouped];
    
    ta.delegate =self;
    
    ta.dataSource = self;
    
    ta.allowsSelection=NO;
    
    ta.showsVerticalScrollIndicator = NO;
    
    ta.backgroundColor = [UIColor whiteColor];
    //去除分割线
    ta.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:ta];
    
    
}

#pragma -mark- 初始化工具栏
-(void)initWithToolBar
{
    
    toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, MainScreenHeight-44, MainScreenWidth, 44)];
    
    toolBar.backgroundColor = [UIColor lightGrayColor];
    
    //添加滑动手势
    UISwipeGestureRecognizer *slide = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SlideAction)];
    
    slide.direction = UISwipeGestureRecognizerDirectionDown;
    
    toolBar.userInteractionEnabled = YES;
    
    [toolBar addGestureRecognizer:slide];
    
    enterTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
    
    enterTF.font = [UIFont systemFontOfSize:20];
    
    enterTF.borderStyle = UITextBorderStyleRoundedRect;
    
    enterTF.delegate = self;
    
    enterTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    enterTF.enablesReturnKeyAutomatically = YES;
    
    enterTF.returnKeyType = UIReturnKeyGo;
    
    enterTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    enterTF.clearsOnBeginEditing = YES;
    
    
    UIBarButtonItem * tfVector = [[UIBarButtonItem alloc] initWithCustomView:enterTF];
    
    UIButton *toolBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [toolBtn setFrame:CGRectMake(80, 0, 30, 30)];
    
    [toolBtn setBackgroundImage:[UIImage imageNamed:@"face4"] forState:UIControlStateNormal];
    
    UIBarButtonItem * sendVector = [[UIBarButtonItem alloc] initWithCustomView:toolBtn];
    
    [toolBar setItems:@[tfVector,sendVector]];
    
    [self.view addSubview:toolBar];
    
    [self.view bringSubviewToFront:toolBar];
    
}

#pragma -mark- 返回事件
-(void)back
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //发送过消息才储存
    if (NewsArr.count>0)
    {
    
    //储存在本地 聊天内容
    [defaults setObject:NewsArr forKey:self.name];
    
    if ([NameArr[0] indexOfObject:self.name]==NSNotFound)
    {
        [NameArr[0] addObject:self.name];
        
        //转为NSdata 保存
        NSData *data = UIImagePNGRepresentation(self.img);
        
        [NameArr[1] addObject:data];
    }
    //储存在本地 已聊天过的
    [defaults setObject:NameArr forKey:self.myName];
    
    }
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];

}

#pragma -mark- 点击进入个人页面事件
-(void)personByname
{
   
    InformationViewController * im = [InformationViewController new];
    
    //属性传值
    im.name = self.name;
    
    
    [self.navigationController pushViewController:im animated:YES];
    
}

#pragma -mark- 滑动手势
-(void)SlideAction
{

    //回收键盘
    [enterTF resignFirstResponder];
    
}
#pragma -mark- 开始编辑
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [textField becomeFirstResponder];
    
}
#pragma -mark- 编辑结束
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //获取此时的文本里面的内容
    sendString = textField.text;
    
    [NewsArr addObject:sendString];
    
    [ta reloadData];
    
    textField.text = @"";
    
    return YES;
}

#pragma -mark- tableview的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *la = [UILabel new];
    
    la.text =NewsArr[indexPath.row];
    
    la.font = [UIFont systemFontOfSize:20];
    
    la.numberOfLines = 0;
    
    CGSize la1Size = [la sizeThatFits:CGSizeMake(MainScreenWidth/2, 25)];
    
    return la1Size.height+30;
}
#pragma -mark- section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  
    return 1;
    
}
#pragma -mark- row
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return NewsArr.count;
}

#pragma -mark- tableviewCell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    static NSString *name= @"name";
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:name];
        
    }
    
    //设置文本
    UILabel* la1 = [UILabel new];
    
    la1.font = [UIFont systemFontOfSize:20];
    
    la1.text = NewsArr[indexPath.row];
    
    la1.textColor = [UIColor blueColor];
    
    la1.numberOfLines = 0;
    
    CGSize la1Size = [la1 sizeThatFits:CGSizeMake(MainScreenWidth/2, 25)];
    la1.frame = CGRectMake(15, 20,la1Size.width, la1Size.height);
    
    //设置背景图
    UIImage  *img = [UIImage imageNamed:@"SenderAppNodeBkg_HL"];
    //拉伸
//    {
//        img = [UIImage imageNamed:@"ReceiverTextNodeBkg"];
//    }
    img =  [img stretchableImageWithLeftCapWidth:floorf(img.size.width/2) topCapHeight:floorf(img.size.height/2)];
    
    UIImageView*  imgview = [UIImageView new];
    
    imgview.frame = CGRectMake(0, 14, la1.frame.size.width+35, la1.frame.size.height+20);
    
    imgview.image = img;
    
    //设置发送的view
    UIView*  returnView = [[UIView alloc] initWithFrame:CGRectZero];
    
    returnView.backgroundColor = [UIColor clearColor];
    
    returnView.frame = CGRectMake(MainScreenWidth-35-(la1.frame.size.width+30.0f), 0.0, la1.frame.size.width+30.0f, la1.frame.size.height+30.0f);
    
    [returnView addSubview:la1];
    
    [returnView addSubview:imgview];
    
    [returnView bringSubviewToFront:la1];
    
    //设置头像view
    UIImageView*   im = [[UIImageView alloc]initWithImage:self.myImg];
    
    im.frame =CGRectMake(MainScreenWidth-35, 0+18, 30, 30);
    

//  {
//    returnView.frame = CGRectMake(35, 0.0f, la1.frame.size.width+30.0f, la1.frame.size.height+30.0f);
//        im.image = [UIImage imageNamed:si.b[si.index_section-1]];
//        im.frame = CGRectMake(3, 0+18, 30, 30);
//    }
    
    [cell.contentView addSubview:returnView];
    
    [cell.contentView addSubview:im];

    
    return cell;
}

#pragma -mark-键盘出现通知
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

#pragma -mark-键盘消失通知
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
