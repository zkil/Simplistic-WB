//
//  UserInterestList.h
//  Simplistic WB
//
//  Created by LXF on 15/12/2.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInterestList : NSObject

@property (nonatomic,copy)NSString *screen_name;
@property (nonatomic,copy)NSString *profile_image_url;
@property (nonatomic,copy)NSString *status_text;
@property (nonatomic,copy)NSString *ID;


- (id)initWithDict:(NSDictionary *)dict;
+ (id)statusUserWithDict:(NSDictionary *)dict;

@end
