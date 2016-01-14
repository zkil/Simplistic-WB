//
//  HomeController.m
//  Simplistic WB
//
//  Created by wzk on 15/11/27.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import "HomeController.h"
#import "RepostViewController.h"
#import "HomeStatusCell.h"
#import "StatusTool.h"
#import "Status.h"
#import "User.h"
#import "ImgView.h"
#import "OriginalImageController.h"
#import "SaveCountTool.h"
#import "MJRefresh.h"
#import "StatusDetailsController.h"
#import "CommentViewController.h"
#import "InformationViewController.h"
#import "Usertool.h"
#import "MJExtension.h"
@interface HomeController ()
{
    
    //用于计算cell高度
    HomeStatusCell *_offscreenCell;
    //表数据
    NSMutableArray *_tableData;
    

}
@end

@implementation HomeController
@synthesize tableData = _tableData;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置不延伸
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _tableData = [NSMutableArray new];
    //创建刷新事件
    [self createRefresh];
    //第一次进入页面进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    [Usertool UserToolGetUserinfoWithUserID:[[SaveCountTool new].saveCount.uid_value longLongValue] orName:nil Success:^(NSDictionary *dic) {
        User *user = [User mj_objectWithKeyValues:dic];
        self.title = user.screen_name;
    } failurs:^(NSError *error) {
        
    }];
}

#pragma -mark- 上拉刷新下拉加载更多
-(void)createRefresh
{
    //创建下拉刷新控件
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewStatus)];
    //添加刷新控件到列表
    self.tableView.mj_header = header;
    
    //创建上拉加载更多控件
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStatus)];
    self.tableView.mj_footer = footer;
}
#pragma -mark- 下拉加载事件
-(void)loadNewStatus
{
    //取出本地最新微博
    Status *firstStatus = [_tableData firstObject];
    //请求数据（比本地更新的数据）
    [StatusTool statusToolGetHomeWithSinceID:firstStatus.ID maxID:0 success:^(id JSON) {
        //解析
        NSArray *newStutus = [Status mj_objectArrayWithKeyValuesArray:[JSON objectForKey:@"statuses"]];
        //插入到列表数据
        [_tableData insertObjects:newStutus atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newStutus.count)]];
//        [header setTitle:[NSString stringWithFormat:@"%ld条新微博",newStutus.count] forState:MJRefreshStateRefreshing];
        //重载列表
        [self.tableView reloadData];
        
        
        
        //停止刷新控件动画
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"loadNewStatus%@",error);
    }];
}
#pragma -mark- 上拉加载更多
-(void)loadMoreStatus
{
    //取出最后一条微博
    Status *lastStatus = [_tableData lastObject];
    //请求比最后一条微博晚的一组微博
    [StatusTool statusToolGetHomeWithSinceID:0 maxID:lastStatus.ID - 1 success:^(id JSON) {
        //解析
        NSArray *newStutus = [Status mj_objectArrayWithKeyValuesArray:[JSON objectForKey:@"statuses"]];
        //加入到列表数组
        [_tableData addObjectsFromArray:newStutus];
        //重载视图
        [self.tableView reloadData];
        //停止刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"loadMoreStatus%@",error);
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indentifier = @"statusCell";
    HomeStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[HomeStatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        cell.statusCellView.delegate = self;
    }
    Status *status = [_tableData objectAtIndex:indexPath.row];
    [cell setStatus:status];
    return cell;
}

/*
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
////    BOOL nibsRegistered = NO;
////    if (!nibsRegistered) {
////        UINib *nib = [UINib nibWithNibName:NSStringFromClass([Cell class]) bundle:nil];
////        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
////        nibsRegistered = YES;
////    }
////    Cell *cell = (Cell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    StatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StatusCell"];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    [cell setNeedsUpdateConstraints];
//    [cell updateConstraintsIfNeeded];
//    
//    
//    
//    [cell setNeedsLayout];
//    [cell layoutIfNeeded];
//    //[cell layoutIfNeeded];
//    return cell;
//}
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //使用懒加载创建一个全局cell来计算行高，避免占用内存
    if (!_offscreenCell) {
        _offscreenCell = [[HomeStatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"offscreenCell"];
    }
    Status *status = [_tableData objectAtIndex:indexPath.row];
    [_offscreenCell.statusCellView setStatus:status];
    //获取cell的高度
    CGFloat hight = [_offscreenCell.statusCellView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return hight+1;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //定义一个估算行高，这样table在加载时不会先计算所有行的行，再载入数据
    //而是先计算屏幕上显示的行高
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Status *status = [_tableData objectAtIndex:indexPath.row];
    [self pushStatusDetailsWith:status];
}

#pragma -mark- HomeStatusCell代理方法
//weibo详情页面
-(void)pushStatusDetailsWith:(Status *)status
{
    StatusDetailsController *statusController = [[StatusDetailsController alloc]init];
    statusController.status = status;
    statusController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:statusController animated:YES];
  
}
//用户资料页面
-(void)pushUserViewControllerWithUser:(User *)user
{
    InformationViewController *informatVC = [InformationViewController new];
    informatVC.ClickUserID = user.ID;
    informatVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:informatVC animated:YES];
}
//转发页面
-(void)pushRepostViewControllerWithStatus:(Status *)status atStatusTabMenu:(StatusTabMenu *)tabMenu
{
    RepostViewController *repostVC = [[RepostViewController alloc]init];
    repostVC.hidesBottomBarWhenPushed = YES;
    repostVC.status = status;
    [self.navigationController pushViewController:repostVC animated:YES];
    
    
}
//评论页面
-(void)pushCommentViewControllerWithStatus:(Status *)status atStatusTabMenu:(StatusTabMenu *)tabMenu
{
    CommentViewController *commentVC = [[CommentViewController alloc]init];
    commentVC.status = status;
    commentVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:commentVC animated:YES];
}
//点赞
-(void)attitudeWithStatus:(Status *)status atStatusTabMenu:(StatusTabMenu *)tabMenu
{
    
}
//显示大图
-(void)pushOriginalImageController:(NSString *)pic_url
{
    OriginalImageController *orignalC = [[OriginalImageController alloc]init];
    orignalC.pic_url = pic_url;
    //模态弹出动画为淡入淡出
    orignalC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:orignalC animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
