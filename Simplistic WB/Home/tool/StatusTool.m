//
//  StatusTool.m
//  Simplistic WB
//
//  Created by wzk on 15/11/25.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import "StatusTool.h"



@implementation StatusTool
+(void)statusToolGetHomeWithSinceID:(long long)since maxID:(long long)max success:(Success)success failure:(Failure)failure
{
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/statuses/home_timeline.json"
                params:@{
                         @"since_id":@(since),
                         @"max_id":@(max),
                         @"count":@(10)
                         }
                         
                success:^(id JSON) {
                    success(JSON);
                } failure:^(NSError *error) {
                    failure(error);
                } method:@"GET"];
}
+(void)statusToolGetStatusWithID:(long long)statusID success:(Success)success failure:(Failure)failure
{
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/statuses/show.json"
                               params:@{
                                        @"id":@(statusID),
                                        }
     
                              success:^(id JSON) {
                                  success(JSON);
                              } failure:^(NSError *error) {
                                  failure(error);
                              } method:@"GET"];}
+(void)statusToolGetUserWithUid:(long long)uid sinceID:(long long)since maxID:(long long)max success:(Success)success failure:(Failure)failure{
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/statuses/user_timeline.json"
                                  params:@{
                                           @"uid":@(uid),
                                           @"since_id":@(since),
                                           @"max_id":@(max)
                                           }
     
                                 success:^(id JSON) {
                                     success(JSON);
                                 } failure:^(NSError *error) {
                                     failure(error);
                                 } method:@"GET"];
}
+(void)statusToolGetPublicWithPage:(long long)page success:(Success)success failure:(Failure)failure
{
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/statuses/public_timeline.json"
                                  params:@{
                                           @"page":@(page),
                                           @"count":@(10)
                                           }
     
                                 success:^(id JSON) {
                                     success(JSON);
                                 } failure:^(NSError *error) {
                                     failure(error);
                                 } method:@"GET"];
}
+(void)statusToolGetMentionsWithSinceID:(long long)since maxID:(long long)max success:(Success)success failure:(Failure)failure
{
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/statuses/mentions.json"
                                  params:@{
                                           @"since_id":@(since),
                                           @"max_id":@(max),
                                           @"count":@(10)
                                           }
     
                                 success:^(id JSON) {
                                     success(JSON);
                                 } failure:^(NSError *error) {
                                     failure(error);
                                 } method:@"GET"];
}
+(void)statusToolRepostWithID:(long long)statusID text:(NSString *)text success:(Success)success failure:(Failure)failure;
{
    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithObject:@(statusID) forKey:@"id"];
    //为空则不输入转发文本
    if (!((text == nil)||[text isEqualToString:@""])) {
        //转码
        //text = [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [mdic setObject:text forKey:@"status"];
    }
    

    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/statuses/repost.json"
                                  params:mdic
                                 success:^(id JSON) {
                                     success(JSON);
                                 } failure:^(NSError *error) {
                                     failure(error);
                                 } method:@"POST"];
}
+(void)statusToolDestroyWithID:(long long)statusID success:(Success)success failure:(Failure)failure
{
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/statuses/destroy.json"
                                  params:@{
                                           @"id":@(statusID),
                                           }
     
                                 success:^(id JSON) {
                                     success(JSON);
                                 } failure:^(NSError *error) {
                                     failure(error);
                                 } method:@"POST"];

}
+(void)statusToolUpdateWithText:(NSString *)text success:(Success)success failure:(Failure)failure
{
    if ((text == nil)||[text isEqualToString:@""]) {
        NSLog(@"没有输入发表的微博内容");
        return;
    }
    
    //转码
    //text = [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/statuses/update.json"
                                  params:@{
                                           @"status":text,
                                           }
     
                                 success:^(id JSON) {
                                     success(JSON);
                                 } failure:^(NSError *error) {
                                     failure(error);
                                 } method:@"POST"];
}
+(void)statusToolGetRepostsWithID:(long long)statusID sinceID:(long long)since maxID:(long long)max success:(Success)success failure:(Failure)failure
{
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/statuses/repost_timeline.json"
                               params:@{
                                        @"id":@(statusID),
                                        @"since_id":@(since),
                                        @"max_id":@(max),
                                        @"count":@(10)
                                        }
     
                              success:^(id JSON) {
                                  success(JSON);
                              } failure:^(NSError *error) {
                                  failure(error);
                              } method:@"GET"];
}
+(void)statusToolGetCommentsWithID:(long long)statusID sinceID:(long long)since maxID:(long long)max success:(Success)success failure:(Failure)failure
{
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/comments/show.json"
                               params:@{
                                        @"id":@(statusID),
                                        @"since_id":@(since),
                                        @"max_id":@(max),
                                        @"count":@(10)
                                        }
     
                              success:^(id JSON) {
                                  success(JSON);
                              } failure:^(NSError *error) {
                                  failure(error);
                              } method:@"GET"];
}
@end










