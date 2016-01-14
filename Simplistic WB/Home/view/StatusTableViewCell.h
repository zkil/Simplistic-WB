//
//  StatusTableViewCell.h
//  Simplistic WB
//
//  Created by wzk on 15/12/1.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ListImgView.h"
//#import "RepostView.h"
//@class Status,User;
#import "StatusBaseCellView.h"

@interface StatusTableViewCell : UITableViewCell
@property(nonatomic)StatusBaseCellView *statusCellView;
//@property(nonatomic)Status *status;
//-(void)settingSubViews;
//@property(nonatomic)UIViewController<StatusTableViewCellDeleget,ListImgViewDelegete> *delegate;
@end
