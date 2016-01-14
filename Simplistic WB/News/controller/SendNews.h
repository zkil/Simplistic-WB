//
//  SendNews.h
//  Simplistic WB
//
//  Created by Ibokan1 on 12/9/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendNews : UIViewController

@property(nonatomic,copy)NSString *name;//传入的聊天对方的名字

@property(nonatomic)UIImage *img;//传入的聊天对方的头像

@property(nonatomic)UIImage *myImg;//我的头像;

@property(nonatomic,copy)NSString *myName; //我的姓名

@end
