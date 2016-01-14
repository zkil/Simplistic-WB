//
//  CommentTool.m
//  Simplistic WB
//
//  Created by Ibokan1 on 11/27/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "CommentTool.h"
#import "HttpTool.h"

@implementation CommentTool

//根据微博ID返回某条微博的评论列表类方法
+ (void)CommentToolGetShowWithID:(long long)ID SinceID:(long long)sinceID MaxID:(long long)maxID Success:(ShowSuccess)success failurs:(ShowFailurs)failure
{
    NSDictionary *dic = @{@"id":@(ID),
                          @"since_id":@(sinceID),
                          @"max_id":@(maxID)
                          };
    
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/comments/show.json" params:dic success:^(id JSON)
     {
         if (success == nil) return;
         
         success(JSON);
         
     } failure:^(NSError *error)
     {
         if (failure == nil) return;
         
         failure(error);
         
     } method:@"GET"];
    
}

//获取用户发送及收到的评论列表类方法
+(void)CommentToolGetTimelineWithSinceID:(long long)sinceID MaxID:(long long)maxID Success:(TimelineSuccess)success failurs:(TimelineFailurs)failure
{
    
    NSDictionary *dic = @{
                          @"since_id":@(sinceID),
                          @"max_id":@(maxID)
                          };
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/comments/timeline.json" params:dic success:^(id JSON)
     {
         if (success == nil) return;
         
         success(JSON);
         
     } failure:^(NSError *error)
     {
         
         if (failure == nil) return;
         
         failure(error);
         
         
     } method:@"GET"];
    
}

//获取最新的提到当前登录用户的评论，即@我的评论类方法
+(void)CommentToolGetMentionsWithSinceID:(long long)sinceID MaxID:(long long)maxID Success:(MentionsSuccess)success failurs:(MentionsFailurs)failure
{
    
    NSDictionary *dic = @{
                          @"since_id":@(sinceID),
                          @"max_id":@(maxID)
                          };
    
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/comments/mentions.json" params:dic success:^(id JSON)
     {
         if (success == nil) return;
         
         success(JSON);
         
     } failure:^(NSError *error)
     {
         
         if (failure == nil) return;
         
         failure(error);
         
     } method:@"GET"];
    
}

//对一条微博进行评论
+(void)CommentToolPostCreateWithComment:(NSString *)comment ID:(long long)ID Comment_ori:(int)ori Success:(CreateSuccess)success failurs:(CreateFailurs)failure
{
    
    NSDictionary *dic = @{
                          @"comment":comment,
                          @"id":@(ID),
                          @"comment_ori":@(ori)
                          };
    
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/comments/create.json" params:dic success:^(id JSON)
     {
         
         if (success == nil) return;
         
         success(JSON);
         
     } failure:^(NSError *error)
     {
         
         if (failure == nil) return;
         
         failure(error);
         
     } method:@"POST"];
    
}

//删除一条评论cid
+(void)CommentToolPostDestoryWithCid:(long long)cid Success:(DestorySuccess)success failurs:(DestoryFailurs)failure
{
    
    NSDictionary *dic = @{
                          @"cid":@(cid)
                          };
    
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/comments/destroy.json" params:dic success:^(id JSON)
     {
         
         if (success == nil) return;
         
         success(JSON);
         
     } failure:^(NSError *error)
     {
         
         if (failure == nil) return;
         
         failure(error);
         
     } method:@"POST"];
    
}

//回复一条评论类方法
+(void)CommentToolPostReplyWithComment:(NSString *)comment ID:(long long)ID Comment_ori:(int)ori Cid:(long long)cid Success:(ReplySuccess)success failurs:(ReplyFailurs)failure
{
    
    NSDictionary *dic = @{
                          @"comment":comment,
                          @"cid":@(cid),
                          @"id":@(ID),
                          @"comment_ori":@(ori)
                          };
    
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/comments/reply.json" params:dic success:^(id JSON)
     {
         
         if (success == nil) return;
         
         success(JSON);
         
     } failure:^(NSError *error)
     {
         
         if (failure == nil) return;
         
         failure(error);
         
     } method:@"POST"];
    
}
@end
