//
//  NewsScreen.m
//  Simplistic WB
//
//  Created by Ibokan1 on 11/26/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "NewsScreen.h"
#import "UIImage+cirel.h"
#import "News.h"
#import "NewsCommentScreen.h"
#import "NewsAScreen.h"
#import "RemindModel.h"
#import "RemindTool.h"
#import "RemindModel.h"
#import "UILabel+Edge.h"
#import "UserFanstListViewController.h"
#import "Contacts.h"
#import "SendNews.h"
#import "SaveCountTool.h"
#import "SendNews.h"
@interface NewsScreen ()<UITableViewDataSource,UITableViewDelegate>
{

    NSArray *imgarr;
    
    NSArray *textarr;
    
    UITableView *ta;
    
    RemindModel *rm ;//未读取消息模型
    
    NSArray *NameArr ; //从本地获取存储名字和头像的已经聊天过的数组
}
@end

@implementation NewsScreen

#pragma -mark- 视图将出现的时候
-(void)viewWillAppear:(BOOL)animated
{
    //获取未读消息
    [RemindTool RemindToolGetUnreadCountWithUid:2831707964 Success:^(id json) {
        
       rm = [[RemindModel alloc]initWithDic:json];
        
        [ta reloadData];
        
    } failurs:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    SaveCountTool *st = [[SaveCountTool alloc]init];
    
    if (st.username!=nil)
    {
        
    //判断本地是否有此数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //取出
    NSArray *arr1 =[defaults arrayForKey:st.username];
    
        NSLog(@"%@",arr1);
        
    if (arr1.count>0)
    {
        //赋值
        NameArr = [NSArray arrayWithArray:arr1];
        
        [ta reloadData];
    }
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"消息";
    
    imgarr = @[@"messagescenter_at@2x",@"messagescenter_comments@2x",@"messagescenter_good@2x",@"messagescenter_subscription@2x"];
    
    textarr = @[@"@我的",@"评论",@"赞",@"订阅消息"];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    ta = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
    [self.view addSubview:ta];
    
    ta.delegate = self;
    
    ta.dataSource =self;
    
    ta.scrollsToTop = NO;
    
    UIBarButtonItem  *left = [[UIBarButtonItem alloc]initWithTitle:@"发私信" style:UIBarButtonItemStyleDone target:self action:@selector(sendNewsAction)];
    
    self.navigationItem.rightBarButtonItem = left;
    
    
}
#pragma -mark- 发私信方法
-(void)sendNewsAction
{

    Contacts *uc = [[Contacts alloc]init];
    
    uc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:uc animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
   
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return  50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return 4 + [NameArr[0] count] ;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* name = @"name";
    
    News* cell =[tableView dequeueReusableCellWithIdentifier:name ];
    
    
    if (!cell)
    {
        cell = [[News alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:name];
        
        
        if (indexPath.row<4)
        {
            
            
            UIImage *old  = [UIImage imageNamed:imgarr[indexPath.row]];
            
            cell.img.image = old;
            
            cell.text.text = textarr[indexPath.row];
        }
        
    }

    
    //模型有数据的时候
    //未读消息清零需要高级接口
    if (rm)
    {
        //@我的
        if (indexPath.row==0)
        {
            //获取@到我的评论和微博
            int all = rm._mention_cmt+rm._mention_status;
            
            //未读数大于0
            if (all>0) {
                
                [cell.text showPointAtindex:all];
                
            }
            else
            {
            
                [cell.text hidePoint];
            }
            
        }
        
        //评论的
        if (indexPath.row==1)
        {
            //未读数大于0
            if (rm._cmt>0) {
                
                [cell.text showPointAtindex:rm._cmt];
                
            }
            else
            {
                
                [cell.text hidePoint];
            }
            
        }
    }
    
    if (indexPath.row>=4)
    {
        
        cell.text.text = [NameArr[0] objectAtIndex:indexPath.row-4];
        
        cell.img.image = [UIImage imageWithData:[NameArr[1] objectAtIndex:indexPath.row-4]];
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{

    switch (indexPath.row)
    {
        case 0:
        {
            NewsAScreen *sas = [[NewsAScreen alloc]init];
            
            //设置返回按钮
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"消息" style:UIBarButtonItemStylePlain target:nil action:nil];
            
            [self.navigationItem setBackBarButtonItem:backItem];
            
            sas.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:sas animated:YES];
            
            break;
        }
        case 1:
        {
            
            NewsCommentScreen *scs = [[NewsCommentScreen alloc]init];
            
            //设置返回按钮
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"消息" style:UIBarButtonItemStylePlain target:nil action:nil];
            
            [self.navigationItem setBackBarButtonItem:backItem];
            
            scs.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:scs animated:YES];
            
            break;
        }
        case 2:
        {            
            break;
        }
        default:
            break;
    }
    
    //跳转到发送消息界面
    if (indexPath.row>=4)
    {
        
        SendNews *send = [SendNews new];
        
        send.hidesBottomBarWhenPushed = YES; 
        
        News* cell =(News*)[tableView cellForRowAtIndexPath:indexPath ];
        
        send.name = cell.text.text;
        
        send.img = cell.img.image;
        
        [self.navigationController pushViewController:send animated:YES];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
