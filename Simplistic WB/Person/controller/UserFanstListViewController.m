//
//  UserFanstListViewController.m
//  Simplistic WB
//
//  Created by LXF on 15/12/2.
//  Copyright (c) 2015年 wzk. All rights reserved.
//
//  用户的粉丝列表

#import "UserFanstListViewController.h"
#import "MyInformationCell7.h"
#import "UIImage+Circle.h"
#import "Usertool.h"
#import "InformationViewController.h"
#import "SaveCountTool.h"
#import "User.h"

@interface UserFanstListViewController ()

{
    UITableView *tableview;
    NSMutableArray *listArr;
     long long  uid;//uid
    User *user;
    
}

@end

@implementation UserFanstListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //解码取出临时文件tmp中的数据
    SaveCountTool *st = [[SaveCountTool alloc]init];
    uid =[st.saveCount.uid_value longLongValue];
    listArr = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
    [Usertool UserToolGetUserfansListWithUserID:uid Success:^(NSDictionary *dic) {
        
//        NSArray *arr = dic[@"users"];
//    
//        for (NSDictionary *obj in arr)
//        {
//            user = [User mj_objectWithKeyValues:obj];
//            //UserfansList *uil = [[UserfansList alloc]initWithDict:obj];
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
    static NSString *CellIdentifier7 = @"CELL7";
    UINib *nib = [UINib nibWithNibName:@"MyInformationCell7" bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier7];
    MyInformationCell7 * cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifier7];
    cell.screen_name.text = [(User*)listArr[indexPath.row] screen_name];
    cell.status_text.text = [[(User*)listArr[indexPath.row] status] text];
    [HttpTool HttpToolDowmloadImageWithURL:[(User*)listArr[indexPath.row] avatar_hd] success:^(id JSON)
     {
         cell.profile_image_url.image = [UIImage circleImage:JSON withParam:5];
     } failure:^(NSError *error) {
     }];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
