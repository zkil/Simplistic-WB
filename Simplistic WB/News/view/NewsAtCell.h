//
//  NewsAtCell.h
//  Simplistic WB
//
//  Created by Ibokan1 on 12/1/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "CommentTool.h"
#import "GetTypeByString.h"
#import "UIImage+cirel.h"
#import "MLEmojiLabel.h"
@protocol skip <NSObject>

@optional

//评论跳转方法
-(void)skipController:(id)datacell;

//点击头像跳转方法
-(void)tapController:(id)datacell;

//点击文字跳转方法
-(void)labelController:(NSString*)name;

//微博获取成功跳转方法
-(void)WbController:(id)json;

//微博获取失败跳转方法
-(void)WbFailController:(NSError*)json;

@end

@interface NewsAtCell : UITableViewCell<MLEmojiLabelDelegate>

//微博ID
@property(nonatomic) long long wbID;

//评论id
@property(nonatomic) long long commentID;

//回复人的头像
@property (weak, nonatomic) IBOutlet UIImageView  *replyUserImg;

//回复人的姓名
@property (weak, nonatomic) IBOutlet UILabel *replyName;

//回复时间
@property (weak, nonatomic) IBOutlet UILabel *time;

//回复文本
@property (weak, nonatomic) IBOutlet MLEmojiLabel *replyText;

//微博的图片
@property (weak, nonatomic) IBOutlet UIImageView *status_Img;

//微博的发起者
@property (weak, nonatomic) IBOutlet UILabel *status_name;

//微博的内容
@property (weak, nonatomic) IBOutlet UILabel *status_text;

//代理
@property (nonatomic,assign)id<skip>delegate;

//加载数据
-(void)awakeWithIndex:(NSInteger)index
              WithDic:(id)json;

@end
