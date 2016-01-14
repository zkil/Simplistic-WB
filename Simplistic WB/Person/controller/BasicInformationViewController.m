//
//  BasicInformationViewController.m
//  Simplistic WB
//
//  Created by LXF on 15/12/1.
//  Copyright (c) 2015年 wzk. All rights reserved.
//
//  更多个人资料

#import "BasicInformationViewController.h"
#import "MyInformationCell4.h"
#import "Usertool.h"
#import "User.h"
@interface BasicInformationViewController ()

{
    UITableView *tableview;
    User *user;
}

@end

@implementation BasicInformationViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    tableview.dataSource = self;
    tableview.delegate = self;
    [self.view addSubview:tableview];
    [Usertool UserToolGetUserinfoWithUserID:self.ClickUserID orName:nil Success:^(NSDictionary *dic) {
        user = [User mj_objectWithKeyValues:dic];
        [tableview reloadData];
    } failurs:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    else
    {
        return 1;
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier4 = @"CELL4";
    UINib *nib = [UINib nibWithNibName:@"MyInformationCell4" bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier4];
    MyInformationCell4 * cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifier4];
    if (indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 0:
            {
                cell.headtext.text = @"昵称";
                cell.textlabel.text = user.screen_name;
            }
                break;
            case 1:
            {
                cell.headtext.text = @"性别";
                if ([user.gender isEqualToString:@"m"]) {
                    cell.textlabel.text = @"男";
                }
                else
                {
                    cell.textlabel.text = @"女";
                }
            }
                break;
            case 2:
            {
                cell.headtext.text = @"所在地";
                cell.textlabel.text = user.location;
            }
                break;
            case 3:
            {
                cell.headtext.text = @"简介";
                cell.textlabel.text = user.describe;
            }
                break;
                
            default:
                break;
        }
    }
    else
    {
        cell.headtext.text = @"注册时间";
        cell.textlabel.text = [user created_at];
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
