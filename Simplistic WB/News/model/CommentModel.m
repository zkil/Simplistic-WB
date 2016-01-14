//
//  CommentModel.m
//  Simplistic WB
//
//  Created by Ibokan1 on 11/27/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "CommentModel.h"
@implementation CommentModel

-(instancetype)initWithDic:(NSDictionary*)dic
{
    
    if (self = [super init]) {
        
        self.created_at = dic[@"created_at"];
        
        self.ID = [dic[@"id"] longLongValue];
        
        self.text = dic[@"text"];
        
        self.source = dic[@"source"];
    
        self.user =  [[CommentUserModel alloc]initWitDic:dic[@"user"]];
    
        self.idstr = dic[@"idstr"];
        
        self.status = [[CommentStatusModel alloc]initWitDic:dic[@"status"]];
;
        
        self.reply_comment =  [[CommentReplyModel alloc]initWitDic:  dic[@"reply_comment"]];
        
      //  NSLog(@"---------%@-------%ld--------%@------%@-------%@",self.created_at,self.ID,self.text,self.source,self.idstr);
    
        //NSLog(@"----%@------%@----",self.user.user_img,self.user.user_Name);   //头像avatar_hd  screen_name用户昵称 name友好显示名称
    
       // NSLog(@"----%@----",[dic[@"status"] objectForKey:@"id"]);  //bmiddle_pic缩略图片地址  text
    
       // NSLog(@"----%@----",self.reply_comment); //text uesr
    }
    return  self;
}

@end
