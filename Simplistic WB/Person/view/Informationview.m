//
//  Informationview.m
//  Simplistic WB
//
//  Created by LXF on 15/11/30.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import "Informationview.h"
#import "HttpTool.h"
#import "UIImage+Circle.h"

@implementation Informationview

-(instancetype)initWithInformationview
{
    return [[[NSBundle mainBundle]loadNibNamed:@"Informationview" owner:nil options:nil]lastObject];
}

-(void)setContent:(User*)user
{
    self.screen_name.text = user.screen_name;
    //判断男女 设置图标
    if ([user.gender isEqualToString:@"m"]) {
        self.gender_view.image = [UIImage imageNamed:@"list_male@2x.png"];
    }
    else
    {
        self.gender_view.image = [UIImage imageNamed:@"list_female@2x.png"];
    }
    //判断会员 设置图标 和名字颜色
    if (user.mbtype == 0) {
        
        self.mbtype_image.image = [UIImage imageNamed:@"common_icon_membership_expired@2x.png"];
    }
    else
    {
        self.screen_name.textColor = [UIColor orangeColor];
        self.mbtype_image.image = [UIImage imageNamed:@"common_icon_membership@2x.png"];
    }
    
    self.descriptiontext.text = [NSString stringWithFormat:@"简介：%@",user.describe];
    
    self.friends_count.text = [NSString stringWithFormat:@"关注  %ld",(long)user.friends_count];
    self.followers_count.text = [NSString stringWithFormat:@"粉丝  %ld",(long)user.followers_count];
    [HttpTool HttpToolDowmloadImageWithURL:user.avatar_hd success:^(id JSON)
    {
        self.profile_image.image = [UIImage circleImage:JSON withParam:10];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


@end
