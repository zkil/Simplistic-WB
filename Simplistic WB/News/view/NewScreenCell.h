//
//  NewScreenCell.h
//  Simplistic WB
//
//  Created by Ibokan1 on 11/27/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "CommentTool.h"
#import "GetTypeByString.h"
#import "UIImage+cirel.h"
#import "NewsAtCell.h"
#import "MLEmojiLabel.h"
@interface NewScreenCell : UITableViewCell<MLEmojiLabelDelegate>


//微博ID
@property(nonatomic) long long wbID;

//评论id
@property(nonatomic) long long commentID;

//回复人的头像
@property (weak, nonatomic) IBOutlet UIImageView *replyUserImg;

//回复人的姓名
@property (weak, nonatomic) IBOutlet UILabel *replyName;

//回复时间
@property (weak, nonatomic) IBOutlet UILabel *time;

//回复文本
@property (strong, nonatomic) IBOutlet MLEmojiLabel *replyText;

//微博的图片
@property (weak, nonatomic) IBOutlet UIImageView *status_Img;

//微博的发起者
@property (weak, nonatomic) IBOutlet UILabel *status_name;

//微博的内容
@property (weak, nonatomic) IBOutlet UILabel *status_text;

//评论来自评论内容
@property (strong, nonatomic) IBOutlet MLEmojiLabel *reply_text;

//代理
@property (nonatomic,assign)id<skip>delegate;

//加载数据
-(void)awakeWithIndex:(NSInteger)index
              WithDic:(id)json;
@end
