//
//  Usertool.h
//  Simplistic WB
//
//  Created by LXF on 15/11/26.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "httptool.h"

typedef void(^UserSuccess)(NSDictionary *dic);
typedef void(^UserFailurs)(NSError * error);

typedef void(^SeachSuccess)(NSArray *arr);
typedef void(^SeachFailurs)(NSError * error);

@interface Usertool : NSObject

//根据用户ID 或名字 获取用户信息
+ (void)UserToolGetUserinfoWithUserID:(long long)UserID orName:(NSString*)screen_name Success:(UserSuccess)success failurs:(UserFailurs)failure;

//获取用户的关注列表
+ (void)UserToolGetUserInterestListWithUserID:(long long)UserID Success:(UserSuccess)success failurs:(UserFailurs)failure;

//获取用户的粉丝列表
+ (void)UserToolGetUserfansListWithUserID:(long long)UserID Success:(UserSuccess)success failurs:(UserFailurs)failure;

//获取用户发过的微博
+ (void)UserToolGetstatusSuccess:(UserSuccess)success failurs:(UserFailurs)failure;

//根据用户昵称获取微博
+ (void)UserToolGetstatus:(NSString *)screenName Success:(UserSuccess)success failurs:(UserFailurs)failure;

//关注用户
+ (void)UserToolAttentionWithUserID:(long long)UserID Success:(UserSuccess)success failurs:(UserFailurs)failure;

//取消关注用户
+ (void)UserToolCancelAttentionWithUserID:(long long)UserID Success:(UserSuccess)success failurs:(UserFailurs)failure;

//搜索用户
+ (void)UserToolSearchUserWithtext:(NSString *)text lineNumber:(int)line_number Success:(SeachSuccess)success failurs:(SeachFailurs)failure;



@end
