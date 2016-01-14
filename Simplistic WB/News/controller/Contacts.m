//
//  Contacts.m
//  Simplistic WB
//
//  Created by Ibokan1 on 12/9/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "Contacts.h"
#import "CellWithLabel.h"
#import "Usertool.h"
#import "SaveCountTool.h"
#import "HttpTool.h"
#import "UserfansList.h"
#import "UIImage+Circle.h"
#import "SendNews.h"
@interface Contacts ()<UISearchBarDelegate>
{

    long long  uid;//uid
    
    UISearchBar *search;//搜索框
    
    NSMutableArray * labelArr; //存储名字数组
    
    NSMutableArray *ImgArr; //存储图片数组
}
@end

@implementation Contacts
#pragma -mark- 初始化
-(instancetype)init
{
    if (self = [super init])
    {
        self = [super initWithStyle:UITableViewStyleGrouped];
    }
    return self;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    SaveCountTool *st = [[SaveCountTool alloc]init];
    
    //获取单例中的uid
    uid =[st.saveCount.uid_value longLongValue];
    
    labelArr = [NSMutableArray new];
    
    ImgArr  = [NSMutableArray new];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.tableView.sectionFooterHeight = 5;
    
    self.tableView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height);
    
    [self initWithSearchbar];
    
    [self loaddataWithInterset];
}

#pragma -mark- 初始化SearchBar
-(void)initWithSearchbar
{
    
    search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    
    search.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    search.autocorrectionType = UITextAutocorrectionTypeNo;
    
    search.delegate = self;
    
    self.tableView.tableHeaderView = search;
    
}
#pragma -mark- 网络请求加载数据关注人列表
-(void)loaddataWithInterset
{
[Usertool UserToolGetUserInterestListWithUserID:uid Success:^(NSDictionary *dic)
    {
    
        NSArray *arr = dic[@"users"];
        
        for (NSDictionary *obj in arr)
        {
            UserfansList *ufl = [[UserfansList alloc]initWithDict:obj];
            
            [labelArr addObject:ufl.screen_name];
            
            //异步加载图片
            [HttpTool HttpToolDowmloadImageWithURL:ufl.profile_image_url success:^(id JSON)
             {
                UIImage *new = [UIImage circleImage:JSON withParam:5];
                 
                 [ImgArr addObject:new];
                 
             } failure:^(NSError *error) {
                 
             }];
        
            [self.tableView reloadData];
        
        }
        [self loaddataWithFans];
        
} failurs:^(NSError *error)
    {
    
} ];
}
#pragma -mark- 网络请求加载数据粉丝列表
-(void)loaddataWithFans
{

    [Usertool UserToolGetUserfansListWithUserID:uid Success:^(NSDictionary *dic)
     {
         
         NSArray *arr = dic[@"users"];
         
         for (NSDictionary *obj in arr)
         {
            UserfansList *ufl = [[UserfansList alloc]initWithDict:obj];
             
            [labelArr addObject:ufl.screen_name];
             
             [HttpTool HttpToolDowmloadImageWithURL:ufl.profile_image_url success:^(id JSON)
              {
                
               UIImage *new =   [UIImage circleImage:JSON withParam:5];
                  
                [ImgArr addObject:new];
                  
              } failure:^(NSError *error) {
                  
              }];
             
              [self.tableView reloadData];
         }
         
 
         
     } failurs:^(NSError *error)
     {
         
     } ];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    // Return the number of rows in the section.
    return ImgArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *s = @"name";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:s];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:s] ;
        
    }
    
    if (labelArr.count>0)
    {
    
    UINib *nib = [UINib nibWithNibName:@"CellWithLabel" bundle:[NSBundle mainBundle]];
    
    [tableView registerNib:nib forCellReuseIdentifier:s];
    
    CellWithLabel * cell = [tableView dequeueReusableCellWithIdentifier:s];
    
    cell.label.text= labelArr[indexPath.row];
        
    cell.img.clipsToBounds  = YES;
        
    cell.img.image = ImgArr[indexPath.row];
        
    return cell;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellWithLabel *cell = (CellWithLabel*)[tableView cellForRowAtIndexPath:indexPath];

    SendNews *sn = [SendNews new];
    
    sn.name = cell.label.text;
    
    sn.img = cell.img.image;
    
    [self.navigationController pushViewController:sn animated:YES];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
