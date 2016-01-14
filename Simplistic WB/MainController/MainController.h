//
//  MainController.h
//  Simplistic WB
//
//  Created by Ibokan1 on 12/4/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveCountTool.h"
#import "SendWeiboViewController.h"
@interface MainController : UITabBarController<OpenModalDelegate>
{

    SaveCountTool *st ;
}
@end
