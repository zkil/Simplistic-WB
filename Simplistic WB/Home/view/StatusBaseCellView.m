//
//  StatusBaseCellView.m
//  Simplistic WB
//
//  Created by wzk on 15/12/9.
//  Copyright (c) 2015年 Ibokan1. All rights reserved.
//

#import "StatusBaseCellView.h"
#import "HttpTool.h"
#import "Status.h"
#import "User.h"
#import "Usertool.h"
#import "UIImage+Circle.h"
#define STATUS_SPACE 10
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation StatusBaseCellView
-(instancetype)init
{
    
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.userInteractionEnabled = YES;
        [self createSubViews];
        
    }
    return self;
}
#pragma -mark- 创建子控件
-(void)createSubViews
{
    _avata = [[UIImageView alloc]init];
    _avata.backgroundColor = [UIColor clearColor];
    UIImage *new =  [UIImage circleImage:[UIImage imageNamed:@"avatar_default_small@2x.png"] withParam:5];
    _avata.image = new;
    _avata.contentMode = UIViewContentModeScaleAspectFit;
    _avata.userInteractionEnabled = YES;
    [self addSubview:_avata];
    
    _screenName = [[UILabel alloc]init];
    _screenName.font = [UIFont systemFontOfSize:15.f];
    _screenName.backgroundColor = [UIColor clearColor];
    _screenName.userInteractionEnabled = YES;
    [self addSubview:_screenName];
    
    _mbtypeImg = [[UIImageView alloc]init];
    _mbtypeImg.backgroundColor = [UIColor clearColor];
    _mbtypeImg.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_mbtypeImg];
    
    _time = [[UILabel alloc]init];
    _time.font = [UIFont systemFontOfSize:12.f];
    [self addSubview:_time];
    
    _source = [[UILabel alloc]init];
    _source.font = [UIFont systemFontOfSize:12.f];
    [self addSubview:_source];
    
    _textLable = [[MLEmojiLabel alloc]init];
    _textLable.font = [UIFont systemFontOfSize:15.f];
    _textLable.backgroundColor = [UIColor clearColor];
    _textLable.numberOfLines = 0;
    [self addSubview:_textLable];
    
    _listView = [[ListImgView alloc]initWithFrame:CGRectZero];
    [self addSubview:_listView];
    
    _repostView = [[RepostView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - STATUS_SPACE * 2 , _repostView.frame.size.height)];
    
    [self addSubview:_repostView];
    
    //添加点击头像，名字事件监听
    UITapGestureRecognizer *tapAvataGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapUserAction:)];
    [_avata addGestureRecognizer:tapAvataGR];
    
    
    UITapGestureRecognizer *tapScreenNameGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapUserAction:)];
    [_screenName addGestureRecognizer:tapScreenNameGR];
    //转发内容点击事件
    
    UITapGestureRecognizer *tapRepostViewGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRepostStatusAction:)];
    [_repostView addGestureRecognizer:tapRepostViewGR];
    
    
}

