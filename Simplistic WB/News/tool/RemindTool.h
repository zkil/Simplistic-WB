//
//  RemindTool.h
//  Simplistic WB
//
//  Created by Ibokan1 on 11/27/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemindTool : NSObject

//获取某个用户的各种消息未读数请求结果参数
typedef void(^UnreadCountSuccess)(id  json);
typedef void(^UnreadCountFailurs)(NSError * error);


//获取某个用户的各种消息未读数
+ (void)RemindToolGetUnreadCountWithUid:(long long)uid Success:(UnreadCountSuccess)success failurs:(UnreadCountFailurs)failure;
@end
