//
//  CommentViewController.h
//  Simplistic WB
//
//  Created by wzk on 15/12/10.
//  Copyright (c) 2015年 Ibokan1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"
@interface CommentViewController : UIViewController<UITextViewDelegate>
@property(nonatomic)Status *status;
@end
