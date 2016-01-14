//
//  ImageView.m
//  Simplistic WB
//
//  Created by wzk on 15/12/3.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import "ImgView.h"
#import "HttpTool.h"

@implementation ImgView

-(void)setPic_url:(NSString *)pic_url
{
    _pic_url = pic_url;
    //异步下载图片
    [HttpTool HttpToolDowmloadImageWithURL:_pic_url success:^(id object) {
        self.image = object;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
