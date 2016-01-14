//
//  UserSeachViewController.m
//  Simplistic WB
//
//  Created by LXF on 15/12/3.
//  Copyright (c) 2015年 wzk. All rights reserved.
//
//  搜索用户

#import "UserSeachViewController.h"
#import "UIImage+Circle.h"
#import "MyInformationCell7.h"
#import "Usertool.h"
#import "SearchUser.h"
#import "MJRefresh.h"
#import "User.h"
#import "InformationViewController.h"


@interface UserSeachViewController ()

{
    UITableView *tableview;
    NSMutableArray *listArr;
    UISearchBar *search;
    int index;
    User *user;
}

@end

@implementation UserSeachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    index = 1;
    listArr = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    tableview.dataSource = self;
    tableview.delegate = self;
    tableview.scrollEnabled = NO;
    tableview.separatorColor = [UIColor clearColor];
    search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    search.autocapitalizationType = UITextAutocapitalizationTypeNone;
    search.autocorrectionType = UITextAutocorrectionTypeNo;
    tableview.tableHeaderView = search;
    search.delegate = self;
    search.showsCancelButton = YES;
    [self.view addSubview:tableview];
    NSMutableArray *arr = [NSMutableArray new];
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
 
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置普通状态的动画图片
    [header setImages:arr forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:arr forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:arr forState:MJRefreshStateRefreshing];
    // 设置header
    tableview.mj_header = header;
    
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置刷新图片
    [footer setImages:arr forState:MJRefreshStateRefreshing];
    // 设置尾部
    tableview.mj_footer = footer;
    
}


-(void)loadMoreData
{
    
    index++;
    [listArr removeAllObjects];
    [Usertool UserToolSearchUserWithtext:search.text lineNumber:5*index Success:^(NSArray *arr) {

        listArr = (NSMutableArray*)[SearchUser mj_objectArrayWithKeyValuesArray:arr];
        [tableview reloadData];
        [tableview reloadData];
        [tableview.mj_footer endRefreshing];
    } failurs:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)loadNewData

{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // NSLog(@"111  %@",listArr);
    if (listArr == nil) {
        return 0;
    }
    return [listArr count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier7 = @"CELL7";
    UINib *nib = [UINib nibWithNibName:@"MyInformationCell7" bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier7];
    MyInformationCell7 * cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifier7];
    cell.screen_name.text = [(SearchUser*)listArr[indexPath.row] screen_name];
    cell.status_text.text = [NSString stringWithFormat:@"粉丝 %d",[(SearchUser*)listArr[indexPath.row] followers_count]];
    [cell.attention_btn addTarget:self action:@selector(btnAtion:) forControlEvents:UIControlEventTouchUpInside];
    cell.attention_btn.tag = [(SearchUser*)listArr[indexPath.row] uid];
    
    [Usertool UserToolGetUserinfoWithUserID:[(SearchUser*)listArr[indexPath.row] uid] orName:nil Success:^(NSDictionary *dic) {
        [HttpTool HttpToolDowmloadImageWithURL:dic[@"avatar_large"] success:^(id JSON) {
            cell.profile_image_url.image = [UIImage circleImage:JSON withParam:5];
            [tableview.mj_header endRefreshing];
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    } failurs:^(NSError *error) {
    }];
    return cell;
}

-(void)btnAtion:(UIButton*)sender
{
    [Usertool UserToolAttentionWithUserID:sender.tag Success:^(NSDictionary *dic) {
      //  NSLog(@"%@",dic);
    } failurs:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
   // NSLog(@"搜索");
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [tableview.mj_header endRefreshing];
    searchBar.text = @"";
    [search resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    
    // 马上进入刷新状态
    [tableview.mj_header beginRefreshing];
    [listArr removeAllObjects];
    [search resignFirstResponder];
    [Usertool UserToolSearchUserWithtext:searchBar.text lineNumber:5 Success:^(NSArray *arr)
    {
        listArr = (NSMutableArray*)[SearchUser mj_objectArrayWithKeyValuesArray:arr];
        tableview.scrollEnabled = YES;
        [tableview reloadData];
    } failurs:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableview.mj_header endRefreshing];
    InformationViewController *imvc = [[InformationViewController alloc]init];
    imvc.ClickUserID = [(User*)listArr[indexPath.row] uid];
    [self.navigationController pushViewController:imvc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
