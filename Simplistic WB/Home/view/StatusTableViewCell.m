//
//  StatusTableViewCell.m
//  Simplistic WB
//
//  Created by wzk on 15/12/1.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import "StatusTableViewCell.h"
#import "ListImgView.h"
#import "RepostView.h"
#import "User.h"
#import "HttpTool.h"
#import "Status.h"
//#define STATUS_SPACE 10
//#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//@interface StatusTableViewCell()
//{
//@protected
//    //头像
//    UIImageView *_avata;
//    //昵称
//    UILabel *_screenName;
//    //会员图标
//    UIImageView *_mbtypeImg;
//    //时间
//    UILabel *_time;
//    //来源
//    UILabel *_source;
//    //文本
//    UILabel *_textLable;
//    //配图
//    ListImgView *_listView;
//    //转发内容
//    RepostView *_repostView;
//}
//@end
@implementation StatusTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.05];
//        [self createSubViews];
        _statusCellView = [[StatusBaseCellView alloc]init];
    }
    return self;
}
//#pragma -mark- 创建子控件
//-(void)createSubViews
//{
//    _avata = [[UIImageView alloc]init];
//    
//    _avata.backgroundColor = [UIColor clearColor];
//    _avata.image = [UIImage imageNamed:@"avatar_default_small@2x.png"];
//    _avata.contentMode = UIViewContentModeScaleAspectFit;
//    _avata.userInteractionEnabled = YES;
//    [self.contentView addSubview:_avata];
//    
//    _screenName = [[UILabel alloc]init];
//    _screenName.font = [UIFont systemFontOfSize:15.f];
//    _screenName.backgroundColor = [UIColor clearColor];
//    _screenName.userInteractionEnabled = YES;
//    [self.contentView addSubview:_screenName];
//    
//    _mbtypeImg = [[UIImageView alloc]init];
//    _mbtypeImg.backgroundColor = [UIColor clearColor];
//    _mbtypeImg.contentMode = UIViewContentModeScaleAspectFit;
//    [self.contentView addSubview:_mbtypeImg];
//    
//    _time = [[UILabel alloc]init];
//    _time.font = [UIFont systemFontOfSize:12.f];
//    [self.contentView addSubview:_time];
//    
//    _source = [[UILabel alloc]init];
//    _source.font = [UIFont systemFontOfSize:12.f];
//    [self.contentView addSubview:_source];
//    
//    _textLable = [[UILabel alloc]init];
//    _textLable.font = [UIFont systemFontOfSize:15.f];
//    _textLable.backgroundColor = [UIColor clearColor];
//    _textLable.numberOfLines = 0;
//    [self.contentView addSubview:_textLable];
//    
//    _listView = [[ListImgView alloc]initWithFrame:CGRectZero];
//    [self.contentView addSubview:_listView];
//    
//    _repostView = [[RepostView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - STATUS_SPACE * 2 , _repostView.frame.size.height)];
//
//    [self.contentView addSubview:_repostView];
//    
//    //添加点击头像，名字事件监听
//    UITapGestureRecognizer *tapAvataGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapUserAction:)];
//    [_avata addGestureRecognizer:tapAvataGR];
//    
//    
//    UITapGestureRecognizer *tapScreenNameGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapUserAction:)];
//    [_screenName addGestureRecognizer:tapScreenNameGR];
//    //转发内容点击事件
//    
//    UITapGestureRecognizer *tapRepostViewGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRepostStatusAction:)];
//    [_repostView addGestureRecognizer:tapRepostViewGR];
//
//    
//}
//
//-(void)setStatus:(Status *)status
//{
//    
//    _status = status;
//    //设置子视图内容
//    [self settingSubViews];
//    //标记子视图需要更新，在下面方法调用后视图立即更新
//    [self setNeedsLayout];
//    //立即更新视图
//    [self layoutIfNeeded];
//}
//-(void)setDelegate:(UIViewController<StatusTableViewCellDeleget,ListImgViewDelegete> *)delegate
//{
//    _delegate = delegate;
//    _listView.delegate = delegate;
//    _repostView.delegate = delegate;
//}
//#pragma -mark- 设置控件内容
//-(void)settingSubViews
//{
//    _avata.image = [UIImage imageNamed:@"avatar_default_small@2x.png"];
//    //请求异步加载图像
//    [HttpTool HttpToolDowmloadImageWithURL:self.status.user.avatar_hd success:^(id object) {
//        _avata.image = object;
//    } failure:^(NSError *error) {
//        NSLog(@"avata %@",error);
//    }];
//    
//    _screenName.text = self.status.user.screen_name;
//    
//    //会员图标
//    if (self.status.user.mbtype) {
//        _mbtypeImg.image = [UIImage imageNamed:@"common_icon_membership@2x.png"];
//        //会员昵称颜色
//        _screenName.textColor = [UIColor orangeColor];
//    }
//    else
//    {
//        _mbtypeImg.image = [UIImage imageNamed:@"common_icon_membership_expired@2x.png"];
//         _screenName.textColor = [UIColor blackColor];
//    }
//    
//    _time.text = self.status.created_at;
//    
//    _source.text = self.status.source;
//    
//    _textLable.text = self.status.text;
//    
//    //是否有配图
//    if (self.status.pic_urls.count != 0) {
//        _listView.hidden = NO;
//        _repostView.hidden = YES;
//        
//        _listView.pic_urls = self.status.pic_urls;
//    }
//    else
//    {
//        _listView.hidden = YES;
//        
//        //是否有转发微博
//        if (self.status.status) {
//            _repostView.hidden = NO;
//            _repostView.repostStatus = self.status.status;
//        }
//        else
//        {
//            _repostView.hidden = YES;
//        }
//    }
//    
//}
//-(void)layoutSubviews
//{
//    //必须先调用父类的方法 因为视图内不止有我们自己定义的子视图，如：选中背景视图等等。若没有调用，这些视图将会错乱
//    [super layoutSubviews];
//    //头像
//    _avata.frame = CGRectMake(STATUS_SPACE, STATUS_SPACE, 50, 50);
//    
//    //昵称
//    CGFloat x = CGRectGetMaxX(_avata.frame) + STATUS_SPACE;
//    
//    [_screenName sizeToFit];
//    _screenName.frame = CGRectMake(x, STATUS_SPACE, _screenName.frame.size.width,_screenName.frame.size.height);
//    
//    
//    //会员图标
//    x = CGRectGetMaxX(_screenName.frame) + STATUS_SPACE;
//    _mbtypeImg.frame = CGRectMake(x, STATUS_SPACE, 15, 15);
//    
//    //时间
//    x = CGRectGetMaxX(_avata.frame) + STATUS_SPACE;
//    CGFloat y = CGRectGetMaxY(_avata.frame);
//    [_time sizeToFit];
//    
//    _time.frame = CGRectMake(x, y -  _time.frame.size.height, _time.frame.size.width, _time.frame.size.height);
//    
//    //来源
//    x = CGRectGetMaxX(_time.frame) + STATUS_SPACE;
//    [_source sizeToFit];
//    _source.frame = CGRectMake(x, y -  _source.frame.size.height, _source.frame.size.width, _source.frame.size.height);
//    
//    //文本
//    y = CGRectGetMaxY(_avata.frame) + STATUS_SPACE;
//    CGSize size = [_textLable sizeThatFits:CGSizeMake(SCREEN_WIDTH - STATUS_SPACE *2, MAXFLOAT)];
//    _textLable.frame = CGRectMake(STATUS_SPACE, y, size.width, size.height);
//    
//    y = CGRectGetMaxY(_textLable.frame) + STATUS_SPACE;
//    //配图
//    if (self.status.pic_urls.count != 0) {
//        _listView.frame = CGRectMake(STATUS_SPACE, y, _listView.frame.size.width, _listView.frame.size.height);
//        
//        y = CGRectGetMaxY(_listView.frame) + STATUS_SPACE;
//    }
//    else
//    {
//        //是否有转发
//        if (self.status.status) {
//            _repostView.frame = CGRectMake(STATUS_SPACE, y, _repostView.frame.size.width, _repostView.frame.size.height);
//            y = CGRectGetMaxY(_repostView.frame) + STATUS_SPACE;
//            
//        }
//    }
//    //设置cell的高度为contentView高度 使cell里面的控件点击事件有效范围为整个cell
//    CGRect contentFrame = self.contentView.frame;
//    contentFrame.size.height = y;
//    self.contentView.frame = contentFrame;
//    
//    //self.backgroundColor = [UIColor yellowColor];
//    //self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, y);
//}
////点击头像和昵称
//-(void)tapUserAction:(UITapGestureRecognizer *)tapGR
//{
//    if (tapGR.state == UIGestureRecognizerStateEnded) {
//        [self.delegate pushUserViewControllerWithUser:self.status.user];
//    }
//    
//}
////点击转发内容
//-(void)tapRepostStatusAction:(UITapGestureRecognizer *)tapGR
//{
//
//    if (tapGR.state == UIGestureRecognizerStateEnded) {
//        [self.delegate pushStatusDetailsWith:self.status.status];
//    }
//}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
