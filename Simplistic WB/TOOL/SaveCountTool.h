//
//  SaveCountTool.h
//  Simplistic WB
//
//  Created by Ibokan1 on 11/26/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SaveCount.h"
#import <UIKit/UIKit.h>
@interface SaveCountTool : NSObject

@property(nonatomic)SaveCount *saveCount;

//存储用户姓名
@property(nonatomic)NSString * username;

//存储用户头像
@property(nonatomic)UIImage *userimg;

//类方法
+(SaveCountTool *)getInstance;

//归档
-(void)saveWithsaveCount:(SaveCount*)saveCount;

@end
