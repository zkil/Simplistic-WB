//
//  StatusDetailsTableViewCell.h
//  Simplistic WB
//
//  Created by wzk on 15/12/6.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusBaseCellView.h"

@protocol StatusDetailsCellDelegate <StatusBaseCellViewDeleget>
//点赞
-(void)attitudeWithStatus:(Status *)status atButton:(UIButton *)btn;

@end

@class Status;
@interface StatusDetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avata;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *statusText;
@property (weak, nonatomic) IBOutlet UILabel *attitudes;


@property(nonatomic)Status *status;
@property(nonatomic)UIViewController<StatusDetailsCellDelegate>*delegate;
@end
