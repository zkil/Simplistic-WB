//
//  HomeStatusCellView.h
//  Simplistic WB
//
//  Created by wzk on 15/12/9.
//  Copyright (c) 2015年 Ibokan1. All rights reserved.
//

#import "StatusBaseCellView.h"
#import "StatusTabMenu.h"

@interface HomeStatusCellView : StatusBaseCellView
{
    UIViewController *_delegate;
}

@property(nonatomic)UIViewController<StatusBaseCellViewDeleget,StatusTabMenuDelegte,ListImgViewDelegete> *delegate;

@property(nonatomic)StatusTabMenu *tabMenu;
@end
