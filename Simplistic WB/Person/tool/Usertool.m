//
//  Usertool.m
//  Simplistic WB
//
//  Created by LXF on 15/11/26.
//  Copyright (c) 2015年 wzk. All rights reserved.
//
//  3686034607


#import "Usertool.h"

@implementation Usertool

+(void)UserToolGetUserinfoWithUserID:(long long)UserID orName:(NSString *)screen_name Success:(UserSuccess)success failurs:(UserFailurs)failure
{
    if (screen_name == nil)
    {
        [HttpTool HttpToolPostWithBaseURL:@"https://api.weibo.com/" path:@"2/users/show.json" params:@{@"uid":@(UserID)}success:^(id JSON)
         {
             if (success == nil) return;
             success(JSON);
         } failure:^(NSError *error)
         {
             if (failure == nil) return;
             failure(error);
         }
        method:@"GET"];
    }
    else
    {
        [HttpTool HttpToolPostWithBaseURL:@"https://api.weibo.com/" path:@"2/users/show.json" params:@{@"screen_name":screen_name}success:^(id JSON)
         {
             if (success == nil) return;
             success(JSON);
         } failure:^(NSError *error)
         {
             if (failure == nil) return;
             failure(error);
         }
            method:@"GET"];
    }
    
}

+(void)UserToolGetUserInterestListWithUserID:(long long)UserID Success:(UserSuccess)success failurs:(UserFailurs)failure
{
    [HttpTool HttpToolPostWithBaseURL:@"https://api.weibo.com/" path:@"2/friendships/friends.json" params:@{@"uid":@(UserID),@"count":@(200),@"trim_status":@(0)}success:^(id JSON)
     {
         if (success == nil) return;
         success(JSON);
     } failure:^(NSError *error)
     {
         if (failure == nil) return;
         failure(error);
     }
        method:@"GET"];
}

+(void)UserToolGetUserfansListWithUserID:(long long)UserID Success:(UserSuccess)success failurs:(UserFailurs)failure
{
    [HttpTool HttpToolPostWithBaseURL:@"https://api.weibo.com/" path:@"2/friendships/followers.json" params:@{@"uid":@(UserID),@"trim_status":@(0)}success:^(id JSON)
     {
         if (success == nil) return;
         success(JSON);
     } failure:^(NSError *error)
     {
         if (failure == nil) return;
         failure(error);
     }
     method:@"GET"];
}

+(void)UserToolGetstatusSuccess:(UserSuccess)success failurs:(UserFailurs)failure
{
    [HttpTool HttpToolPostWithBaseURL:@"https://api.weibo.com/" path:@"2/statuses/user_timeline.json" params:@{@"feature":@(1)} success:^(id JSON)
     {
         if (success == nil) return;
         success(JSON);
     } failure:^(NSError *error)
     {
         if (failure == nil) return;
         failure(error);
     }
    method:@"GET"];
}


+(void)UserToolGetstatus:(NSString *)screenName Success:(UserSuccess)success failurs:(UserFailurs)failure
{
    [HttpTool HttpToolPostWithBaseURL:@"https://api.weibo.com/" path:@"2/statuses/user_timeline.json" params:@{@"screen_name":screenName} success:^(id JSON) {
        success(JSON);
    } failure:^(NSError *error) {
        failure(error);
    } method:@"GET"];
}


+(void)UserToolAttentionWithUserID:(long long)UserID Success:(UserSuccess)success failurs:(UserFailurs)failure
{
    [HttpTool HttpToolPostWithBaseURL:@"https://api.weibo.com/" path:@"2/friendships/create.json" params:nil success:^(id JSON) {
        success(JSON);
    } failure:^(NSError *error) {
        failure(error);
    } method:@"POST"];
}

+(void)UserToolCancelAttentionWithUserID:(long long)UserID Success:(UserSuccess)success failurs:(UserFailurs)failure
{
    [HttpTool HttpToolPostWithBaseURL:@"https://api.weibo.com/" path:@"2/friendships/destroy.json" params:nil success:^(id JSON) {
        success(JSON);
    } failure:^(NSError *error) {
        failure(error);
    } method:@"POST"];
}

+(void)UserToolSearchUserWithtext:(NSString *)text lineNumber:(int)line_number Success:(SeachSuccess)success failurs:(SeachFailurs)failure
{
    [HttpTool HttpToolPostWithBaseURL:@"https://api.weibo.com/" path:@"2/search/suggestions/users.json" params:@{@"q":text,@"count":@(line_number)} success:^(id JSON) {
        success(JSON);
    } failure:^(NSError *error) {
        failure(error);
    } method:@"GET"];
}

@end
