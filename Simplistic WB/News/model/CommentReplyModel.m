//
//  CommentReplyModel.m
//  Simplistic WB
//
//  Created by Ibokan1 on 11/30/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "CommentReplyModel.h"

@implementation CommentReplyModel

-(instancetype)initWitDic:(NSDictionary*)dic
{
    
    if (self = [super init]) {
        
        self.reply_Name = [dic[@"user"] objectForKey:@"name"];
        
        self.reply_text = dic[@"text"];
        
    }
    
    return self;
    
}

@end
