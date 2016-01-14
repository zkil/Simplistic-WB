//
//  NewIdentityController.m
//  Simplistic WB
//
//  Created by Ibokan1 on 11/25/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "NewIdentityController.h"
#import "LoginScreenController.h"
#define ScrollNum 4         //页数
#define MainWidth [UIScreen mainScreen].bounds.size.width   //屏幕宽度
#define MainHeight [UIScreen mainScreen].bounds.size.height //屏幕高度
@interface NewIdentityController ()<UIScrollViewDelegate>
{
    
    UIScrollView *NewIdenScroll; //滚动视图
    
    UIPageControl *NewIdenPage;   //翻页按钮
    
}
@end

@implementation NewIdentityController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initWithScroll];
    
    [self initWithPageControl];
    
    [self addImageToSrcollView];
}

#pragma -mark- 初始化滚动视图
-(void)initWithScroll
{
    //初始化
    NewIdenScroll = [[UIScrollView alloc]initWithFrame:self.view.frame];
    
    //设置滚动范围
    NewIdenScroll.contentSize =CGSizeMake([UIScreen mainScreen].bounds.size.width * ScrollNum, 0);
    
    //取消显示滚动条
    NewIdenScroll.showsHorizontalScrollIndicator = NO;
    
    //取消反弹
    NewIdenScroll.bounces = NO;
    
    //设置代理
    NewIdenScroll.delegate = self;
    
    //设置自动翻页
    NewIdenScroll.pagingEnabled = YES;
    
    [self.view addSubview:NewIdenScroll];
}

#pragma -mark- 初始化翻页按钮
-(void)initWithPageControl
{
    
    //初始化
    NewIdenPage = [[UIPageControl alloc]init];
    
    NewIdenPage.frame = CGRectMake(0, 0, 100, 20);
    
    //设置中心点
    NewIdenPage.center = CGPointMake(MainWidth * 0.5, MainHeight * 0.95);
    
    //设置页数
    NewIdenPage.numberOfPages = ScrollNum ;
    
    //设置默认页数
    NewIdenPage.currentPage = 0;
    
    //设置颜色
    NewIdenPage.currentPageIndicatorTintColor = [UIColor blueColor];
    
    [self.view addSubview:NewIdenPage];
}


#pragma -mark- 往ScrollView添加图片
-(void)addImageToSrcollView
{
    //循环加载图片
    for (int i = 0 ; i < ScrollNum; i++)
    {
        
        //初始化
        UIImageView *ImageView = [[UIImageView alloc]init];
        
        //设置frame
        ImageView.frame = CGRectMake(i * MainWidth, 0, MainWidth, MainHeight);
        
        //图片名字
        NSString  *imageName = [NSString stringWithFormat:@"page%d.jpg",i+1];
        
        //设置图片
        ImageView.image = [UIImage imageNamed:imageName];
        
        
        [NewIdenScroll addSubview:ImageView];
        
        //添加立即体验按钮
        if (i == ScrollNum - 1)
        {
            
            [self initWithOkBtn:ImageView];
            
        }
        
    }
    
}
#pragma -mark-立即体验按钮
-(void)initWithOkBtn:(UIImageView*)imagevIew
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    btn.frame = CGRectMake(0, 0, 180, 60);
    
    btn.center = CGPointMake(MainWidth * 0.5, MainHeight * 0.88);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"OS_Pad_guide_button@2x"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(EnterAction) forControlEvents:UIControlEventTouchUpInside];
    
    [imagevIew addSubview:btn];
    
    imagevIew.userInteractionEnabled = YES;
}

#pragma -mark- 立即进入按钮点击方法
-(void)EnterAction
{

    LoginScreenController *loginVC = [LoginScreenController new];
    
    self.view.window.rootViewController = loginVC;
    
    
}

#pragma -mark- ScrollView的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //偏转页码
    NewIdenPage.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
