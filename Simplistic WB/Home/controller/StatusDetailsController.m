//
//  StatusDetailsController.m
//  Simplistic WB
//
//  Created by wzk on 15/12/5.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import "StatusDetailsController.h"
#import "StatusTabMenu.h"
#import "Status.h"
#import "StatusDetailsTableViewCell.h"
#import "User.h"
#import "OriginalImageController.h"
#import "StatusTool.h"
#import "MJRefresh.h"
#import "RepostViewController.h"
#import "CommentViewController.h"
#import "InformationViewController.h"
@interface StatusDetailsController ()
{
    
    
    //底部点击评论 转发 点赞菜单
    StatusTabMenu *_tabMenu;
    
    //切换列表按钮
    
    UIButton *_repostBtn;
    UIButton *_commentBtn;
    UIButton *_attitudeBtn;
    
    //转发，评论，点赞列表
    UITableView *_statusTable;
    //列表数据
    NSMutableArray *_tableData;
    //转发微博
    NSMutableArray *_repostStatues;
    //评论微博
    NSMutableArray *_commentStatues;
    //点赞用户
    NSMutableArray *_attitudeUsers;
    
    //用于计算cell高度
    StatusDetailsTableViewCell *_offscreenCell;
    
    //列表刷新活动指示器
    UIActivityIndicatorView *_activityIndicator;
}
@end

