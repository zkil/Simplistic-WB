//
//  NewsCommentScreen.m
//  Simplistic WB
//
//  Created by Ibokan1 on 12/1/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "NewsScreen.h"
#import "CommentTool.h"
#import "CommentModel.h"
#import "HttpTool.h"
#import "NewScreenCell.h"
#import "NewsCommentScreen.h"
#import "MBProgressHUD.h"
#import "ReplyNews.h"
#import "PopViewcController.h"
#import "MJRefresh.h"
#import "InformationViewController.h"
#import "StatusDetailsController.h"
#import "StatusTool.h"
#import "MJExtension.h"
#import "Status.h"
#import "EnptyViewController.h"
//重用机制注册
static NSString* name = @"name ";
@interface NewsCommentScreen ()<UITableViewDataSource,UITableViewDelegate,skip,send>
{

    NSMutableArray *loadData;//网络请求加载的数据
    
    NewScreenCell* data;  //传过来的数据
    
    UITableView *ta; //显示的列表
    
    NSInteger num ;
}
@end

@implementation NewsCommentScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ta = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
    [self.view addSubview:ta];
    
    ta.delegate = self;
    
    ta.dataSource =self;
    
    ta.showsVerticalScrollIndicator = NO;
    
    //引入第三方类库MBProgressHUD
    MBProgressHUD *progressid = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //设置提示文本
    progressid.labelText = @"努力加载中";
    
    //设置字体大小
    progressid.labelFont = [UIFont systemFontOfSize:20];
    
    //还没获取到数据前不显示
    ta.hidden = YES;
    
    [self loadURL];
    
    [self UpdataUI];
    
    
}

#pragma -mark- 第三方类库刷新
-(void)UpdataUI
{
    NSMutableArray *arr=[NSMutableArray new];
    
    for (int i = 1; i < 18; i++) {
        if (i <= 9) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading-0%d@2x.png",i]];
            [arr addObject:image];
        }
        else
        {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading-%d@2x.png",i]];
            [arr addObject:image];
        }
    }
    
    //下拉刷新
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置普通状态的动画图片
    [header setImages:arr forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:arr forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [header setImages:arr forState:MJRefreshStateRefreshing];
    
    // 设置header
    ta.mj_header = header;
    
}
#pragma -mark- 发起网络请求获取数据
-(void)loadURL
{
    //发起网络请求获取数据
    [CommentTool CommentToolGetTimelineWithSinceID:0 MaxID:0 Success:^(id json)
     {
         

         loadData = [NSMutableArray
                     arrayWithArray:[json objectForKey:@"comments"]];
         
         num = loadData.count;
         
         [ta reloadData];
         
         //隐藏加载匡
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         
         //显示tableview
         ta.hidden = NO;
         
         [ta.mj_header endRefreshing];
         
     } failurs:^(NSError *error)
     {
         
         //隐藏加载匡
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         
         NSLog(@"%@",error);
         
     }];

}
#pragma -mark- 下拉刷新方法
-(void)loadNewData
{
 
    //加载数据
    [self loadURL];

    
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
    
    if (loadData)
    {
        //计算文本高度 返回cell的高度
        UILabel *st = self.snc.replyText;
        
        CGSize sizeWord = [st sizeThatFits:CGSizeMake(st.frame.size.width, MAXFLOAT)];
        
        UILabel *st1 = self.snc.reply_text;
        
        CGSize sizeWord1 = [st1 sizeThatFits:CGSizeMake(st1.frame.size.width, MAXFLOAT)];

        
        return  136+sizeWord.height+sizeWord1.height;
    }
    
    return  160;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return num;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.snc =[tableView dequeueReusableCellWithIdentifier:name ];
    
    if (!self.snc)
    {
        
        self.snc = [[NewScreenCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:name];
        
        self.snc.delegate = self;
    }
    
    //网络请求获取成功
    if (loadData)
    {
        
        [self.snc awakeWithIndex:indexPath.section WithDic:loadData];
        
    }
    return self.snc;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //获取点击的cell的内容
    NewScreenCell *ce = (NewScreenCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    PopViewcController *pp =[PopViewcController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    pp.cell = ce;
    
    pp.delegate = self;
    
    [self presentViewController:pp animated:YES completion:nil];
}

#pragma -mark- 代理回复跳转方法
-(void)skipController:(id)datacell
{

    //接收传过来的值
    data = datacell;
    
    //设置返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self.navigationItem setBackBarButtonItem:backItem];
    
    ReplyNews *sn = [ReplyNews new];
    
    sn.replyname = data.replyName.text;
    
    sn.delegate = self;
    
    [self.navigationController pushViewController:sn animated:YES];
    
};

#pragma -mark- 点击文字跳转方法
-(void)labelController:(NSString*)name{
    
    InformationViewController * im = [InformationViewController new];
    
    im.name = name;
    
    
    [self.navigationController pushViewController:im animated:YES];
}

#pragma -mark- 代理点击头像跳转方法
-(void)tapController:(id)datacell
{
    //接收传过来的值
    data = datacell;
    
    //加入跳转页面
    
    InformationViewController * im = [InformationViewController new];
    
    im.name = data.replyName.text;

    
    [self.navigationController pushViewController:im animated:YES];
    
};

#pragma -mark- 代理发送回复方法
-(void)sendActionWithText:(NSString*)text
{
    
    //前面是weibo 后面是评论。
    [CommentTool CommentToolPostReplyWithComment:text ID:data.wbID  Comment_ori:0 Cid:data.commentID Success:^(id json)
     {
         
         NSLog(@"回复成功");
         
     } failurs:^(NSError *error)
     {
         
         NSLog(@"%@",error);
         
     }];
    
}

#pragma -mark- 代理微博跳转方法
-(void)WbController:(id)json
{
    
    StatusDetailsController *detailsStatusVC = [StatusDetailsController new];
    
    Status *status = [Status mj_objectWithKeyValues:json];
    
    detailsStatusVC.status = status;
    
    [self.navigationController pushViewController:detailsStatusVC animated:YES];
    
    
}


#pragma -mark- 代理微博获取失败跳转方法
-(void)WbFailController:(NSError*)json
{
    
    EnptyViewController *EnptyVC = [EnptyViewController new];
    
    EnptyVC.error = json;
    
    [self.navigationController pushViewController:EnptyVC animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
