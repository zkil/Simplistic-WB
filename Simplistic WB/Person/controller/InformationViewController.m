//
//  InformationViewController.m
//  Simplistic WB
//
//  Created by LXF on 15/11/30.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import "InformationViewController.h"
#import "Informationview.h"
#import "Usertool.h"
#import "UIImage+Circle.h"
#import "MyInformationCell4.h"
#import "User.h"
#import "ModalImageViewController.h"
#import "BasicInformationViewController.h"



@interface InformationViewController ()<ChangeBackgroundImageDelegate>

{
    UIScrollView *scrollview;
    UITableView *tableview;
    User *user;
    UIImage *backgroundimage;
    
//    NSInteger ClickUserID;
}

@end

@implementation InformationViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    scrollview = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scrollview.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 50);
    
    //初始化用户个人信息具体页面（根据UID或者名字）
    [self initInformationviewWithUserID:self.ClickUserID orName:self.name];
    //初始化tableview
    [self inittableview];
    [self.view addSubview:scrollview];
}

-(void)initInformationviewWithUserID:(long long)ID orName:(NSString*)screen_name
{
    Informationview *view = [[Informationview alloc]initWithInformationview];
    view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    backgroundimage = [UIImage imageNamed:@"page3.jpg"];
    view.tag = 20001;
    view.backgroundColor = [UIColor colorWithPatternImage:backgroundimage];
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userdefaults objectForKey:@"imagedata"];
    if (data == nil) {
        backgroundimage = [UIImage imageNamed:@"page3.jpg"];
    }
    else
    {
        UIImage *image = [UIImage imageWithData:data];
        backgroundimage = [UIImage OriginImage:image scaleToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 200)];
    }
    
    view.tag = 20001;
    view.backgroundColor = [UIColor colorWithPatternImage:backgroundimage];
    // 给view添加手势
    UITapGestureRecognizer * tgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeaImageAtion)];
    [view addGestureRecognizer:tgr];
    //根据screen_name是否为空判断是根据UID 还是根据screen_name来获取数据
    if (screen_name == nil) {
        //根据id获取用户信息
        [Usertool UserToolGetUserinfoWithUserID:ID orName:nil Success:^(NSDictionary *dic) {
            //创建SWBSpecificInformation对象来接我们需要的数据，通过字典
            user = [User mj_objectWithKeyValues:dic];
            [view setContent:user];
            [tableview reloadData];
        } failurs:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        [scrollview addSubview:view];
    }
    else
    {
        [Usertool UserToolGetUserinfoWithUserID:ID orName:screen_name Success:^(NSDictionary *dic) {
            user = [User mj_objectWithKeyValues:dic];
            [view setContent:user];
            [tableview reloadData];
        } failurs:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        [scrollview addSubview:view];
    }
    
}

-(void)inittableview
{
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-200) style:UITableViewStyleGrouped];
    tableview.dataSource = self;
    tableview.delegate = self;
    [scrollview addSubview:tableview];
}

//点击触发方法
-(void)changeaImageAtion
{
    ModalImageViewController *mivc = [[ModalImageViewController alloc]init];
    mivc.image = backgroundimage;
    mivc.changeBackgroundImageDelegate = self;
    [self presentViewController:mivc animated:YES completion:nil];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 2)
    {
        return 2;
    }
    else if (section == 1)
    {
        return 5;
    }
    else
    {
        return 1;
    }
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
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

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier4 = @"CELL4";
    static NSString* CellIdentifier5 = @"CELL5";
    if (indexPath.section == 0 && indexPath.row == 0) {
        UINib *nib = [UINib nibWithNibName:@"MyInformationCell4" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier4];
        MyInformationCell4 * cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifier4];
        cell.textlabel.text = user.location;
        cell.headtext.text = @"地址";
        return cell;
    }
    else if (indexPath.section == 0 && indexPath.row == 1)
    {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier5];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor colorWithRed:220/255 green:220/255 blue:220/255 alpha:0.5];
        cell.textLabel.text = @"更多个人资料";
        return cell;
    }
    else
    {
        UINib *nib = [UINib nibWithNibName:@"MyInformationCell4" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier4];
        MyInformationCell4 * cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifier4];
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 1)
    {
        BasicInformationViewController *bivc = [[BasicInformationViewController alloc]init];
        bivc.ClickUserID = self.ClickUserID;
        
        [self.navigationController pushViewController:bivc animated:YES];
    }
}

-(void)ChangeBackgroundImage:(UIImage *)image
{
    Informationview *view = (Informationview*)[self.view viewWithTag:20001];
    view.backgroundColor = [UIColor colorWithPatternImage:image];
    backgroundimage = image;

}

@end
