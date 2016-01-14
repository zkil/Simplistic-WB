//
//  UserInterestListViewController.m
//  Simplistic WB
//
//  Created by LXF on 15/12/2.
//  Copyright (c) 2015年 wzk. All rights reserved.
//
//  用户的关注列表

#import "UserInterestListViewController.h"
#import "MyInformationCell6.h"
#import "Usertool.h"
#import "UserInterestList.h"
#import "UIImage+Circle.h"
#import "InformationViewController.h"
#import "SaveCountTool.h"
#import "User.h"

@interface UserInterestListViewController ()

{
    UITableView *tableview;
    NSMutableArray *listArr;
    long long uid;//uid
    User *user;
}

@end

@implementation UserInterestListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //解码取出临时文件tmp中的数据
    SaveCountTool *st = [[SaveCountTool alloc]init];
    uid =[st.saveCount.uid_value longLongValue];
    listArr = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    //请求数据
    [Usertool UserToolGetUserInterestListWithUserID:uid Success:^(NSDictionary *dic) {
        // 根据key 得到用户数组
      //  NSArray *arr = dic[@"users"];
        
        // 遍历数组
//        for (NSDictionary *obj in arr)
//        {
////            UserInterestList *uil = [[UserInterestList alloc]initWithDict:obj];
//            user = [User mj_objectWithKeyValues:obj];
//            
//            [listArr addObject:user];
//        }
        listArr = (NSMutableArray *)[User mj_objectArrayWithKeyValuesArray:[dic valueForKey:@"users"]];
        [tableview reloadData];
    } failurs:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listArr count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier6 = @"CELL6";
    UINib *nib = [UINib nibWithNibName:@"MyInformationCell6" bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier6];
    MyInformationCell6 * cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifier6];
    cell.screen_name.text = [(User*)listArr[indexPath.row] screen_name];
    cell.status_text.text = [[(User*)listArr[indexPath.row] status] text];
    [cell.cancel_btn addTarget:self action:@selector(btnAtion:) forControlEvents:UIControlEventTouchUpInside];
    cell.cancel_btn.tag = [(User*)listArr[indexPath.row] uid];
    
    
    [HttpTool HttpToolDowmloadImageWithURL:[(User*)listArr[indexPath.row] avatar_hd] success:^(id JSON)
    {
        cell.profile_image_url.image = [UIImage circleImage:JSON withParam:5];
    } failure:^(NSError *error) {
    }];
    return cell;
}

-(void)btnAtion:(UIButton *)sender
{
    
    [Usertool UserToolCancelAttentionWithUserID:sender.tag Success:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
    } failurs:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 65;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    InformationViewController *uilvc = [[InformationViewController alloc]init];
    uilvc.ClickUserID =[(User*)listArr[indexPath.row] ID];
    [self.navigationController pushViewController:uilvc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
