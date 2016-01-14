//
//  StatusTool.h
//  Simplistic WB
//
//  Created by wzk on 15/11/25.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpTool.h"

@interface StatusTool : HttpTool
//获取登陆用户和关注人的微博
+(void)statusToolGetHomeWithSinceID:(long long)since maxID:(long long)max success:(Success)success failure:(Failure)failure;
+(void)statusToolGetStatusWithID:(long long)statusID success:(Success)success failure:(Failure)failure;

//用户发送过的微博
+(void)statusToolGetUserWithUid:(long long)uid sinceID:(long long)since maxID:(long long)max success:(Success)success failure:(Failure)failure;
//指定页数最新的公共微博
+(void)statusToolGetPublicWithPage:(long long)page success:(Success)success failure:(Failure)failure;
//获取@用户微博的列表
+(void)statusToolGetMentionsWithSinceID:(long long)since maxID:(long long)max success:(Success)success failure:(Failure)failure;
//转发一条微博
+(void)statusToolRepostWithID:(long long)statusID text:(NSString *)text success:(Success)success failure:(Failure)failure;
//删除微博
+(void)statusToolDestroyWithID:(long long)statusID success:(Success)success failure:(Failure)failure;
//发表文本微博
+(void)statusToolUpdateWithText:(NSString *)text success:(Success)success failure:(Failure)failure;


//获取指定微博的最新转发微博
+(void)statusToolGetRepostsWithID:(long long)statusID sinceID:(long long)since maxID:(long long)max success:(Success)success failure:(Failure)failure;
//获取微博的评论列表
+(void)statusToolGetCommentsWithID:(long long)statusID sinceID:(long long)since maxID:(long long)max success:(Success)success failure:(Failure)failure;
@end
