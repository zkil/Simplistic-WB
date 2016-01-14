//
//  CommentStatusModel.h
//  Simplistic WB
//
//  Created by Ibokan1 on 11/30/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentStatusModel : NSObject

//微博内容
@property(nonatomic,copy)NSString* status_Text;

//微博图片
@property(nonatomic,copy)NSString* status_img;

//微博的user
@property(nonatomic,copy)NSString* status_user_name;

//微博的id
@property(nonatomic)long long ID;

//初始化方法
-(instancetype)initWitDic:(NSDictionary*)dic;

@end
