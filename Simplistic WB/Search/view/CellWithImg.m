//
//  CellWithImg.m
//  Simplistic WB
//
//  Created by Ibokan1 on 12/9/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "CellWithImg.h"

@implementation CellWithImg

-(instancetype)init
{
    return [[[NSBundle mainBundle]loadNibNamed:@"CellWithImg" owner:nil options:nil]objectAtIndex:0];
}

@end
