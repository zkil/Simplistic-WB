//
//  SaveCount.m
//  Simplistic WB
//
//  Created by Ibokan1 on 11/26/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "SaveCount.h"

@implementation SaveCount

-(instancetype)initByDictionary:(NSDictionary *)dic
{

    if (self = [super init])
    {
        
        self.access_token_value = [dic objectForKey:@"access_token"];
        
        self.expires_in_value = [dic objectForKey:@"expires_in"];
        
        self.remind_in_value = [dic objectForKey:@"remind_in"];
        
        self.uid_value = [dic objectForKey:@"uid"];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.access_token_value forKey:@"access_token"];
    
    [aCoder encodeObject:self.uid_value forKey:@"uid"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
 
     if (self = [super init])

   {
       
     self.access_token_value = [aDecoder decodeObjectForKey:@"access_token"];
        
     self.uid_value = [aDecoder decodeObjectForKey:@"uid"];

   }
   return self;
    
    
}
@end
