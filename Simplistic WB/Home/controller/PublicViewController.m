//
//  PublicViewController.m
//  Simplistic WB
//
//  Created by wzk on 15/12/11.
//  Copyright (c) 2015年 Ibokan1. All rights reserved.
//

#import "PublicViewController.h"
#import "Status.h"
#import "User.h"
#import "StatusTool.h"
#import "MJRefresh.h"
@interface PublicViewController ()
{
    NSInteger page;//页数
}
@end

@implementation PublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置不延伸
    self.title = nil;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
}
-(void)loadNewStatus
{
    
    [StatusTool statusToolGetPublicWithPage:0 success:^(id JSON) {
        //解析
        NSArray *newStutus = [Status mj_objectArrayWithKeyValuesArray:[JSON objectForKey:@"statuses"]];
        //插入到列表数据
        [self.tableData insertObjects:newStutus atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newStutus.count)]];
        //        [header setTitle:[NSString stringWithFormat:@"%ld条新微博",newStutus.count] forState:MJRefreshStateRefreshing];
        //重载列表
        [self.tableView reloadData];

        
        //停止刷新控件动画
        [self.tableView.mj_header endRefreshing];
        
        page = 0;
    } failure:^(NSError *error) {
        NSLog(@"load public%@",error);
    }];
}
-(void)loadMoreStatus
{
    [StatusTool statusToolGetPublicWithPage:page++ success:^(id JSON) {
        //解析
        NSArray *newStutus = [Status mj_objectArrayWithKeyValuesArray:[JSON objectForKey:@"statuses"]];
        //加入到列表数组
        [self.tableData addObjectsFromArray:newStutus];
        //重载视图
        [self.tableView reloadData];
        //停止刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"load more public%@",error);
    }];
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
