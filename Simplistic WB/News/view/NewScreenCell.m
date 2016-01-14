//
//  NewScreenCell.m
//  Simplistic WB
//
//  Created by Ibokan1 on 11/27/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "NewScreenCell.h"
#import "HttpTool.h"
#import "MLEmojiLabel.h"
@implementation NewScreenCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    //NewsAtCell

    
    return [[[NSBundle mainBundle]loadNibNamed:@"NewsCoCell" owner:nil options:nil]objectAtIndex:0];
}

-(void)awakeWithIndex:(NSInteger)index
              WithDic:(id)json
{
    
    self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    //给控件赋值
    
    NSArray *arr = json;
    
    if (arr.count>0)
    {
       
     NSDictionary *dic = [arr objectAtIndex:index];
    
     //评论页面模型
     CommentModel *scm = [[CommentModel alloc]initWithDic:dic];
    
        [HttpTool HttpToolDowmloadImageWithURL:scm.user.user_img success:^(id JSON)
         {
             if (JSON)
             {
                 
                 //评论者头像
                 UIImage *new = [UIImage circleImage:JSON withParam:1.0f];
                 
                 self.replyUserImg.image = new;
                 
                 self.replyUserImg.userInteractionEnabled = YES;
                 
                 [HttpTool HttpToolDowmloadImageWithURL:scm.status.status_img success:^(id JSON)
                  {
                      
                      //微博的图片
                      self.status_Img.image = JSON;
                      
                  } failure:^(NSError *error)
                  {

                      self.status_Img.image = JSON ;
                  }];
                 
             }
             
             
         } failure:^(NSError *error)
         {
             return ;
         }];
        
    //添加头像点击方法
    UITapGestureRecognizer *ta = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        
    [self.replyUserImg addGestureRecognizer:ta];
        
    //微博id 评论id
    self.wbID = scm.status.ID;
    
    self.commentID = scm.ID;
    
    //评论者友好昵称
    self.replyName.text = scm.user.user_Name;
    
    //评论时间和来源
    NSString *ss = [NSString stringWithFormat:@"%@ %@",[GetTypeByString getTimeWithString:scm.created_at],[GetTypeByString getSourceWithString:scm.source]];
    
    self.time.text = ss;
    
    //回复评论内容
    [self addML:_replyText WithString:scm.text];
    
    NSString *statusname = [NSString stringWithFormat:@"@%@",scm.status.status_user_name];
    
    //微博的发起者
    self.status_name.text = statusname;
    
    //微博的内容
    self.status_text.text = scm.status.status_Text;
    
    //有评论来自评论内容
    if (scm.reply_comment.reply_text)
    {
        
        
        NSString *replyWithName = [NSString stringWithFormat:@"@%@:%@",scm.reply_comment.reply_Name,scm.reply_comment.reply_text];
        
        [self addML:_reply_text WithString:replyWithName];
        
        
    }
    }
}

//头像点击方法
-(void)tapAction
{
    
    [self.delegate tapController:self];
}

//回复评论
- (IBAction)ReplyAction:(UIButton *)sender
{

    [self.delegate skipController:self];
    
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
            [self.delegate labelController:[link substringFromIndex:1]];
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