-(void)setStatus:(Status *)status
{
    
    _status = status;
    //设置子视图内容
    [self settingSubViews];
    //标记子视图需要更新，在下面方法调用后视图立即更新
    [self setNeedsLayout];
    //立即更新视图
    [self layoutIfNeeded];
}
-(void)setDelegate:(UIViewController<StatusBaseCellViewDeleget,ListImgViewDelegete> *)delegate
{
    _delegate = delegate;
    _listView.delegate = delegate;
    _repostView.delegate = delegate;
}
#pragma -mark- 设置控件内容
-(void)settingSubViews
{
    UIImage *new =  [UIImage circleImage:[UIImage imageNamed:@"avatar_default_small@2x.png"] withParam:5];
    _avata.image = new;
    //请求异步加载图像
    [HttpTool HttpToolDowmloadImageWithURL:self.status.user.avatar_hd success:^(id object) {
          UIImage *new =  [UIImage circleImage:object withParam:5];
        _avata.image = new;
    } failure:^(NSError *error) {
        NSLog(@"avata %@",error);
    }];
    
    _screenName.text = self.status.user.screen_name;
    
    //会员图标
    if (self.status.user.mbtype) {
        _mbtypeImg.image = [UIImage imageNamed:@"common_icon_membership@2x.png"];
        //会员昵称颜色
        _screenName.textColor = [UIColor orangeColor];
    }
    else
    {
        _mbtypeImg.image = [UIImage imageNamed:@"common_icon_membership_expired@2x.png"];
        _screenName.textColor = [UIColor blackColor];
    }
    
    _time.text = self.status.created_at;
    
    _source.text = self.status.source;
    
    //_textLable.text = self.status.text;
    [self addML:_textLable WithString:self.status.text];
    
    //是否有配图
    if (self.status.pic_urls.count != 0) {
        _listView.hidden = NO;
        _repostView.hidden = YES;
        
        _listView.pic_urls = self.status.pic_urls;
    }
    else
    {
        _listView.hidden = YES;
        
        //是否有转发微博
        if (self.status.status) {
            _repostView.hidden = NO;
            _repostView.repostStatus = self.status.status;
        }
        else
        {
            _repostView.hidden = YES;
        }
    }
    
}
-(void)layoutSubviews
{
    //必须先调用父类的方法 因为视图内不止有我们自己定义的子视图，如：选中背景视图等等。若没有调用，这些视图将会错乱
    [super layoutSubviews];
    //头像
    _avata.frame = CGRectMake(STATUS_SPACE, STATUS_SPACE, 50, 50);
    
    //昵称
    CGFloat x = CGRectGetMaxX(_avata.frame) + STATUS_SPACE;
    
    [_screenName sizeToFit];
    _screenName.frame = CGRectMake(x, STATUS_SPACE, _screenName.frame.size.width,_screenName.frame.size.height);
    
    
    //会员图标
    x = CGRectGetMaxX(_screenName.frame) + STATUS_SPACE;
    _mbtypeImg.frame = CGRectMake(x, STATUS_SPACE, 15, 15);
    
    //时间
    x = CGRectGetMaxX(_avata.frame) + STATUS_SPACE;
    CGFloat y = CGRectGetMaxY(_avata.frame);
    [_time sizeToFit];
    
    _time.frame = CGRectMake(x, y -  _time.frame.size.height, _time.frame.size.width, _time.frame.size.height);
    
    //来源
    x = CGRectGetMaxX(_time.frame) + STATUS_SPACE;
    [_source sizeToFit];
    _source.frame = CGRectMake(x, y -  _source.frame.size.height, _source.frame.size.width, _source.frame.size.height);
    
    //文本
    y = CGRectGetMaxY(_avata.frame) + STATUS_SPACE;
    CGSize size = [_textLable sizeThatFits:CGSizeMake(SCREEN_WIDTH - STATUS_SPACE *2, MAXFLOAT)];
    _textLable.frame = CGRectMake(STATUS_SPACE, y, size.width, size.height);
    
    y = CGRectGetMaxY(_textLable.frame) + STATUS_SPACE;
    //配图
    if (self.status.pic_urls.count != 0) {
        _listView.frame = CGRectMake(STATUS_SPACE, y, _listView.frame.size.width, _listView.frame.size.height);
        
        y = CGRectGetMaxY(_listView.frame) + STATUS_SPACE;
    }
    else
    {
        //是否有转发
        if (self.status.status) {
            _repostView.frame = CGRectMake(STATUS_SPACE, y, _repostView.frame.size.width, _repostView.frame.size.height);
            y = CGRectGetMaxY(_repostView.frame) + STATUS_SPACE;
            
        }
    }
    //设置cell的高度为contentView高度 使cell里面的控件点击事件有效范围为整个cell
    CGRect selfFrame = self.frame;
    selfFrame.size.height = y;
    self.frame = selfFrame;
}
//点击头像和昵称
-(void)tapUserAction:(UITapGestureRecognizer *)tapGR
{
    if (tapGR.state == UIGestureRecognizerStateEnded) {
        [self.delegate pushUserViewControllerWithUser:self.status.user];
    }
    
}
//点击转发内容
-(void)tapRepostStatusAction:(UITapGestureRecognizer *)tapGR
{
    
    if (tapGR.state == UIGestureRecognizerStateEnded) {
        [self.delegate pushStatusDetailsWith:self.status.status];
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
