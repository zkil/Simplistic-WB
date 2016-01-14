//
//  CommentTool.h
//  Simplistic WB
//
//  Created by Ibokan1 on 11/27/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentTool : NSObject

//根据微博ID返回某条微博的评论列表请求结果参数
typedef void(^ShowSuccess)(id  json);
typedef void(^ShowFailurs)(NSError * error);

//根据微博ID返回某条微博的评论列表请求结果参数
typedef void(^TimelineSuccess)(id  json);
typedef void(^TimelineFailurs)(NSError * error);

//获取最新的提到当前登录用户的评论，即@我的评论请求结果参数
typedef void(^MentionsSuccess)(id  json);
typedef void(^MentionsFailurs)(NSError * error);

//对一条微博进行评论请求结果参数
typedef void(^CreateSuccess)(id  json);
typedef void(^CreateFailurs)(NSError * error);

//删除一条评论请求结果参数
typedef void(^DestorySuccess)(id  json);
typedef void(^DestoryFailurs)(NSError * error);

//回复一条评论请求结果参数
typedef void(^ReplySuccess)(id  json);
typedef void(^ReplyFailurs)(NSError * error);

//*****************************************************//

//根据微博ID返回某条微博的评论列表
+ (void)CommentToolGetShowWithID:(long long)ID SinceID:(long long)sinceID MaxID:(long long)maxID Success:(ShowSuccess)success failurs:(ShowFailurs)failure;

//获取用户发送及收到的评论列表
+ (void)CommentToolGetTimelineWithSinceID:(long long)sinceID MaxID:(long long)maxID Success:(TimelineSuccess)success failurs:(TimelineFailurs)failure;

//获取最新的提到当前登录用户的评论，即@我的评论
+ (void)CommentToolGetMentionsWithSinceID:(long long)sinceID MaxID:(long long)maxID Success:(MentionsSuccess)success failurs:(MentionsFailurs)failure;

//对一条微博进行评论
+ (void)CommentToolPostCreateWithComment:(NSString*)comment ID:(long long)ID  Comment_ori:(int)ori Success:(CreateSuccess)success failurs:(CreateFailurs)failure;

//删除一条评论
+ (void)CommentToolPostDestoryWithCid:(long long)cid Success:(DestorySuccess)success failurs:(DestoryFailurs)failure;

//回复一条评论
+ (void)CommentToolPostReplyWithComment:(NSString*)comment ID:(long long)ID  Comment_ori:(int)ori Cid:(long long)cid Success:(ReplySuccess)success failurs:(ReplyFailurs)failure;


@end
