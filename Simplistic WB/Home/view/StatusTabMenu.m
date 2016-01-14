//
//  StatusTabMemu.m
//  Simplistic WB
//
//  Created by wzk on 15/12/5.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import "StatusTabMenu.h"
#import "Status.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface StatusTabMenu()
{
    
    UIButton *_repostBtn;
    UIButton *_commentBtn;
    UIButton *_attitudeBtn;
    
}
@end

@implementation StatusTabMenu
@synthesize repostsCount = _repostsCount,commentsCount = _commentsCount,attitudesCount = _attitudesCount;
-(instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
        self.userInteractionEnabled = YES;
        //顶部线条
        UIImageView *topLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"top_line@2x.png"]];
        topLine.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
        topLine.contentMode  = UIViewContentModeScaleAspectFill;
        topLine.alpha = 0.3;
        [self addSubview:topLine];
        
        //转发按钮
        _repostBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _repostBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/3, 30);
        [_repostBtn setImage:[UIImage imageNamed:@"icon_timeline_retweet@2x.png"] forState:UIControlStateNormal];
        _repostBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        _repostBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        _repostBtn.tintColor = [UIColor colorWithWhite:0.3 alpha:1];
        [_repostBtn addTarget:self action:@selector(repostAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_repostBtn];
        
        //分割图片
        UIImageView *lineImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line.png"]];
        lineImg.alpha = 0.4;
        lineImg.frame = CGRectMake(CGRectGetMaxX(_repostBtn.frame), 0, 1, self.frame.size.height);
        [self addSubview:lineImg];
        
        
        //评论按钮
        _commentBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _commentBtn.frame = CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 30);
        [_commentBtn setImage:[UIImage imageNamed:@"icon_timeline_comment@2x.png"] forState:UIControlStateNormal];
        _commentBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        _commentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        _commentBtn.tintColor = [UIColor colorWithWhite:0.3 alpha:1];;
        [_commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_commentBtn];
        
        lineImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line.png"]];
        lineImg.frame = CGRectMake(CGRectGetMaxX(_commentBtn.frame), 0, 1, self.frame.size.height);
        lineImg.alpha = 0.4;
        [self addSubview:lineImg];
        
        //点赞按钮
        _attitudeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _attitudeBtn.frame = CGRectMake((SCREEN_WIDTH/3)*2, 0, SCREEN_WIDTH/3, 30);
        [_attitudeBtn setImage:[UIImage imageNamed:@"icon_timeline_like@2x.png"] forState:UIControlStateNormal];
        _attitudeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        _attitudeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        _attitudeBtn.tintColor = [UIColor colorWithWhite:0.3 alpha:1];
        [_attitudeBtn addTarget:self action:@selector(attitudeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_attitudeBtn];
        
    }
    return self;
}
-(void)setStatus:(Status *)status
{
    _status = status;
    self.repostsCount = status.reposts_count;
    self.commentsCount = status.comments_count;
    self.attitudesCount = status.attitudes_count;
}
-(void)setRepostsCount:(NSInteger)repostsCount
{
    _repostsCount = repostsCount;
    //个数为0显示“转发”两字
    if (repostsCount == 0) {
        [_repostBtn setTitle:@"转发" forState:UIControlStateNormal];
        return;
    }
    [_repostBtn setTitle:[NSString stringWithFormat:@"%ld",(long)repostsCount] forState:UIControlStateNormal];
}
-(NSInteger)repostsCount
{
    return [_repostBtn.titleLabel.text integerValue];
}
-(void)setCommentsCount:(NSInteger)commentsCount
{
    _commentsCount = commentsCount;
    if (commentsCount == 0) {
        [_commentBtn setTitle:@"评论" forState:UIControlStateNormal];
        return;
    }
    _commentsCount = commentsCount;
    [_commentBtn setTitle:[NSString stringWithFormat:@"%ld",(long)commentsCount] forState:UIControlStateNormal];
}
-(NSInteger)commentsCount
{
    return [_commentBtn.titleLabel.text integerValue];
}
-(void)setAttitudesCount:(NSInteger)attitudesCount
{
    _attitudesCount = attitudesCount;
    if (attitudesCount == 0) {
        [_attitudeBtn setTitle:@"点赞" forState:UIControlStateNormal];
        return;
    }
    [_attitudeBtn setTitle:[NSString stringWithFormat:@"%ld",(long)attitudesCount] forState:UIControlStateNormal];
}
-(NSInteger)attitudesCount
{
    return [_attitudeBtn.titleLabel.text integerValue];
}


//转发
-(void)repostAction:(UIButton *)btn
{
    [self.delegate pushRepostViewControllerWithStatus:self.status atStatusTabMenu:self];
}
//评论
-(void)commentAction:(UIButton *)btn
{
    [self.delegate pushCommentViewControllerWithStatus:self.status atStatusTabMenu:self];
}
//点赞
-(void)attitudeAction:(UIButton *)btn
{
    [self.delegate attitudeWithStatus:self.status atStatusTabMenu:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
