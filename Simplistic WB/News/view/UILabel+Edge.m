//
//  UILabel+Edge.m
//  Simplistic WB
//
//  Created by Ibokan1 on 12/6/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "UILabel+Edge.h"

#define TabNums 5.0
@implementation UILabel (Edge)
-(void)showPointAtindex:(NSInteger)index
{
    UIView *v1 = [UIView new];
    
    //设置Uivew的圆角宽度
    v1.layer.cornerRadius = 5.0;
    
    v1.backgroundColor = [UIColor redColor];
    
    v1.tag = 111;
    
    //确定红点横坐标位置
    v1.frame = CGRectMake(self.frame.size.width/3, 0, 20, 20);
    
    UILabel *la = [UILabel new];
    
    la.frame = CGRectMake(5, 0, 20, 18);
    
    la.text =[NSString stringWithFormat:@"%ld",(long)index];
    
    [self addSubview:v1];
    
    [v1 addSubview:la];
    
    
}
-(void)hidePoint
{
    
    UIView *v =[ self viewWithTag:111];
    
    [v removeFromSuperview];
}
@end
