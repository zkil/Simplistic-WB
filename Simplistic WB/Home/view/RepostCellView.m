//
//  RepostCellView.m
//  Simplistic WB
//
//  Created by wzk on 15/12/10.
//  Copyright (c) 2015年 Ibokan1. All rights reserved.
//

#import "RepostCellView.h"
#import "User.h"
#import "HttpTool.h"



@implementation RepostCellView
-(instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(RepostSpace, RepostSpace, SCREEN_WIDTH - RepostSpace * 2, 80);

        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
        [self createSubViews];
    }
    return self;
}
-(void)createSubViews
{
    self.statusImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
    [self addSubview:self.statusImageView];
    
    self.screenNameLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.statusImageView.frame) + RepostSpace, RepostSpace, 0, 0)];
    self.screenNameLable.numberOfLines = 1;
    self.screenNameLable.font = [UIFont fontWithName:@"Helvetica" size:14];
    [self addSubview:self.screenNameLable];
    
    self.statusLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.statusImageView.frame) + RepostSpace, CGRectGetMaxY(self.screenNameLable.frame) + 2 * RepostSpace, self.frame.size.width - CGRectGetMaxX(self.statusImageView.frame) - 2 * RepostSpace, self.frame.size.height - CGRectGetMaxY(self.screenNameLable.frame) - 2 * RepostSpace)];
    self.statusLable.numberOfLines = 2;
    self.statusLable.font = [UIFont systemFontOfSize:15.f];
    self.statusLable.textColor = [UIColor grayColor];
    [self addSubview:self.statusLable];
}
-(void)setStatus:(Status *)status
{
    _status = status;
    if (status.pic_urls.count != 0) {
        [HttpTool HttpToolDowmloadImageWithURL:[[status.pic_urls firstObject] objectForKey:@"thumbnail_pic"] success:^(id JSON) {
            self.statusImageView.image = JSON;
        } failure:^(NSError *error) {
            NSLog(@"Repost load image %@",error);
        }];
    }else
    {
        [HttpTool HttpToolDowmloadImageWithURL:status.user.avatar_hd  success:^(id JSON) {
            self.statusImageView.image = JSON;
        } failure:^(NSError *error) {
            NSLog(@"Repost load image %@",error);
        }];
    }
    self.screenNameLable.text = [NSString stringWithFormat:@"@%@",status.user.screen_name];
    [self.screenNameLable sizeToFit];
    
    self.statusLable.text = status.text;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
