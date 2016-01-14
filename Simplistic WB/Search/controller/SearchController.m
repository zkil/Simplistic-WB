//
//  SearchController.m
//  Simplistic WB
//
//  Created by Ibokan1 on 12/8/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "SearchController.h"
#import "CellWithTopic.h"
#import "SearchTool.h"
#import "SearchApp.h"
#import "SearchSchool.h"
#import "SearchUser.h"
#import "SearchCompany.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
@interface SearchController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    UITableView *ta; //显示列表
    
    UISearchBar *search; //搜索栏
    
    NSString*  searchString; //搜索的内容
    
    int searchNum; //搜索显示的数量
    
    NSMutableArray *appArr; //应用数组
    
    NSMutableArray *companyArr; //公司数组
    
    NSMutableArray *schoolArr; //学校数组
    
    NSMutableArray *userArr ; //用户数组
    
    NSMutableArray *allArr; //结果所有数据
    
    bool hasOpen ;//记录是否为打开状态
    
    NSMutableArray *selectArr ;//记录收缩过的cell
    
}
@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithTableView];
    
    [self initWithSearchbar];
    
    [self UpdataUIWithFoot];
}

//初始化tableview
-(void)initWithTableView
{
    ta = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
    [self.view addSubview:ta];
    
    ta.dataSource = self;
    
    ta.delegate = self;
    
    ta.showsVerticalScrollIndicator = NO;
}

//初始化SearchBar
-(void)initWithSearchbar
{
    
    search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    
    search.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    search.autocorrectionType = UITextAutocorrectionTypeNo;
    
    ta.tableHeaderView = search;
    
    search.delegate = self;
    
    search.showsCancelButton = YES;
    
    search.placeholder = @"大家都在搜:琅琊榜";
    
    [search becomeFirstResponder];
}

//网络请求app
-(void)loadHttpUrl
{
    appArr = [NSMutableArray new];
    
    companyArr = [NSMutableArray new];
    
    schoolArr = [NSMutableArray new];
    
    userArr = [NSMutableArray new];
    
   //搜索app
    [SearchTool searchToolApps:searchString WithCount:searchNum success:^(id JSON) {
        
        for (NSDictionary *dic in JSON)
        {
            //转为模型
            SearchApp *app = [SearchApp mj_objectWithKeyValues:dic];
            
            if (app.apps_name)
        {
            
            //加入数组
            [appArr addObject:app.apps_name];
            
        }
            
        }
        
        [self loadHttpUrlWithSchool];
     
    } failure:^(NSError *error)
    {
        
    }];

}
//网络请求学校
-(void)loadHttpUrlWithSchool
{

    
    //搜索公司
    [SearchTool searchToolCompanies:searchString WithCount:searchNum success:^(id JSON)
     {
         
         for (NSDictionary *dic in JSON)
         {
             //转为模型
             SearchCompany *company = [SearchCompany mj_objectWithKeyValues:dic];
             
             if (company.suggestion) {
             
             //加入数组
             [companyArr addObject:company.suggestion];
                 
             }
         }
         
          [self loadHttpUrlWithCompany];
         
     } failure:^(NSError *error) {
         
     }];
    
}
//网络请求公司
-(void)loadHttpUrlWithCompany
{

    //搜索学校
    [SearchTool searchToolSchools:searchString WithCount:searchNum success:^(id JSON)
     {
         
         for (NSDictionary *dic in JSON)
         {
             //转为模型
             SearchSchool *school = [SearchSchool mj_objectWithKeyValues:dic];
             //加入数组
             
             if (school.school_name) {
             
             [schoolArr addObject:school.school_name];
                 
             }
             
         }
         
        [self loadHttpUrlWithUser];
         
     } failure:^(NSError *error)
     {
         
     }];
    
}
//网络请求用户
-(void)loadHttpUrlWithUser
{

    
    //搜索用户
    [SearchTool searchToolUsers:searchString WithCount:searchNum success:^(id JSON) {
   
        for (NSDictionary *dic in JSON)
        {
            //转为模型
            SearchUser *user = [[SearchUser alloc]initWithDict:dic];
            
            if (user.screen_name) {
            
            //加入数组
            [userArr addObject:user.screen_name];
                
            }
        }
        
        allArr = [NSMutableArray arrayWithArray:[self checkArr]];
        
        selectArr = [NSMutableArray new];
        
        //默认为打开状态
        hasOpen = YES;
        
        [ta reloadData];

        //隐藏加载匡
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        [ta.mj_footer endRefreshing];
        
        
    } failure:^(NSError *error)
     {
         
     }];
    
}

