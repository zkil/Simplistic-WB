//
//  RemindModel.m
//  Simplistic WB
//
//  Created by Ibokan1 on 12/6/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "RemindModel.h"

@implementation RemindModel

-(instancetype)initWithDic:(NSDictionary *)dic
{

    if (self = [super init]) {
        
        self._cmt = [dic[@"cmt"] intValue];
        
        self._dm = [dic[@"dm"]intValue];
        
        self._mention_cmt = [dic[@"mention_cmt"]intValue];
        
        self._mention_status  = [dic[@"mention_status"]intValue];
        
        self._status = [dic[@"status"]intValue];
        
       // NSLog(@"%d,%d,%d",self._mention_status,self._mention_cmt,self._cmt);
    }
    
    return self;
}

@end
