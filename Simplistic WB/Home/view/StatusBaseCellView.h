//
//  StatusBaseCellView.h
//  Simplistic WB
//
//  Created by wzk on 15/12/9.
//  Copyright (c) 2015年 Ibokan1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListImgView.h"
#import "RepostView.h"
#import "MLEmojiLabel.h"
@class Status;
@interface StatusBaseCellView : UIView<MLEmojiLabelDelegate>
//头像
@property(nonatomic)UIImageView *avata;
//昵称
@property(nonatomic)UILabel *screenName;
//会员图标
@property(nonatomic)UIImageView *mbtypeImg;
//时间
@property(nonatomic)UILabel *time;
//来源
@property(nonatomic)UILabel *source;
//文本
@property(nonatomic)MLEmojiLabel *textLable;
//配图
@property(nonatomic)ListImgView *listView;
//转发内容
@property(nonatomic)RepostView *repostView;

@property(nonatomic)Status *status;

@property(nonatomic)UIViewController<StatusBaseCellViewDeleget,ListImgViewDelegete> *delegate;
@end
