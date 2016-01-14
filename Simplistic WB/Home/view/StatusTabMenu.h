//
//  StatusTabMemu.h
//  Simplistic WB
//
//  Created by wzk on 15/12/5.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatusTabMenu,Status;

//定义一个协议 用来实现微博 转发 评论 点赞功能
@protocol StatusTabMenuDelegte <NSObject>
//弹出转发页面
-(void)pushRepostViewControllerWithStatus:(Status *)status atStatusTabMenu:(StatusTabMenu *)tabMenu;
//弹出评论页面
-(void)pushCommentViewControllerWithStatus:(Status *)status atStatusTabMenu:(StatusTabMenu *)tabMenu;
//点赞
-(void)attitudeWithStatus:(Status *)status atStatusTabMenu:(StatusTabMenu *)tabMenu;
@end

@interface StatusTabMenu : UIView

@property(nonatomic)Status *status;

@property(nonatomic)NSInteger repostsCount;
@property(nonatomic)NSInteger commentsCount;
@property(nonatomic)NSInteger attitudesCount;

@property(nonatomic)UIViewController<StatusTabMenuDelegte> *delegate;
@end
