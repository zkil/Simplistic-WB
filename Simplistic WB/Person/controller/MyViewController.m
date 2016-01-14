//
//  MyViewController.m
//  Simplistic WB
//
//  Created by LXF on 15/11/29.
//  Copyright (c) 2015年 wzk. All rights reserved.
//
//  我的页面的ViewController


#import "MyViewController.h"
#import "MyInformationCell2.h"
#import "MyInformationCell3.h"
#import "MyInformationCell1.h"
#import "Usertool.h"
#import "User.h"
#import "UIImage+Circle.h"
#import "InformationViewController.h"
#import "SaveCountTool.h"
#import "SaveCount.h"
#import "UserSeachViewController.h"
#import "UserInterestListViewController.h"
#import "UserFanstListViewController.h"
#import "SetViewController.h"
#import "MyStatusViewController.h"

@interface MyViewController ()

{
    UITableView *tableview;
    
    long long uid1;//uid
    
    User *user;
    
    SaveCountTool *st;
}

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //解码取出临时文件tmp中的数据
    st = [[SaveCountTool alloc]init];
   
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    [Usertool UserToolGetUserinfoWithUserID:[st.saveCount.uid_value longLongValue] orName:nil Success:^(NSDictionary *dic)
     {
        
         user = [User mj_objectWithKeyValues:dic];
         [tableview reloadData];
     } failurs:^(NSError *error)
     {
         NSLog(@"%@",error);
     }];

    
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    
    UIBarButtonItem  *left = [[UIBarButtonItem alloc]initWithTitle:@"添加好友" style:UIBarButtonItemStyleDone target:self action:@selector(AddFriendAction)];
    
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(SetAtion)];
    
    self.navigationItem.rightBarButtonItem = right;
    
}

//添加好友
-(void)AddFriendAction
{

    UserSeachViewController *uc = [UserSeachViewController new];
    
    uc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:uc animated:YES];
    
}

