//
//  CommentUserModel.h
//  Simplistic WB
//
//  Created by Ibokan1 on 11/29/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentUserModel : NSObject

//评论者友好昵称
@property(nonatomic,copy)NSString* user_Name;

//评论者头像
@property(nonatomic,copy)NSString* user_img;

//初始化方法
-(instancetype)initWitDic:(NSDictionary*)dic;

@end
