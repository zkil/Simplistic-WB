//
//  SendWeiboViewController.h
//  Simplistic WB
//
//  Created by LXF on 15/12/9.
//  Copyright (c) 2015年 Ibokan1. All rights reserved.
//

#import <UIKit/UIKit.h>

//委托 打开发送微博的模态视图
@protocol OpenModalDelegate <NSObject>

-(void)openmodal;

@end

@interface SendWeiboViewController : UIViewController

@property (nonatomic,strong) id<OpenModalDelegate>opendaldelegate;

@end
