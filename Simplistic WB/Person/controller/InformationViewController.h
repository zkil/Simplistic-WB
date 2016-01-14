//
//  InformationViewController.h
//  Simplistic WB
//
//  Created by LXF on 15/11/30.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

//uid
@property(nonatomic)   long long  ClickUserID;

@property(nonatomic)   NSString* name;
@end
