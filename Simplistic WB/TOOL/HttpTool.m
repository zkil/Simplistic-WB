

//
//  HttpTool.m
//  Simplistic WB
//
//  Created by Ibokan1 on 11/25/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "SaveCountTool.h"
#import "SaveCount.h"
@implementation HttpTool
+(void)HttpToolDowmloadImageWithURL:(NSString *)urlString success:(Success)success failure:(Failure)failure
{
    //不存在缓存才请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:20];
    AFHTTPRequestOperation *op  = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    op.responseSerializer = [AFImageResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    [op start];
}
+(void)HttpToolPostWithBaseURL:(NSString *)urlString path:(NSString *)pathString params:(NSDictionary *)params success:(Success)success failure:(Failure)failure method:(NSString *)method
{

    //获取传来的请求参数数据
    NSMutableDictionary *paramsDict = [[NSMutableDictionary alloc] initWithDictionary:params];
    
    //解码取出临时文件tmp中的数据
    SaveCountTool *st = [[SaveCountTool alloc]init];
    
    //存在access_token的情况
    if (st.saveCount.access_token_value)
    {
        //2.00FzN9BEqbTHFC82da178ee0qwankD 3686034607
        //把存在的access_token赋值给字典的key
        [paramsDict setObject:st.saveCount.access_token_value forKey:@"access_token"];
// [paramsDict setObject:@"2.00FzN9BEqbTHFC82da178ee0qwankD"forKey:@"access_token"];
//         [paramsDict setObject:@"3686034607" forKey:@"uid"];
    }

    
    //设置请求格式为JSON
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer]requestWithMethod:method URLString:[urlString stringByAppendingString:pathString] parameters:paramsDict error:nil];
    
    //新建一个请求操作
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    //设置响应格式
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    op.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain" ,@"text/html" ,nil];
    
    //请求完成响应
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        
        success(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        
        failure(error);
        
    }];
    
  
    //加入主队列
    [op start];
    
}

@end
