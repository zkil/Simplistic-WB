//
//  SearchMainController.m
//  Simplistic WB
//
//  Created by Ibokan1 on 12/9/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "SearchMainController.h"
#import "CellWithImg.h"
#import "CellWithLabel.h"
#import "CellWithTopic.h"
#import "SearchController.h"
#import "PublicViewController.h"
@interface SearchMainController ()<UISearchBarDelegate,UIScrollViewDelegate>
{

    UISearchBar *search;//搜索框

    UIPageControl *  NewIdenPage;//翻页按钮
}
@end

@implementation SearchMainController

-(instancetype)init
{
    if (self = [super init]) {
        self = [super initWithStyle:UITableViewStyleGrouped];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.sectionFooterHeight = 5;
    
    self.tableView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height);
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self initWithSearchbar];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [search removeFromSuperview];
}
//初始化SearchBar
-(void)initWithSearchbar
{
    
    search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    
    search.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    search.autocorrectionType = UITextAutocorrectionTypeNo;
    
    search.delegate = self;
    
    search.placeholder = @"大家都在搜:琅琊榜";
    
    [self.navigationController.navigationBar addSubview:search];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 100;
    }
    return 0.1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 3;
            break;
        case 4:
            return 7;
            break;
        default:
            break;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *s = @"topic";
    
    static NSString *s1 = @"img";
    
    static NSString *s2 = @"label";
    
    //文字数组
    NSArray *labelArr = [NSArray new];
    
    //图片数组
    NSArray *ImgArr = [NSArray new];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:s];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:s] ;
        
    }
    
    if (indexPath.section ==1)
        {
    
        labelArr = @[@"#本年度盛宴#       |      #影响力峰会#",@"#主要看气质#       |      #大热门话题#"];
            
        UINib *nib = [UINib nibWithNibName:@"CellWithTopic" bundle:[NSBundle mainBundle]];
            
        [tableView registerNib:nib forCellReuseIdentifier:s1];
            
        CellWithTopic * cell = [tableView dequeueReusableCellWithIdentifier:s1];
        
        cell.l1.text = labelArr[indexPath.row];
            
        return cell;
            
        }
    if (indexPath.section >=2)
    {
        if (indexPath.section==2)
        {
            labelArr = @[@"热门微博",@"找人"];
            
            ImgArr = @[@"h1",@"h2"];
        }
        if (indexPath.section==3)
        {
            labelArr = @[@"奔跑2015",@"游戏中心",@"周边"];
            
             ImgArr = @[@"h3",@"h4",@"h5"];
        }
        if (indexPath.section==4)
        {
            labelArr = @[@"微博之夜",@"股票",@"听歌",@"股票",@"购物",@"旅行",@"电影",@"更多频道"];
            
             ImgArr = @[@"h6",@"h7",@"h8",@"h9",@"h10",@"h11",@"h12"];
        }
        
        UINib *nib = [UINib nibWithNibName:@"CellWithLabel" bundle:[NSBundle mainBundle]];
        
        [tableView registerNib:nib forCellReuseIdentifier:s2];
        
        CellWithLabel * cell = [tableView dequeueReusableCellWithIdentifier:s2];
        
        cell.label.text= labelArr[indexPath.row];
        
        cell.img.image = [UIImage imageNamed:ImgArr[indexPath.row]];
        
        return cell;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 0.1;
    }
    return 40;
}
//第一个scetion上的UIView
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    if (section==0)
    {
        
       NSArray* ImgArr = @[@"p1",@"p2",@"p3"];
        
        CellWithImg * cell = [[CellWithImg alloc]init];
        
        for (int i = 0; i < 3; i++)
        {
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*i, 0, 375,100)];
            
            imgView.image =[UIImage imageNamed:ImgArr[i]];
            
            [cell.scroll addSubview:imgView];
            
            cell.scroll.delegate = self;
            
            cell.scroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*(i+1) , 0);
        }
        
        //初始化
        NewIdenPage = [[UIPageControl alloc]init];
        
        NewIdenPage.frame = CGRectMake(0, 0, 100, 20);
        
        NewIdenPage.center = CGPointMake(cell.frame.size.width * 0.95, cell.frame.size.height * 0.9);
        
        //设置页数
        NewIdenPage.numberOfPages = 3 ;
        
        //设置默认页数
        NewIdenPage.currentPage = 0;
        
        //设置颜色
        NewIdenPage.currentPageIndicatorTintColor = [UIColor orangeColor];
        
        [cell addSubview:NewIdenPage];
        
        return cell;
        
    }
    return nil;
}
// ScrollView的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //偏转页码
    NewIdenPage.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    

}
//searchBar代理方法
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    SearchController *sc = [SearchController new];
    
    [self presentViewController:sc animated:YES completion:nil];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if ((indexPath.section == 2) && (indexPath.row == 0)) {
        PublicViewController *publicStatusVC = [PublicViewController new];
        [self.navigationController pushViewController:publicStatusVC animated:YES];
    }
}
@end