@implementation StatusDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.view.backgroundColor = [UIColor whiteColor];
    //设置不延伸
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"微博正文";

    //创建控件
    [self createSubViews];
    
    
    _repostStatues = [NSMutableArray new];
    _commentStatues = [NSMutableArray new];
    _attitudeUsers = [NSMutableArray new];
    
    //加载列表数据
    [self loadNewStatus];
    
}
#pragma -mark- 创建子控件
-(void)createSubViews
{
    
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cancelBtn setFrame:CGRectMake(0, 0, 35, 35)];
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"userinfo_navigationbar_back_highlighted@2x.png"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc]initWithCustomView:cancelBtn];
    self.navigationItem.leftBarButtonItem = cancelBtnItem;
    
    UIView *tableHeader = [[UIView alloc]init];
    
    //微博详情
    StatusBaseCellView *statusView = [[StatusBaseCellView alloc]init];
    statusView.status = self.status;
    statusView.delegate = self;
    //[_statusDetails addSubview:statusView];
    [tableHeader addSubview:statusView];
    
    //按钮位置
    CGFloat BtnY = CGRectGetMaxY(statusView.frame);
    CGFloat BtnWidth = 100;
    
    //转发按钮
    _repostBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _repostBtn.frame = CGRectMake(0, BtnY, BtnWidth, 30);
    [_repostBtn setImage:[UIImage imageNamed:@"icon_timeline_retweet@2x.png"] forState:UIControlStateNormal];
    _repostBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    _repostBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    _repostBtn.tintColor = [UIColor colorWithWhite:0.5 alpha:1];
    [_repostBtn addTarget:self action:@selector(repostAction:) forControlEvents:UIControlEventTouchUpInside];
    [_repostBtn setTitle:[NSString stringWithFormat:@"%ld",(long)self.status.reposts_count] forState:UIControlStateNormal];
    //[_statusDetails addSubview:_repostBtn];
    [tableHeader addSubview:_repostBtn];
    
    //分割图片
    UIImageView *lineImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line.png"]];
    lineImg.alpha = 0.4;
    lineImg.frame = CGRectMake(CGRectGetMaxX(_repostBtn.frame), BtnY, 1, CGRectGetHeight(_repostBtn.frame));
    //[_statusDetails addSubview:lineImg];
    [tableHeader addSubview:lineImg];
    
    //评论按钮
    _commentBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _commentBtn.frame = CGRectMake(BtnWidth, BtnY, BtnWidth, 30);
    [_commentBtn setImage:[UIImage imageNamed:@"icon_timeline_comment@2x.png"] forState:UIControlStateNormal];
    _commentBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    _commentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    _commentBtn.tintColor = [UIColor blackColor];
    [_commentBtn setTitle:[NSString stringWithFormat:@"%ld",(long)self.status.comments_count] forState:UIControlStateNormal];
    [_commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    //[_statusDetails addSubview:_commentBtn];
    [tableHeader addSubview:_commentBtn];
    
    //点赞按钮
    _attitudeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _attitudeBtn.frame = CGRectMake(self.view.frame.size.width - BtnWidth, BtnY, BtnWidth, 30);
    [_attitudeBtn setImage:[UIImage imageNamed:@"icon_timeline_like@2x.png"] forState:UIControlStateNormal];
    _attitudeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    _attitudeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    _attitudeBtn.tintColor = [UIColor colorWithWhite:0.5 alpha:1];
    [_attitudeBtn setTitle:[NSString stringWithFormat:@"%ld",(long)self.status.attitudes_count] forState:UIControlStateNormal];
    [_attitudeBtn addTarget:self action:@selector(attitudeAction:) forControlEvents:UIControlEventTouchUpInside];
    //[_statusDetails addSubview:_attitudeBtn];
    [tableHeader addSubview:_attitudeBtn];
    
    //默认列表为评论列表
    self.select = CommentsTable;
//    //默认选项 加深
//    switch (self.select) {
//        case RepostsTable:
//            _repostBtn.tintColor = [UIColor blackColor];
//            break;
//        case CommentsTable:
//            _commentBtn.tintColor = [UIColor blackColor];
//            break;
//        case AttitudeTable:
//            _attitudeBtn.tintColor = [UIColor blackColor];
//            break;
//        default:
//            break;
//    }

   // _statusDetails.frame = CGRectMake(0, 0, CGRectGetWidth(_statusTable.frame), CGRectGetMaxY(_repostBtn.frame));
    tableHeader.frame = CGRectMake(0, 0, CGRectGetWidth(_statusTable.frame), CGRectGetMaxY(_repostBtn.frame));
    
    //创建底部按钮
    _tabMenu = [[StatusTabMenu alloc]init];
    _tabMenu.status = nil;
    _tabMenu.delegate = self;
    _tabMenu.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - CGRectGetHeight(_tabMenu.frame) - CGRectGetMaxY(self.navigationController.navigationBar.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(_tabMenu.frame));
    [self.view addSubview:_tabMenu];
    
    //创建列表
    //高度 = 屏幕高度 - navigationbar高度 - 底部按钮高度
    
    _statusTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - CGRectGetMaxY(self.navigationController.navigationBar.frame) - CGRectGetHeight(_tabMenu.frame)) style:UITableViewStylePlain];
    _statusTable.contentSize = CGSizeMake(_statusTable.contentSize.width, _statusTable.contentSize.height + 100);
    _statusTable.tableHeaderView =  tableHeader;
    
    //设置重用的cell
    [_statusTable registerNib:[UINib nibWithNibName:@"StatusDetailsTableViewCell" bundle:nil] forCellReuseIdentifier:@"statusDtatails"];
    
    _statusTable.dataSource = self;
    _statusTable.delegate = self;
    
    [self.view addSubview:_statusTable];
    
    _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicator.hidesWhenStopped = YES;
    _activityIndicator.center = CGPointMake(_statusTable.frame.size.width/2, CGRectGetMaxY(_repostBtn.frame) + 20);
    [_statusTable addSubview:_activityIndicator];
    [_activityIndicator startAnimating];
    
    [self createRefresh];

}
#pragma -mark- 上拉刷新下拉加载更多
-(void)createRefresh
{
    //创建下拉刷新控件
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewStatus)];
    //添加刷新控件到列表
    _statusTable.mj_header = header;
    //[header beginRefreshing];
    
    //创建上拉加载更多控件
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStatus)];
    _statusTable.mj_footer = footer;
}
#pragma -mark- 下拉加载事件
-(void)loadNewStatus
{
    switch (self.select) {
        case RepostsTable:
            [self loadRepostStatues];
            break;
        case CommentsTable:
            [self loadCommentStatues];
            break;
        case AttitudeTable:
            [self loadAttitudeUsers];
            break;
        default:
            break;
    }
}
#pragma -mark- 上拉加载更多
-(void)loadMoreStatus
{
    switch (self.select) {
        case RepostsTable:
            [self loadMoreRepostStatues];
            break;
        case CommentsTable:
            [self loadMoreCommentStatues];
            break;
        case AttitudeTable:
            [self loadMoreAttitudeUsers];
            break;
        default:
            break;
    }
}

