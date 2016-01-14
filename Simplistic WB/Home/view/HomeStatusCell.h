//
//  HomeStatusCell.h
//  Simplistic WB
//
//  Created by wzk on 15/12/3.
//  Copyright (c) 2015年 wzk. All rights reserved.
//



#import "StatusTableViewCell.h"
#import "HomeStatusCellView.h"
//#import "StatusTabMenu.h"
@class Status;
@interface HomeStatusCell : UITableViewCell
@property(nonatomic)HomeStatusCellView *statusCellView;

@property(nonatomic)Status *status;
//{
//    UIViewController *_delegate;
//}
//@property(nonatomic)UIViewController<StatusTableViewCellDeleget,StatusTabMenuDelegte,ListImgViewDelegete> *delegate;
@end
