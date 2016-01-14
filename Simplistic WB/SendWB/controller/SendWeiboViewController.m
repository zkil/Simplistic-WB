//
//  SendWeiboViewController.m
//  Simplistic WB
//
//  Created by LXF on 15/12/9.
//  Copyright (c) 2015年 Ibokan1. All rights reserved.
//



#import "SendWeiboViewController.h"
#import "WriteWeiboViewController.h"
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height


@interface SendWeiboViewController ()

{
    UIView *toolview;
    UIImageView *imageview;
}

@end

@implementation SendWeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    toolview = [[UIView alloc]initWithFrame:CGRectMake(0, MainScreenHeight-44, MainScreenWidth, 44)];
    toolview.backgroundColor = [UIColor whiteColor];
    UIButton *deletebtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [deletebtn setImage:[UIImage imageNamed:@"alert_error_icon@2x.png"] forState:UIControlStateNormal];
    [deletebtn addTarget:self action:@selector(deletebtnAtion:) forControlEvents:UIControlEventTouchUpInside];
    deletebtn.frame = CGRectMake(MainScreenWidth/2-17, 5, 35, 35);
    deletebtn.tintColor = [UIColor redColor];
    deletebtn.alpha = 0.5;
    [toolview addSubview:deletebtn];
    [self.view addSubview:toolview];
    imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Default_splashscreen_slogan@2x.png"]];
    imageview.frame = CGRectMake((MainScreenWidth-200)/2, 150, 200, 60);
    [self.view addSubview:imageview];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(click) userInfo:nil repeats:NO];
    
}

-(void)deletebtnAtion:(UIButton*)sender
{
  //  NSLog(@"退出");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)click{
    int count = 6;
    int numsProcolumn = 3;
    CGFloat viewWH = 80;
    for (int i = 0; i < count; i ++) {
        
        int posY = 300;
        int row = i / numsProcolumn;
        int col = i % numsProcolumn;
        CGFloat margin = (self.view.frame.size.width - viewWH*numsProcolumn)/(numsProcolumn+1);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:[ NSString stringWithFormat:@"tabbar_compose_%d@2x",i+1 ]]forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickDel:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 30001+i;
        btn.bounds = CGRectMake(0, 0, 40, 40);
        btn.center = CGPointMake( col * 70, row *70);
        btn.frame = CGRectMake(margin + (margin+viewWH)*col, posY+(margin+viewWH)*row, viewWH, viewWH);
        [self.view addSubview:btn];
        //设置初始y方向偏移
        CGAffineTransform trans = CGAffineTransformTranslate  (btn.transform,  0, (400 + row *viewWH));
        btn.transform = trans;
        //清空偏移量的动画
        [UIView animateWithDuration:0.25 delay:i/10.0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            //清空偏移量
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            //抖动动画
            CAKeyframeAnimation *shakeAnim = [CAKeyframeAnimation animation];
            shakeAnim.keyPath = @"transform.translation.y";
            shakeAnim.duration = 0.15;
            CGFloat delta = 10;
            shakeAnim.values = @[@0, @(-delta), @(delta), @0];
            shakeAnim.repeatCount = 1;
            [btn.layer addAnimation:shakeAnim forKey:nil];
        }];
    }
}

// 点击发微博触发按钮
- (void)clickDel:(UIButton*)btn
{
    if (btn.tag%10 == 1 )
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        //设置代理
        [self.opendaldelegate openmodal];
        
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
