//
//  CommentModel.h
//  Simplistic WB
//
//  Created by Ibokan1 on 11/27/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentTool.h"
#import "CommentUserModel.h"
#import "CommentStatusModel.h"
#import "CommentReplyModel.h"
@interface CommentModel : NSObject

//评论创建时间
@property(nonatomic,copy) NSString*  created_at;

//评论的ID
@property(nonatomic) long long ID;

//评论的内容
@property(nonatomic,copy) NSString* text;

//评论的来源
@property(nonatomic,copy) NSString* source;

//评论作者的用户信息字段
@property(nonatomic,strong) CommentUserModel* user;

//字符串型的评论ID
@property(nonatomic,copy) NSString* idstr;

//评论的微博信息字段
@property(nonatomic,strong) CommentStatusModel *status;

//评论来源评论
@property(nonatomic,strong) CommentReplyModel* reply_comment;

//评论来源评论内容
@property(nonatomic,weak) NSString* reply_comment_text;

-(instancetype)initWithDic:(NSDictionary*)dic;

@end
