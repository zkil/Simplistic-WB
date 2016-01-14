//
//  MyStatusViewController.m
//  Simplistic WB
//
//  Created by wzk on 15/12/10.
//  Copyright (c) 2015年 Ibokan1. All rights reserved.
//

#import "MyStatusViewController.h"
#import "Status.h"
#import "StatusTool.h"
#import "MJRefresh.h"
@interface MyStatusViewController ()

@end

@implementation MyStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)loadNewStatus
{
    //取出本地最新微博
    Status *firstStatus = [self.tableData firstObject];
    //请求数据（比本地更新的数据）
    [StatusTool statusToolGetUserWithUid:self.userUid sinceID:firstStatus.ID maxID:0 success:^(id JSON) {
        //解析
        NSArray *newStutus = [Status mj_objectArrayWithKeyValuesArray:[JSON objectForKey:@"statuses"]];
        //插入到列表数据
        [self.tableData insertObjects:newStutus atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newStutus.count)]];
        //        [header setTitle:[NSString stringWithFormat:@"%ld条新微博",newStutus.count] forState:MJRefreshStateRefreshing];
        //重载列表
        [self.tableView reloadData];
        
        
        
        //停止刷新控件动画
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"loadNewStatus%@",error);
    }];

}
-(void)loadMoreStatus
{
    //取出最后一条微博
    Status *lastStatus = [self.tableData lastObject];
    //请求比最后一条微博晚的一组微博
    [StatusTool statusToolGetUserWithUid:self.userUid sinceID:0 maxID:lastStatus.ID - 1 success:^(id JSON) {
        //解析
        NSArray *newStutus = [Status mj_objectArrayWithKeyValuesArray:[JSON objectForKey:@"statuses"]];
        //加入到列表数组
        [self.tableData addObjectsFromArray:newStutus];
        //重载视图
        [self.tableView reloadData];
        //停止刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"loadMoreStatus%@",error);
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
