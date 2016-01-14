//
//  SearchUser.h
//  Simplistic WB
//
//  Created by LXF on 15/12/3.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchUser : NSObject

@property (nonatomic,copy)NSString *screen_name;
@property (nonatomic,assign)int followers_count;
@property (nonatomic,assign)int uid;

- (id)initWithDict:(NSDictionary *)dict;
+ (id)statusUserWithDict:(NSDictionary *)dict;

@end
