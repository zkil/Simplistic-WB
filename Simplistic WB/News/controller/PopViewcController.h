//
//  PopViewcController.h
//  Simplistic WB
//
//  Created by Ibokan1 on 12/5/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsAtCell.h"
#import "NewScreenCell.h"
@interface PopViewcController : UIAlertController

@property(nonatomic) id cell;


//代理
@property (nonatomic,assign)id<skip>delegate;

@end
