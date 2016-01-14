//
//  Status.m
//  Simplistic WB
//
//  Created by wzk on 15/11/26.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import "Status.h"

@implementation Status
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id",
             @"status":@"retweeted_status"
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
    dfm.dateFormat = @"M月d日 HH点mm分";
    
    // 时间格式化成字符串
    NSString *createdTimeStr = [dfm stringFromDate:createdTime];
    
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:createdTime];
    NSTimeInterval second = time;       // 时间单位换算成 秒
    NSTimeInterval minute = time / 60;  // 时间单位换算成 分
    NSTimeInterval hour = minute / 60;  // 时间单位换算成 时
    NSTimeInterval day = hour / 24;     // 时间单位换算成 天
    NSTimeInterval year = day / 365;    // 时间单位换算成 年
    
    if (second < 60) {                  // 1分钟之内显示 "刚刚"
        return @"刚刚";
    } else if (minute < 60) {           // 1小时之内显示 "x分钟前"
        return [NSString stringWithFormat:@"%.f分钟前", minute];
    } else if (hour < 24) {             // 1天之内显示 "x小时前"
        return [NSString stringWithFormat:@"%.f小时前", hour];
    } else if (day < 7) {               // 1周之内显示 "x天前"
        return [NSString stringWithFormat:@"%.f天前", day];
    } else if (year >= 1) {             // 1年以前显示 "xxxx年x月x日"
        dfm.dateFormat = @"yyyy年M月d日";
        return [dfm stringFromDate:createdTime];
    } else {                            // 1年以内显示 "x月x日 x点x分"
        return createdTimeStr;
    }
}
-(NSString *)source
{
    // 源source结构为: <a href="http://app.weibo.com/t/feed/4ACxed" rel="nofollow">iPad客户端</a>
    NSInteger begin = [_source rangeOfString:@">"].location + 1;
    NSInteger end = [_source rangeOfString:@"</a>"].location;
    
    if (begin - 1 == NSNotFound||end == NSNotFound) {
        return @"未知";
    }
    NSString *tempStr = [_source substringWithRange:NSMakeRange(begin, end - begin)];
    
    // 从字符串取出"iPad客户端"再在前面拼接"来自"
    return [NSString stringWithFormat:@"来自%@", tempStr];
}
@end