//第三方类库加载提示
-(void)UpdataUIWithHead
{
    //引入第三方类库MBProgressHUD
    MBProgressHUD *progressid = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //设置提示文本
    progressid.labelText = @"努力加载中";
    
    //设置字体大小
    progressid.labelFont = [UIFont systemFontOfSize:20];
}
-(void)UpdataUIWithFoot
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
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 设置刷新图片
    [footer setImages:arr forState:MJRefreshStateRefreshing];
    
    // 设置尾部
    ta.mj_footer = footer;
}

//上拉加载更多
-(void)loadMoreData
{
    
    if (searchNum<=10)
    {
       searchNum+=2;
        
        //开始网络请求
       [self loadHttpUrl];
    }
    
    
    else
    {
    
        ta.mj_footer.hidden = YES;
        
    }
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{

    [searchBar isFirstResponder];
}

//搜索开始
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
 
    [searchBar resignFirstResponder];
    
    //获得搜索文本
    searchString = searchBar.text;
    
    //默认搜索内容为5
    searchNum = 5;
    
    //加载状态
    [self UpdataUIWithHead];
    
    //开始网络请求
    [self loadHttpUrl];
    
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{

    [searchBar resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 0.1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   
    if (section==0)
    {
        return 0.1;
    }
    
    return 10;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{


    return  allArr.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([selectArr indexOfObject:@(section)]!=NSNotFound)
    {
        
        return 1;
    }
    
    return [allArr[section] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    
    static NSString *name2 = @"name2";
    
    UITableViewCell *cel = [tableView dequeueReusableCellWithIdentifier:name2];
      
      if (!cel) {
          cel = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:name2];
      }
      
    cel.textLabel.text = [allArr[indexPath.section]objectAtIndex:indexPath.row];
    
    if (indexPath.row==0)
    {
        
        UIColor *new =  [UIColor blueColor];

        //设置颜色
        cel.textLabel.textColor = new;
        
        //设置cell样式
        cel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
   if (indexPath.row>0)
    {
    
        UIColor *new =  [UIColor orangeColor];
        
        //设置颜色
        cel.textLabel.textColor = new;
        
        UIFont *font = [UIFont systemFontOfSize:13];
        
        cel.textLabel.font = font;
        
        cel.accessoryType = UITableViewCellAccessoryNone;
        
    }
      return cel;
  
}

//检测各个数组是否存在返回数组
-(NSMutableArray*)checkArr
{
    
   NSMutableArray* _allArr = [NSMutableArray new];
    
    if (appArr.count>0)
    {
        
        [appArr insertObject:@"应用" atIndex:0];
        
        [_allArr addObject:appArr];
    }
    if (schoolArr.count>0)
    {
        
        [schoolArr insertObject:@"学校" atIndex:0];
        
        [_allArr addObject:schoolArr];
    }
    if (companyArr.count>0)
    {
        
        [companyArr insertObject:@"公司" atIndex:0];
        
        [_allArr addObject:companyArr];
    }
    if (userArr.count>0)
    {
        
        [userArr insertObject:@"用户" atIndex:0];
        
        [_allArr addObject:userArr];
    }
    
    return _allArr;
}
-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row>0)
    {
        
        return 2;
        
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([selectArr indexOfObject:@(indexPath.section)]==NSNotFound)
    {
        hasOpen = true;
    }
    
    else
    {
       
      hasOpen = false;
       
    }
    if (indexPath.row==0)
    {
        //打开状态
        if (hasOpen)
        {
            
            [selectArr addObject:@(indexPath.section)];
            
        }
        //关闭状态
        if (!hasOpen)
        {
            
            [selectArr removeObject:@(indexPath.section)];
        }
        
        hasOpen = !hasOpen;
        
        [ta reloadData];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
