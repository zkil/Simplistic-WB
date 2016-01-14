//
//  HomeStatusCell.m
//  Simplistic WB
//
//  Created by wzk on 15/12/3.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import "HomeStatusCell.h"
#import "Status.h"
#import "StatusTabMenu.h"
#import "ReplyNews.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//@interface HomeStatusCell()
//{
//    //工具菜单
//    
//    StatusTabMenu *_tabMenu;
//}
//@end

@implementation HomeStatusCell
//@dynamic delegate;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _statusCellView = [[HomeStatusCellView alloc]init];
        [self addSubview:_statusCellView];
        self.contentView.frame = _statusCellView.frame;
        self.frame = self.contentView.frame;
    }
    return self;
}

-(void)setStatus:(Status *)status
{
    
    _statusCellView.status = status;
    //self.frame = _statusCellView.frame;
    //self.contentView.frame = _statusCellView.frame;
   
}
//设置代理
//-(void)setDelegate:(UIViewController<StatusTableViewCellDeleget,StatusTabMemuDelegte,ListImgViewDelegete> *)delegate
//{
//    [super setDelegate:delegate];
//    _tabMenu.delegate = delegate;
//    _delegate = delegate;
//    
//}
//@dynamic delegate 必须自己定义set get方法
//-(UIViewController *)delegate
//{
//    return _delegate;
//}
//-(void)settingSubViews
//{
//    [super settingSubViews];
//    
//    [_tabMune setStatus:self.status];
//    
//}
//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//    CGRect cellFarm = self.contentView.frame;
//
//    CGRect tabMuneFrame = _tabMenu.frame;
//    tabMuneFrame.origin.y = cellFarm.size.height;
//    _tabMenu.frame = tabMuneFrame;
//    
//    //设置cell的frame
//    cellFarm.size.height = CGRectGetMaxY(_tabMenu.frame);
//    self.contentView.frame = cellFarm;
//}
//
@end
