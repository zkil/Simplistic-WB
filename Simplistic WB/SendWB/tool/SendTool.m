//
//  SendTool.m
//  Simplistic WB
//
//  Created by LXF on 15/11/26.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import "SendTool.h"
#import "SaveCountTool.h"
#import "AFNetworking.h"
@implementation SendTool
SaveCountTool *st;
+(void)sendToolSendStatus:(NSString *)statusText
{
    [HttpTool HttpToolPostWithBaseURL:@"https://api.weibo.com/" path:@"2/statuses/update.json" params:@{@"status":statusText} success:^(id JSON)
    {
    } failure:^(NSError *error)
    {
    } method:@"POST"];
}

+(void)sendToolSendStatus:(NSString *)statusText image:(NSData *)imagedata
{
    [HttpTool HttpToolPostWithBaseURL:@"https://api.weibo.com/" path:@"2/statuses/upload.json" params:@{@"status":statusText,@"pic":imagedata} success:^(id JSON)
     {
      //   NSLog(@"发送成功");
     } failure:^(NSError *error)
     {
         NSLog(@"%@",error);
     } method:@"POST"];
}
+ (void)sendWithImage:(UIImage*)image Withtext:(NSString*)text
{
    // URL: https://upload.api.weibo.com/2/statuses/upload.json
    // 参数:
    /**    status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**    access_token true string*/
    /**    pic true binary 微博的配图。*/
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    st = [[SaveCountTool alloc]init];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = st.saveCount.access_token_value;
    params[@"status"] = text;
    
    // 3.发送请求
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接文件数据
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"请求成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
}

@end
