//
//  SearchTool.h
//  Simplistic WB
//
//  Created by wzk on 15/11/26.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpTool.h"

@interface SearchTool : NSObject
//搜索用户
+(void)searchToolUsers:(NSString *)userName WithCount:(int)count success:(Success)success failure:(Failure)failure;

//搜索学校
+(void)searchToolSchools:(NSString *)schoolName WithCount:(int)count  success:(Success)success failure:(Failure)failure;

//搜索公司
+(void)searchToolCompanies:(NSString *)companyName WithCount:(int)count  success:(Success)success failure:(Failure)failure;

//搜索应用
+(void)searchToolApps:(NSString *)appName WithCount:(int)count  success:(Success)success failure:(Failure)failure;

////@用户时的联想建议
//+(void)searchToolAtUsers:(NSString *)atUserName success:(Success)success failure:(Failure)failure;

@end
