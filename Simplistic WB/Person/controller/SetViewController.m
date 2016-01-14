//
//  SetViewController.m
//  Simplistic WB
//
//  Created by Ibokan1 on 12/10/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "SetViewController.h"
#import "LoginScreenController.h"


@interface SetViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *tableview;
}

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(1, 1, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableview];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 3) {
        return 1;
    }
    else
    {
        return 3;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *name = @"name";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:name];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"账号管理";
    }
    
     else if (indexPath.section == 1)
     {
         switch (indexPath.row) {
             case 0:
                 cell.textLabel.text = @"通知";
                 break;
             case 1:
                 cell.textLabel.text = @"隐私与安全";
                 break;
             case 2:
                 cell.textLabel.text = @"通用设置";
                 break;
                 
             default:
                 break;
         }
     }
    
     else if (indexPath.section == 2)
     {
         switch (indexPath.row) {
             case 0:
                 cell.textLabel.text = @"清除缓存";
                 break;
             case 1:
                 cell.textLabel.text = @"意见反馈";
                 break;
             case 2:
                 cell.textLabel.text = @"关于微博";
                 break;
                 
             default:
                 break;
         }
     }
    
    else
    {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.text = @"                       退出当前账号";
    }

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
        {
            
            exit(0);
            
         
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
         //   NSLog(@"取消");
        }];
        [alertController addAction:action1];
        [alertController addAction:action2];
        [self presentViewController:alertController animated:YES completion:nil];

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
