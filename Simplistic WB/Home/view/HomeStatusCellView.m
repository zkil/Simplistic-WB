//
//  HomeStatusCellView.m
//  Simplistic WB
//
//  Created by wzk on 15/12/9.
//  Copyright (c) 2015年 Ibokan1. All rights reserved.
//

#import "HomeStatusCellView.h"

@implementation HomeStatusCellView
@dynamic delegate;

-(instancetype)init
{
    if (self = [super init]) {
        _tabMenu = [[StatusTabMenu alloc]init];
        [self addSubview:_tabMenu];
        
    }
    return self;
}

//设置代理
-(void)setDelegate:(UIViewController<StatusBaseCellViewDeleget,StatusTabMenuDelegte,ListImgViewDelegete> *)delegate
{
    [super setDelegate:delegate];
    _tabMenu.delegate = delegate;
    _delegate = delegate;

}
//@dynamic delegate 必须自己定义set get方法
-(UIViewController *)delegate
{
    return _delegate;
}
-(void)setStatus:(Status *)status
{
    _tabMenu.status = status;
    [super setStatus:status];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect cellFarm = self.frame;

    CGRect tabMuneFrame = _tabMenu.frame;
    tabMuneFrame.origin.y = cellFarm.size.height;
    _tabMenu.frame = tabMuneFrame;

    //设置cell的frame
    cellFarm.size.height = CGRectGetMaxY(_tabMenu.frame);
    self.frame = cellFarm;
}

@end
