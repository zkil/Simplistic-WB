//
//  RepostView.h
//  Simplistic WB
//
//  Created by wzk on 15/12/1.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListImgView.h"
#import "MLEmojiLabel.h"
@class Status,User;

@protocol StatusBaseCellViewDeleget<NSObject>
//弹出用户资料页面
-(void)pushUserViewControllerWithUser:(User *)user;
//弹出微博详情页面
-(void)pushStatusDetailsWith:(Status *)status;
@end

@interface RepostView : UIImageView<MLEmojiLabelDelegate>
@property(nonatomic)Status *repostStatus;
@property(nonatomic)UIViewController<StatusBaseCellViewDeleget,ListImgViewDelegete> *delegate;
@end
