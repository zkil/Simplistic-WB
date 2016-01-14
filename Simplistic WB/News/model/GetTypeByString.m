//
//  GetTypeByString.m
//  Simplistic WB
//
//  Created by Ibokan1 on 12/1/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "GetTypeByString.h"

@implementation GetTypeByString


//根据string获取图片的data
+(NSData*)getImgWithString:(NSString*)imgString
{
    NSData *data = nil;
    
    if (imgString)
    {
        
        //获取评论者头像url
        NSURL *userImgurl = [[NSURL alloc]initWithString:imgString];
        
        data = [[NSData alloc]initWithContentsOfURL:userImgurl];
        
        return data;
        
    }
    
    return data;
    
}

//根据string获取需要的时间
+(NSString*)getTimeWithString:(NSString*)timeString
{
    NSString *_time = nil;

    // 取出数据结构为: Sat Apr 19 19:15:53 +0800 2014，将数据格式化输出业务数据
    NSDateFormatter *dfm = [[NSDateFormatter alloc] init];
    
    dfm.dateFormat = @"EEE MMM dd HH:mm:ss zzzz yyyy";
    
    dfm.locale = [[NSLocale alloc]
                  initWithLocaleIdentifier:@"en_US"];
    
    // 格式取出的字符串，获取时间对象
    NSDate *createdTime = [dfm dateFromString:timeString];
    dfm.dateFormat = @"M-d HH:mm";
    
    // 时间格式化成字符串
    NSString *createdTimeStr = [dfm stringFromDate:createdTime];
    
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:createdTime];
    
    NSTimeInterval second = time;       // 时间单位换算成 秒
    
    NSTimeInterval minute = time / 60;  // 时间单位换算成 分
    
    NSTimeInterval hour = minute / 60;  // 时间单位换算成 时
    
    NSTimeInterval day = hour / 24;     // 时间单位换算成 天
    
    NSTimeInterval year = day / 365;    // 时间单位换算成 年
    
    if (second < 60)
    {
        // 1分钟之内显示 "刚刚"
        return @"刚刚";
        
    }

    else if (minute < 60)
    {
        // 1小时之内显示 "x分钟前"
        return [NSString stringWithFormat:@"%.f分钟前", minute];
        
    }
    else if (hour < 24)
    {
        // 1天之内显示 "x小时前"
        return [NSString stringWithFormat:@"%.f小时前", hour];
        
    }
    else if (day < 7)
    {
        
        // 1周之内显示 "x天前"
        return [NSString stringWithFormat:@"%.f天前", day];
        
    }
    else if (year >= 1)
    {
        
        // 1年以前显示 "xx年x月x日"
        dfm.dateFormat = @"yy-M-d HH:mm";
        
        return [dfm stringFromDate:createdTime];
        
        
    } else
    {
        
        // 1年以内显示 "x月x日 x点x分"
        return createdTimeStr;
        
    }

    return _time;
    
}


//根据string获取source
+(NSString*)getSourceWithString:(NSString*)sourceString
{
    
    NSString *time = nil;
    
    NSString *sourceStringCopy = [sourceString substringToIndex:sourceString.length-4];
    
    NSRange range = [sourceStringCopy rangeOfString:@">"];
    
    if (range.length)
    {
        
        NSInteger index = range.location + range.length;
        
        time = [sourceStringCopy substringFromIndex:index];
        
    }
    
    time = [NSString stringWithFormat:@"来自 %@",time];
    
    return time;
    
}


//正则表达式获取指定字符串
+(NSString*)RegularExpressionWith:(NSString*)regulex WithString:(NSString*)string
{
    
    NSString *returnst = nil;
    
    //正则表达式搜索内容
    NSString *regex1 = regulex;
    
    NSRegularExpression *regular1 = [NSRegularExpression regularExpressionWithPattern:regex1 options:0  error:nil];
    
    NSTextCheckingResult *match = [regular1 firstMatchInString:string                                                      options:0                                                       range:NSMakeRange(0, [string length])];
    
    returnst = [string substringWithRange:match.range];
    
    return returnst;
}

@end
