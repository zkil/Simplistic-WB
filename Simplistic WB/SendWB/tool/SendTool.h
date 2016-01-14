//
//  SendTool.h
//  Simplistic WB
//
//  Created by LXF on 15/11/26.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "httptool.h"
#import <UIKit/UIKit.h>
@interface SendTool : NSObject

//发送文字微博
+ (void)sendToolSendStatus:(NSString *)statusText;
//发送图片并上传微博
+ (void)sendToolSendStatus:(NSString *)statusText image:(NSData *)imagedata;

//发送图片上传微博
+ (void)sendWithImage:(UIImage*)image Withtext:(NSString*)text;

@end
