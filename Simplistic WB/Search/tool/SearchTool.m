//
//  SearchTool.m
//  Simplistic WB
//
//  Created by wzk on 15/11/26.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import "SearchTool.h"

@implementation SearchTool
+(void)searchToolUsers:(NSString *)usersName WithCount:(int)count  success:(Success)success failure:(Failure)failure
{
    if ([usersName isEqualToString:@""]||usersName == nil) {
        NSLog(@"没有搜索的用户名字");
        return;
    }
  
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/search/suggestions/users.json"
                                  params:@{
                                           @"q":usersName,
                                           @"count":@(count)
                                           }
     
                                 success:^(id JSON) {
                                     success(JSON);
                                 } failure:^(NSError *error) {
                                     failure(error);
                                 } method:@"GET"];
}
+(void)searchToolSchools:(NSString *)schoolName WithCount:(int)count  success:(Success)success failure:(Failure)failure
{
    if ([schoolName isEqualToString:@""]||schoolName == nil) {
        NSLog(@"没有搜索的学校名字");
        return;
    }

    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/search/suggestions/users.json"
                                  params:@{
                                           @"q":schoolName,
                                            @"count":@(count)
                                           }
     
                                 success:^(id JSON) {
                                     success(JSON);
                                 } failure:^(NSError *error) {
                                     failure(error);
                                 } method:@"GET"];
}
+(void)searchToolCompanies:(NSString *)companyName WithCount:(int)count  success:(Success)success failure:(Failure)failure
{
    if ([companyName isEqualToString:@""]||companyName == nil) {
        NSLog(@"没有搜索的公司名字");
        return;
    }
    
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/search/suggestions/companies.json"
                                  params:@{
                                           @"q":companyName,
                                            @"count":@(count)
                                           }
     
                                 success:^(id JSON) {
                                     success(JSON);
                                 } failure:^(NSError *error) {
                                     failure(error);
                                 } method:@"GET"];
}
+(void)searchToolApps:(NSString *)appName WithCount:(int)count  success:(Success)success failure:(Failure)failure
{
    if ([appName isEqualToString:@""]||appName == nil) {
        NSLog(@"没有搜索的应用名字");
        return;
    }
   
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/search/suggestions/apps.json"
                                  params:@{
                                           @"q":appName,
                                            @"count":@(count)
                                           }
     
                                 success:^(id JSON) {
                                     success(JSON);
                                 } failure:^(NSError *error) {
                                     failure(error);
                                 } method:@"GET"];
}
//+(void)searchToolAtUsers:(NSString *)atUserName WithCount:(int)count  success:(Success)success failure:(Failure)failure
//{
//    if ([atUserName isEqualToString:@""]||atUserName == nil) {
//        NSLog(@"没有搜索的at用户名字");
//        return;
//    }
//   
//    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/search/suggestions/at_users.json"
//                                  params:@{
//                                           @"type":@(0),
//                                           @"q":atUserName,
//                                           }
//     
//                                 success:^(id JSON) {
//                                     success(JSON);
//                                 } failure:^(NSError *error) {
//                                     failure(error);
//                                 } method:@"GET"];
//}
+(void)searchToolTopics:(NSString *)topicName WithCount:(int)count  success:(Success)success failure:(Failure)failure
{
    if ([topicName isEqualToString:@""]||topicName == nil) {
        NSLog(@"没有搜索的话题名字");
        return;
    }
   
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/search/topics.json"
                                  params:@{
                                           @"q":topicName,
                                           }
     
                                 success:^(id JSON) {
                                     success(JSON);
                                 } failure:^(NSError *error) {
                                     failure(error);
                                 } method:@"GET"];
}
@end
