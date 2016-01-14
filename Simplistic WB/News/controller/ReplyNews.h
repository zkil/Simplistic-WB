//
//  ReplyNews.h
//  Simplistic WB
//
//  Created by Ibokan1 on 12/3/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol send <NSObject>

@optional

//发送回复方法
-(void)sendActionWithText:(NSString*)text;

@end

@interface ReplyNews : UIViewController

//代理
@property (nonatomic,assign)id<send>delegate;

@property(nonatomic)NSString* replyname;

@end
