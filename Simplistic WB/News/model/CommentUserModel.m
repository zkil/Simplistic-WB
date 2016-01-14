//
//  CommentUserModel.m
//  Simplistic WB
//
//  Created by Ibokan1 on 11/29/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "CommentUserModel.h"

@implementation CommentUserModel

-(instancetype)initWitDic:(NSDictionary*)dic
{

    if (self = [super init]) {
        
        self.user_Name = dic[@"name"];
        
        self.user_img = dic[@"avatar_hd"];
        
    }
    
    return self;

}

@end
