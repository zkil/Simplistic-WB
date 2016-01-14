//
//  MyInformationCell3.h
//  Simplistic WB
//
//  Created by LXF on 15/11/27.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInformationCell3 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *statuses_count;
@property (weak, nonatomic) IBOutlet UILabel *friends_count;
@property (weak, nonatomic) IBOutlet UILabel *followers_count;
@property (weak, nonatomic) IBOutlet UIButton *statuses_btn;
@property (weak, nonatomic) IBOutlet UIButton *friends_btn;
@property (weak, nonatomic) IBOutlet UIButton *followers_btn;

@end
