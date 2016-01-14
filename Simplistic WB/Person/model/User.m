//
//  User.m
//  Simplistic WB
//
//  Created by wzk on 15/11/26.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import "User.h"

@implementation User
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id",
             @"describe":@"description"
             };
}

-(NSString *)created_at
{
    // 取出数据结构为: Sat Apr 19 19:15:53 +0800 2014，将数据格式化输出业务数据
    NSDateFormatter *dfm = [[NSDateFormatter alloc] init];
    dfm.dateFormat = @"EEE MMM dd HH:mm:ss zzzz yyyy";
    dfm.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    // 格式取出的字符串，获取时间对象
    NSDate *createdTime = [dfm dateFromString:_created_at];
    dfm.dateFormat = @"yyyy-M-d";
    return [dfm stringFromDate:createdTime];
}
@end
