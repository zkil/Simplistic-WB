//
//  HttpTool.h
//  Simplistic WB
//
//  Created by Ibokan1 on 11/25/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AppKey @"1907929462"
#define AppSecret @"3ecc823bd1ec96c2a87e069898c64b5b"
#define RedirectUri @"http://www.baidu.com"
#define BaseUrl @"https://api.weibo.com/"

typedef void (^Success)(id JSON);
typedef void (^Failure)(NSError *error);

@interface HttpTool : NSObject

+(void)HttpToolPostWithBaseURL:(NSString *)urlString path:(NSString *)pathString params:(NSDictionary *)params success:(Success)success failure:(Failure)failure method:(NSString *)method;

+(void)HttpToolDowmloadImageWithURL:(NSString *)urlString success:(Success)success failure:(Failure)failure;
@end
