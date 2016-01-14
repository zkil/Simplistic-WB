//
//  RepostCellView.h
//  Simplistic WB
//
//  Created by wzk on 15/12/10.
//  Copyright (c) 2015年 Ibokan1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"

#define RepostSpace 10
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface RepostCellView : UIView
@property (nonatomic)UIImageView *statusImageView;
@property (nonatomic)UILabel *screenNameLable;
@property (nonatomic)UILabel *statusLable;
@property(nonatomic)Status *status;
@end
