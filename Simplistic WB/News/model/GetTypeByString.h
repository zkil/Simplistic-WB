//
//  GetTypeByString.h
//  Simplistic WB
//
//  Created by Ibokan1 on 12/1/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetTypeByString : NSObject


//根据string获取图片的data
+(NSData*)getImgWithString:(NSString*)imgString;

//根据string获取需要的时间
+(NSString*)getTimeWithString:(NSString*)timeString;

//根据string获取source
+(NSString*)getSourceWithString:(NSString*)sourceString;

//正则表达式获取指定字符串
+(NSString*)RegularExpressionWith:(NSString*)regulex WithString:(NSString*)string;


@end