#pragma -mark- 加载转发列表
-(void)loadRepostStatues
{
    //第一条转发
    Status *firstRepost = [_repostStatues firstObject];
    [StatusTool statusToolGetRepostsWithID:self.status.ID sinceID:firstRepost.ID maxID:0 success:^(id JSON) {
        //解析
        NSArray *newReposts = [Status mj_objectArrayWithKeyValuesArray:[JSON objectForKey:@"reposts"]];
        [_repostStatues insertObjects:newReposts atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newReposts.count)]];
        //切换数据
        _tableData = _repostStatues;
        //重载列表
        [_statusTable reloadData];
        //停止刷新控件
        [_statusTable.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"loadRepostStatues %@",error);
    }];
}
#pragma -mark- 加载评论列表
-(void)loadCommentStatues
{
    //第一条评论
    Status *firstComment = [_commentStatues firstObject];
    [StatusTool statusToolGetCommentsWithID:self.status.ID sinceID:firstComment.ID maxID:0 success:^(id JSON) {
        //解析
        NSArray *newComments = [Status mj_objectArrayWithKeyValuesArray:[JSON objectForKey:@"comments"]];
        [_commentStatues insertObjects:newComments atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newComments.count)]];
        
        //切换数据
        _tableData = _commentStatues;

        //重载列表
        [_statusTable reloadData];
        //停止刷新控件
        [_statusTable.mj_header endRefreshing];
        [_activityIndicator stopAnimating];
        
    } failure:^(NSError *error) {
        NSLog(@"loadRepostStatues %@",error);
    }];
}

#pragma -mark- 加载点赞列表
-(void)loadAttitudeUsers
{
    //切换数据
    _tableData = _attitudeUsers;
    //重载列表
    [_statusTable reloadData];
    //停止刷新控件
    [_statusTable.mj_header endRefreshing];
}
#pragma -mark- 加载更多转发
-(void)loadMoreRepostStatues
{
    //最后一条转发
    Status *lastRepost = [_repostStatues lastObject];
    [StatusTool statusToolGetRepostsWithID:self.status.ID sinceID:0 maxID:lastRepost.ID - 1 success:^(id JSON) {
        //解析
        NSArray *newReposts = [Status mj_objectArrayWithKeyValuesArray:[JSON objectForKey:@"reposts"]];
        [_repostStatues addObjectsFromArray:newReposts];
        //切换数据
        _tableData = _repostStatues;
        //重载列表
        [_statusTable reloadData];
        //停止刷新控件
        [_statusTable.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"loadMoreRepost%@",error);
    }];
}
#pragma -mark- 加载更多评论
-(void)loadMoreCommentStatues
{
    //最后一条转发
    Status *lastComment = [_commentStatues lastObject];
    [StatusTool statusToolGetCommentsWithID:self.status.ID sinceID:0 maxID:lastComment.ID - 1 success:^(id JSON) {
        //解析
        NSArray *newComments = [Status mj_objectArrayWithKeyValuesArray:[JSON objectForKey:@"comments"]];
        [_commentStatues addObjectsFromArray:newComments];
        //切换数据
        _tableData = _commentStatues;
        //重载列表
        [_statusTable reloadData];
        //停止刷新控件
        [_statusTable.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"loadMoreComments%@",error);
    }];

}
#pragma -mark- 加载更多点赞
-(void)loadMoreAttitudeUsers
{
    ///切换数据
    _tableData = _attitudeUsers;
    //重载列表
    [_statusTable reloadData];
    //停止刷新控件
    [_statusTable.mj_footer endRefreshing];

}
//转发列表
-(void)repostAction:(UIButton *)btn
{
    //控件切换
    _repostBtn.tintColor = [UIColor blackColor];
    _commentBtn.tintColor = [UIColor colorWithWhite:0.5 alpha:1];
    _attitudeBtn.tintColor = [UIColor colorWithWhite:0.5 alpha:1];
    
    //切换列表数据
    self.select = RepostsTable;

    _tableData = _repostStatues;
    //重载列表
    [_statusTable reloadData];
    
    
}
//评论列表
-(void)commentAction:(UIButton *)btn
{
    //控件切换
    _commentBtn.tintColor = [UIColor blackColor];
    _repostBtn.tintColor = [UIColor colorWithWhite:0.5 alpha:1];
    _attitudeBtn.tintColor = [UIColor colorWithWhite:0.5 alpha:1];
    
    
    //切换列表数据
    self.select = CommentsTable;
    
    _tableData = _commentStatues;
    //重载列表
    [_statusTable reloadData];
    
}
//点赞列表
-(void)attitudeAction:(UIButton *)btn
{
    //控件切换
    _attitudeBtn.tintColor = [UIColor blackColor];
    _commentBtn.tintColor = [UIColor colorWithWhite:0.5 alpha:1];
    _repostBtn.tintColor = [UIColor colorWithWhite:0.5 alpha:1];
 
    
    //切换列表数据
    self.select = AttitudeTable;
    
    _tableData = _attitudeUsers;
    //重载列表
    [_statusTable reloadData];
    
}


