//
//  Informationview.h
//  Simplistic WB
//
//  Created by LXF on 15/11/30.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"


@interface Informationview : UIView
@property (weak, nonatomic) IBOutlet UIImageView *profile_image;
@property (weak, nonatomic) IBOutlet UILabel *screen_name;
@property (weak, nonatomic) IBOutlet UIImageView *gender_view;

@property (weak, nonatomic) IBOutlet UIImageView *mbtype_image;

@property (weak, nonatomic) IBOutlet UILabel *followers_count;
@property (weak, nonatomic) IBOutlet UILabel *friends_count;
@property (weak, nonatomic) IBOutlet UILabel *descriptiontext;

-(instancetype)initWithInformationview;
-(void)setContent:(User*)user;

@end
