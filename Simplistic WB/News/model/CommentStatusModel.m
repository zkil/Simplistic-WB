//
//  CommentStatusModel.m
//  Simplistic WB
//
//  Created by Ibokan1 on 11/30/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "CommentStatusModel.h"

@implementation CommentStatusModel

-(instancetype)initWitDic:(NSDictionary*)dic
{
    
    if (self = [super init]) {
        
        self.status_Text = dic[@"text"];
        
        self.status_img = dic[@"bmiddle_pic"];
        
        self.status_user_name = [dic[@"user"] objectForKey:@"name"];
        
        self.ID = [dic[@"id"] longLongValue];
     
    }
    
    return self;
    
}

@end
