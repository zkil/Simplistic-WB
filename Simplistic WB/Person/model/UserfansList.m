//
//  UserfansList.m
//  Simplistic WB
//
//  Created by LXF on 15/12/2.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import "UserfansList.h"

@implementation UserfansList

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.screen_name = dict[@"screen_name"];
        self.profile_image_url = dict[@"avatar_large"];
        self.status_text = dict[@"status"][@"text"];
        self.follow_me = dict[@"follow_me"];
        self.ID = dict[@"idstr"];
    }
    return self;
}

#pragma mark - 2、类构造方法
+ (id)statusUserWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


@end
