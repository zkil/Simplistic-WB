//
//  CommentReplyModel.h
//  Simplistic WB
//
//  Created by Ibokan1 on 11/30/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentReplyModel : NSObject

//评论者来自评论姓名
@property(nonatomic,copy)NSString* reply_Name;

//评论者来自评论内容
@property(nonatomic,copy)NSString* reply_text;

//初始化方法
-(instancetype)initWitDic:(NSDictionary*)dic;

@end
