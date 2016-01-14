//
//  SaveCount.h
//  Simplistic WB
//
//  Created by Ibokan1 on 11/26/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveCount : NSObject<NSCoding>

//access_token
@property(nonatomic,copy)  NSString *access_token_value;

//expires_in
@property(nonatomic,copy)   NSString *expires_in_value;

//remind_in
@property(nonatomic,copy)   NSString *remind_in_value;

//uid
@property(nonatomic,copy)   NSString *uid_value;

//从字典获取数据
-(instancetype)initByDictionary:(NSDictionary*)di;

@end