//设置
-(void)SetAtion
{
    SetViewController *svc = [[SetViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
  //  NSLog(@"设置");
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 2:
            return 2;
            break;
        case 4:
            return 1;
            break;
        case 5:
            return 1;
            break;
        default:
            return 3;
            break;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return 100;
    }
     else if (indexPath.section == 0 && indexPath.row == 1)
    {
        return 60;
    }
    else
    {
        return 44;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //三个不同样式的UITableViewCell
    static NSString *CellIdentifier1 = @"CELL1";
    static NSString *CellIdentifier2 = @"CELL2";
    static NSString *CellIdentifier3 = @"CELL3";
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        UINib *nib = [UINib nibWithNibName:@"MyInformationCell1" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier1];
        MyInformationCell1 * cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifier1];
        cell.screen_name.text = user.screen_name;
        cell.descriptiontext.text = [NSString stringWithFormat:@"简介：%@",user.describe];
        if (user.avatar_hd != nil) {
            
            [HttpTool HttpToolDowmloadImageWithURL:user.avatar_hd success:^(id JSON) {
                cell.profile_image.image = [UIImage circleImage:JSON withParam:10];
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
        }
        return cell;
    }
    else if (indexPath.section == 0 && indexPath.row == 1)
    {
        UINib *nib = [UINib nibWithNibName:@"MyInformationCell3" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier3];
        MyInformationCell3 * cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifier3];
        //设置三个按钮的tag 及触发方法
        cell.friends_btn.tag = 10002;
        cell.statuses_btn.tag = 10001;
        cell.followers_btn.tag = 10003;
        [cell.statuses_btn addTarget:self action:@selector(btnAtion:) forControlEvents:UIControlEventTouchUpInside];
        [cell.friends_btn addTarget:self action:@selector(btnAtion:) forControlEvents:UIControlEventTouchUpInside];
        [cell.followers_btn addTarget:self action:@selector(btnAtion:) forControlEvents:UIControlEventTouchUpInside];
        //设置选中cell的背景色
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        //请求数据 设置cell
        cell.friends_count.text = [NSString stringWithFormat:@"%ld",(long)user.friends_count];
        cell.statuses_count.text = [NSString stringWithFormat:@"%ld",(long)user.statuses_count];
        cell.followers_count.text = [NSString stringWithFormat:@"%ld",(long)user.followers_count];
        
        return cell;
    }
    else
    {
        UINib *nib = [UINib nibWithNibName:@"MyInformationCell2" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier2];
        MyInformationCell2 * cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (indexPath.section == 1) {
            switch (indexPath.row) {
                case 0:
                {
                    cell.labeltext.text = @"新的好友";
                    cell.image.image = [UIImage imageNamed:@"m1.png"];
                }
                    break;
                case 1:
                {
                    cell.labeltext.text = @"你感兴趣的人";
                    cell.image.image = [UIImage imageNamed:@"m2.png"];
                }
                    break;
                case 2:
                {
                    cell.labeltext.text = @"新手任务";
                    cell.image.image = [UIImage imageNamed:@"m3.png"];
                }
                    break;
                case 3:
                {
                    cell.labeltext.text = @"编辑资料";
                    cell.image.image = [UIImage imageNamed:@"m4.png"];
                }
                    break;
                default:
                    break;
            }
        }
        
        else if (indexPath.section == 2) {
            switch (indexPath.row) {
                case 0:
                {
                    cell.labeltext.text = @"我的相册";
                    cell.image.image = [UIImage imageNamed:@"m5.png"];
                }
                    break;
                case 1:
                {
                    cell.labeltext.text = @"我的赞";
                    cell.image.image = [UIImage imageNamed:@"m6.png"];
                }
                    break;
        
                default:
                    break;
            }
        }
        
        else if (indexPath.section == 3) {
            switch (indexPath.row) {
                case 0:
                {
                    cell.labeltext.text = @"微博会员";
                    cell.image.image = [UIImage imageNamed:@"m7.png"];
                }
                    break;
                case 1:
                {
                    cell.labeltext.text = @"微博运动";
                    cell.image.image = [UIImage imageNamed:@"m8.png"];
                }
                    break;
                case 2:
                {
                    cell.labeltext.text = @"微博支付";
                    cell.image.image = [UIImage imageNamed:@"m9.png"];
                }
                    break;
                default:
                    break;
            }
        }
        else if (indexPath.section == 4)
        {
            cell.labeltext.text = @"草稿箱";
            cell.image.image = [UIImage imageNamed:@"m10.png"];
        }
        else
        {
            cell.labeltext.text = @"更多";
            cell.image.image = [UIImage imageNamed:@"m11.png"];
        }
        
        
        
        return cell;
    }
}

-(void)btnAtion:(UIButton*)sender
{
    switch (sender.tag%10) {
        case 1:
            
        {
            MyStatusViewController *myStatusVc = [MyStatusViewController new];
            myStatusVc.userUid = [st.saveCount.uid_value longLongValue];
            [self.navigationController pushViewController:myStatusVc animated:YES];
        }
            break;
        case 2:
            
        {
            
            UserInterestListViewController* uvc = [UserInterestListViewController new];
            
            uvc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:uvc animated:YES];
            
            
        }
            break;
        case 3:
            
        {
            UserFanstListViewController* uvc = [UserFanstListViewController new];
            
            uvc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:uvc animated:YES];
        }
            break;
        default:
            break;
    }
  //  NSLog(@"按钮方法");
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        
        InformationViewController* ic = [InformationViewController new];
        
        ic.hidesBottomBarWhenPushed = YES;
        
        //解码取出临时文件tmp中的数据
        st = [[SaveCountTool alloc]init];
        
        ic.ClickUserID =  [st.saveCount.uid_value longLongValue];
        
        [self.navigationController pushViewController:ic animated:YES];
        
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 25;
    }
    else
    {
        return 5;
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
