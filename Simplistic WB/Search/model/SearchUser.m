//
//  SearchUser.m
//  Simplistic WB
//
//  Created by LXF on 15/12/3.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import "SearchUser.h"

@implementation SearchUser

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.screen_name = dict[@"screen_name"];
        self.followers_count = [dict[@"followers_count"] intValue];
        self.uid = [dict[@"uid"] intValue];
    }
    return self;
}

#pragma mark - 2、类构造方法
+ (id)statusUserWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


@end
