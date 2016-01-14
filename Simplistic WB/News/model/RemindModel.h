//
//  RemindModel.h
//  Simplistic WB
//
//  Created by Ibokan1 on 12/6/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemindModel : NSObject

//新微博未读数
@property(nonatomic) int _status;

//新粉丝数
@property(nonatomic) int _cmt;

//新评论数
@property(nonatomic) int _dm;

//新提及我的评论数
@property(nonatomic) int _mention_cmt;

//新提及我的微博数
@property(nonatomic) int _mention_status;

-(instancetype)initWithDic:(NSDictionary*)dic;

@end
