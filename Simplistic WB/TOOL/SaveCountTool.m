//
//  SaveCountTool.m
//  Simplistic WB
//
//  Created by Ibokan1 on 11/26/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "SaveCountTool.h"
#define FileName [ NSTemporaryDirectory() stringByAppendingPathComponent:@"rrr.txt"]

static SaveCountTool *saveCountTool = nil;

@implementation SaveCountTool

+(SaveCountTool *)getInstance
{
    if (saveCountTool == nil)
    {
        saveCountTool = [[[self class]alloc]init];
      
    }
    
    return saveCountTool;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (saveCountTool == nil)
    {
        
        saveCountTool = [super allocWithZone:zone];
        
    }
    
 
    
    return  saveCountTool;
}


- (id)init
{
    if (self = [super init])
    {
        
        //取出数据
        saveCountTool.saveCount = [NSKeyedUnarchiver unarchiveObjectWithFile:FileName];
       
    }
    return self;
}

-(void)saveWithsaveCount:(SaveCount *)saveCount

{

    _saveCount = saveCount;
    
    //存入数据
    [NSKeyedArchiver archiveRootObject:saveCount toFile:FileName];
    

}
@end
