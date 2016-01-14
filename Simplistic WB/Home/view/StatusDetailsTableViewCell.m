//
//  StatusDetailsTableViewCell.m
//  Simplistic WB
//
//  Created by wzk on 15/12/6.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import "StatusDetailsTableViewCell.h"
#import "Status.h"
#import "User.h"
@implementation StatusDetailsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    //添加点击头像，名字事件监听
    UITapGestureRecognizer *tapAvataGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapUserAction:)];
    [_avata addGestureRecognizer:tapAvataGR];
    
    
    UITapGestureRecognizer *tapScreenNameGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapUserAction:)];
    [_screenName addGestureRecognizer:tapScreenNameGR];
    //转发内容点击事件
}
-(void)setStatus:(Status *)status
{
    _status = status;
    self.screenName.text = self.status.user.screen_name;
    if (self.status.user.mbtype) {
        self.screenName.textColor = [UIColor orangeColor];
    }
    else
    {
        self.screenName.textColor = [UIColor blackColor];
    }
    self.time.text = status.created_at;
    self.statusText.text = status.text;
    if (self.status.attitudes_count) {
        self.attitudes.text = [NSString stringWithFormat:@"%ld",(long)self.status.attitudes_count];

    }
    }
- (IBAction)likeAction:(id)sender {
    [self.delegate attitudeWithStatus:self.status atButton:(UIButton *)sender];
}
//点击头像和昵称
-(void)tapUserAction:(UITapGestureRecognizer *)tapGR
{
    if (tapGR.state == UIGestureRecognizerStateEnded) {
        [self.delegate pushUserViewControllerWithUser:self.status.user];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
