//
//  Status.h
//  Simplistic WB
//
//  Created by wzk on 15/11/26.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@class User;
@interface Status : NSObject
//创建时间
@property(nonatomic)NSString *created_at;
//id
@property(nonatomic)long long ID;
@property(nonatomic)long long mid;
//文本
@property(nonatomic)NSString *text;
//微博来源
@property(nonatomic)NSString *source;
//微博的主人信息
@property(nonatomic)User *user;
//微博包含的转发微博
@property(nonatomic)Status *status;
//转发数
@property(nonatomic)NSInteger reposts_count;
//评论数
@property(nonatomic)NSInteger comments_count;
//表态数
@property(nonatomic)NSInteger attitudes_count;
//配图
@property(nonatomic)NSArray *pic_urls;
@end
