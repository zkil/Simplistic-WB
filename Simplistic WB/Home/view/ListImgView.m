//
//  ListImgView.m
//  Simplistic WB
//
//  Created by wzk on 15/11/30.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import "ListImgView.h"
#import "HttpTool.h"
#import "ImgView.h"
//配图间隔
#define IMGVIEW_SPACE 5
//配图的宽度
#define IMGVIEW_WIDTH 80


@interface ListImgView()
{
}
@end

@implementation ListImgView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
        for (int i = 0; i < 9; i++) {
            ImgView *imgView = [[ImgView alloc]init];
            //保持高宽比
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            imgView.backgroundColor = [UIColor clearColor];
            imgView.image = [UIImage imageNamed:@"timeline_image_loading.png"];
            imgView.userInteractionEnabled = YES;
            [self addSubview:imgView];

            UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showImageOriginal_pic:)];
            [imgView addGestureRecognizer:tapGR];
        }
        
       
    }
    return self;
}
#pragma -mark- 图片点击事件
-(void)showImageOriginal_pic:(UITapGestureRecognizer *)tapGR
{
    ImgView *imgView = (ImgView *)tapGR.view;
    [self.delegate pushOriginalImageController:imgView.pic_url];
}
#pragma -mark- 获得大图的url
-(NSString *)getOriginal_pic_URL:(NSString *)pic_url
{
    return [pic_url stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
}
-(void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    [self settingImgViews];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
}
#pragma -mark- 设置控件内容
-(void)settingImgViews
{
    for (int i = 0; i < 9; i++) {
        ImgView *imgView = [self.subviews objectAtIndex:i];
        if (i  < self.pic_urls.count) {
            //不隐藏
            imgView.hidden = NO;
            //保持高宽比
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            imgView.image = [UIImage imageNamed:@"timeline_image_loading.png"];
            imgView.pic_url = [[self.pic_urls objectAtIndex:i] objectForKey:@"thumbnail_pic"];
        }
        else
        {
            //其余隐藏
            imgView.hidden = YES;
        }
    }

}

#pragma -mark- 子控件布局
-(void)layoutSubviews
{

    if (self.subviews.count == 0) {
        return;
    }
    //listView的宽度
    CGFloat width = 0;
    CGFloat height = 0;
    
    NSInteger count = self.pic_urls.count;
    //只有一张配图
    if (count == 1) {
        ImgView *imgView = [self.subviews firstObject];
        imgView.frame = CGRectMake(0, 0, 100, 80);
        self.backgroundColor = [UIColor clearColor];
        width = 100;
        height = 80;
    }
    else if(count > 1)
    {
        //多张配图
        //imgView所在行数
        NSInteger row = 0;
        //列数
        NSInteger col = 0;
        
        //4张图为两行两列 特殊处理 每行图片最大个数为
        NSInteger rowCount = count == 4?2:3;
        
        //设置各个配图的frame
        for (int i = 0; i < self.pic_urls.count; i++) {
            ImgView *imgView = [self.subviews objectAtIndex:i];
            //图片填充
            imgView.contentMode = UIViewContentModeScaleAspectFill;
            //裁剪边缘
            imgView.clipsToBounds = YES;
            
            row = i / rowCount;
            col = i % rowCount;
            
            imgView.frame = CGRectMake(col * (IMGVIEW_WIDTH + IMGVIEW_SPACE) + IMGVIEW_SPACE, row * (IMGVIEW_WIDTH + IMGVIEW_SPACE) + IMGVIEW_SPACE, IMGVIEW_WIDTH, IMGVIEW_WIDTH);
        }
        width = 3*(IMGVIEW_WIDTH + IMGVIEW_SPACE) + IMGVIEW_SPACE;
        height = (row+1) * (IMGVIEW_WIDTH + IMGVIEW_SPACE) + IMGVIEW_SPACE;
        //只有一行 宽度为(col + 1) * (IMGVIEW_WIDTH + IMGVIEW_SPACE) + IMGVIEW_SPACE
        if (row == 0) {
            width = (col + 1) * (IMGVIEW_WIDTH + IMGVIEW_SPACE) + IMGVIEW_SPACE;
        }
    }
    
    //设置listImgview的大小
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), width, height);
}
@end
