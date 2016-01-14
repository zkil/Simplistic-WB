//
//  HomeController.h
//  Simplistic WB
//
//  Created by wzk on 15/11/27.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusBaseCellView.h"
#import "StatusTabMenu.h"
@interface HomeController : UITableViewController<StatusBaseCellViewDeleget,StatusTabMenuDelegte,ListImgViewDelegete>
@property(nonatomic)NSMutableArray *tableData;
-(void)loadNewStatus;
-(void)loadMoreStatus;
@end