#pragma -mark- tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusDtatails"];
    cell.delegate = self;
    Status *status = [_tableData objectAtIndex:indexPath.row];
    //默认头像
    cell.avata.image = [UIImage imageNamed:@"avatar_default_small@2x.png"];
    //请求加载头像
    [HttpTool HttpToolDowmloadImageWithURL:status.user.avatar_hd success:^(id JSON) {
        cell.avata.image = JSON;
    } failure:^(NSError *error) {
        NSLog(@"load avata %@",error);
    }];
    cell.status = status;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_offscreenCell) {
        _offscreenCell =
        [[[NSBundle mainBundle]loadNibNamed:@"StatusDetailsTableViewCell" owner:nil options:nil]lastObject];
    }
    Status *status = [_tableData objectAtIndex:indexPath.row];
    //获取cell的高度
    _offscreenCell.statusText.text = status.text;
    //_offscreenCell.statusText.preferredMaxLayoutWidth = self.view.frame.size.width - 20;
    _offscreenCell.statusText.font = [UIFont systemFontOfSize:15];
    CGSize size = [_offscreenCell.statusText sizeThatFits:CGSizeMake(self.view.frame.size.width, MAXFLOAT)];
    
//    [_offscreenCell setNeedsUpdateConstraints];
//    [_offscreenCell updateConstraintsIfNeeded];
    
    CGFloat height = CGRectGetMaxY(_offscreenCell.avata.frame) + size.height + 16;
    return height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Status *status = [_tableData objectAtIndex:indexPath.row];
    [self pushStatusDetailsWith:status];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
#pragma -mark- StatusTableViewCellDeleget
//weibo详情页面
-(void)pushStatusDetailsWith:(Status *)status
{
    StatusDetailsController *statusController = [[StatusDetailsController alloc]init];
    statusController.status = status;
    [self.navigationController pushViewController:statusController animated:YES];
}
//用户资料页面
-(void)pushUserViewControllerWithUser:(User *)user
{
    InformationViewController *informatVC = [InformationViewController new];
    informatVC.ClickUserID = user.ID;
    [self.navigationController pushViewController:informatVC animated:YES];
}
//转发页面
-(void)pushRepostViewControllerWithStatus:(Status *)status atStatusTabMenu:(StatusTabMenu *)tabMenu
{
    RepostViewController *repostVC = [[RepostViewController alloc]init];
    repostVC.hidesBottomBarWhenPushed = YES;
    repostVC.status = self.status;
    [self.navigationController pushViewController:repostVC animated:YES];

}
//评论页面
-(void)pushCommentViewControllerWithStatus:(Status *)status atStatusTabMenu:(StatusTabMenu *)tabMenu
{
    CommentViewController *commentVc = [[CommentViewController alloc]init];
    commentVc.hidesBottomBarWhenPushed = YES;
    commentVc.status = self.status;
    [self.navigationController pushViewController:commentVc animated:YES];
}
//点赞
-(void)attitudeWithStatus:(Status *)status atStatusTabMenu:(StatusTabMenu *)tabMenu
{
    NSLog(@"%ld",(long)tabMenu.attitudesCount);
}
-(void)attitudeWithStatus:(Status *)status atButton:(UIButton *)btn
{
    NSLog(@"%@",btn.titleLabel.text);
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
-(void)cancelAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
