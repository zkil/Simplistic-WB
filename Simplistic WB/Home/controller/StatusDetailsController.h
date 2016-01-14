//
//  StatusDetailsController.h
//  Simplistic WB
//
//  Created by wzk on 15/12/5.
//  Copyright (c) 2015年 wzk. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "StatusTabMenu.h"
#import "StatusBaseCellView.h"
#import "StatusDetailsTableViewCell.h"
typedef enum{
    
    RepostsTable,
    CommentsTable,
    AttitudeTable
}SelectTable;

@class Status;
@interface StatusDetailsController : UIViewController<UITableViewDataSource,UITableViewDelegate,StatusBaseCellViewDeleget,StatusDetailsCellDelegate,ListImgViewDelegete,StatusTabMenuDelegte>
@property(nonatomic)Status *status;
//选择显示的列表
@property(nonatomic)SelectTable select;
@end
