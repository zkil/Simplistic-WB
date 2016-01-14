//
//  RemindTool.m
//  Simplistic WB
//
//  Created by Ibokan1 on 11/27/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "RemindTool.h"
#import "HttpTool.h"
@implementation RemindTool

//获取某个用户的各种消息未读数类方法
+(void)RemindToolGetUnreadCountWithUid:(long long)uid Success:(UnreadCountSuccess)success failurs:(UnreadCountFailurs)failure
{
    
    NSDictionary *dic = @{@"uid":@(uid)};
    
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"2/remind/unread_count.json" params:dic success:^(id JSON)
     {
         
         if (success == nil) return;
         
         success(JSON);
         
     } failure:^(NSError *error)
     {
         
         if (failure == nil) return;
         
         failure(error);
         
     } method:@"GET"];
    
    
}

@end

