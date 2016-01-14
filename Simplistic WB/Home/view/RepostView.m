//
//  RepostView.m
//  Simplistic WB
//
//  Created by wzk on 15/12/1.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import "RepostView.h"
#import "ListImgView.h"
#import "Status.h"
#import "User.h"
#import "MLEmojiLabel.h"
#import "Usertool.h"
#define REPOST_SPACE 10.f
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface RepostView()
{
    //用户名
    UILabel *_screenName;
    //信息文本
    MLEmojiLabel *_statusText;
    //配图
    ListImgView *_listImageView;
    
}
@end
@implementation RepostView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self createSubViews];
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    }
    return self;
}
-(void)setDelegate:(UIViewController<StatusBaseCellViewDeleget,ListImgViewDelegete> *)delegate
{
    _delegate = delegate;
    _listImageView.delegate = delegate;
}
-(void)setRepostStatus:(Status *)repostStatus
{
    _repostStatus = repostStatus;
    [self settingSubViews];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma -mark- 创建子控件
-(void)createSubViews
{
    //用户名
    _screenName = [[UILabel alloc]init];
    _screenName.font = [UIFont systemFontOfSize:14];
    _screenName.textColor = [UIColor blueColor];
    _screenName.backgroundColor = [UIColor clearColor];
    _screenName.userInteractionEnabled = YES;
    [self addSubview:_screenName];
    //添加点击事件
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapUserAction:)];
    [_screenName addGestureRecognizer:tapGR];
    
    //文本信息
    _statusText = [[MLEmojiLabel alloc]init];
    _statusText.font = [UIFont systemFontOfSize:14];
    _statusText.numberOfLines = 0;
    _statusText.backgroundColor = [UIColor clearColor];
    [self addSubview:_statusText];
    
    //配图
    _listImageView = [[ListImgView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_listImageView];
    
}
#pragma -mark- 设置子控件
-(void)settingSubViews
{
    _screenName.text = [NSString stringWithFormat:@"@%@:",self.repostStatus.user.screen_name];
    
   
    [self addML:_statusText WithString:self.repostStatus.text];
    //不存在配图则隐藏
    if (self.repostStatus.pic_urls.count != 0) {
        _listImageView.pic_urls = self.repostStatus.pic_urls;
        _listImageView.hidden = NO;
    }
    else
    {
        _listImageView.hidden = YES;
    }
}
#pragma -mark- 布局子控件
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = [_screenName sizeThatFits:CGSizeMake(self.frame.size.width - REPOST_SPACE * 2, 40)];
    _screenName.frame = CGRectMake(REPOST_SPACE, REPOST_SPACE, size.width, size.height);
    
    size = [_statusText sizeThatFits:CGSizeMake(self.frame.size.width - REPOST_SPACE * 2, MAXFLOAT)];
    CGFloat y = CGRectGetMaxY(_screenName.frame);
    _statusText.frame = CGRectMake(REPOST_SPACE, y, size.width, size.height);
    if (self.repostStatus.pic_urls.count != 0) {
        y = CGRectGetMaxY(_statusText.frame);
        CGRect rect = _listImageView.frame;
        rect.origin.x = REPOST_SPACE;
        rect.origin.y = y;
        _listImageView.frame = rect;
        
        //设置自身大小
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(_listImageView.frame) + REPOST_SPACE);
    }
    else
    {
        self.frame =CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(_statusText.frame) + REPOST_SPACE);
    }
}
-(void)tapUserAction:(UITapGestureRecognizer *)tapGR
{
    if (tapGR.state == UIGestureRecognizerStateEnded) {
        [self.delegate pushUserViewControllerWithUser:self.repostStatus.user];
    }
}
//特殊处理字体
-(void)addML:(MLEmojiLabel*)ML WithString:(NSString*)st
{
    
    
    
    ML.numberOfLines = 0;
    
    ML.emojiDelegate = self;
    
    ML.backgroundColor = [UIColor clearColor];
    
    ML.lineBreakMode = NSLineBreakByCharWrapping;
    
    ML.isNeedAtAndPoundSign = YES;
    
    ML.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    
    ML.customEmojiPlistName = @"expressionImage_custom.plist";                   [ML setEmojiText:@"微笑[微笑][白眼][白眼][白眼][白眼]微笑[愉快]---[冷汗][投降][抓狂][害羞]"];
    
    [ML setEmojiText:st];
    
}
//代理方法
- (void)mlEmojiLabel:(MLEmojiLabel*)emojiLabel didSelectLink:(NSString*)link withType:(MLEmojiLabelLinkType)type
{
    switch(type){
        case MLEmojiLabelLinkTypeURL:
            NSLog(@"点击了链接%@",link);
            break;
        case MLEmojiLabelLinkTypePhoneNumber:
            NSLog(@"点击了电话%@",link);
            break;
        case MLEmojiLabelLinkTypeEmail:
            NSLog(@"点击了邮箱%@",link);
            break;
        case MLEmojiLabelLinkTypeAt:
        {
            [Usertool UserToolGetUserinfoWithUserID:0 orName:[link substringFromIndex:1] Success:^(NSDictionary *dic) {
                User *user = [User mj_objectWithKeyValues:dic];
                [self.delegate pushUserViewControllerWithUser:user];
            } failurs:^(NSError *error) {
                
            }];
        }
            break;
        case MLEmojiLabelLinkTypePoundSign:
            NSLog(@"点击了话题%@",link);
            break;
        default:
            NSLog(@"点击了不知道啥%@",link);
            break;
    }
    
}

@end
