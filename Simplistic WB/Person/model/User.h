//
//  User.h
//  Simplistic WB
//
//  Created by wzk on 15/11/26.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "Status.h"
@interface User : NSObject

@property(nonatomic)NSInteger uid;
@property(nonatomic)NSInteger ID;
//昵称
@property(nonatomic)NSString *screen_name;
//所在地
@property(nonatomic)NSString *location;
//个人简介
@property(nonatomic)NSString *describe;
//会员类型
@property(nonatomic)NSInteger mbtype;
//头像地址
@property(nonatomic)NSString *avatar_hd;
//性别
@property(nonatomic)NSString *gender;
//粉丝数
@property(nonatomic)NSInteger followers_count;
//关注数
@property(nonatomic)NSInteger friends_count;
//微博数
@property(nonatomic)NSInteger statuses_count;
//是否认证
@property(nonatomic)BOOL verified;
//认证原因
@property(nonatomic)NSString *verified_reason;

//创建时间
@property(nonatomic)NSString *created_at;
//最近一条微博
@property(nonatomic)Status *status;

@end
