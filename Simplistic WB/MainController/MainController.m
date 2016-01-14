//
//  MainController.m
//  Simplistic WB
//
//  Created by Ibokan1 on 12/4/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "MainController.h"
#import "NewsScreen.h"
#import "MyViewController.h"
#import "HomeController.h"
#import "SearchController.h"
#import "SearchMainController.h"
#import "Contacts.h"
#import "Usertool.h"
#import "SaveCountTool.h"
#import "HttpTool.h"
#import "User.h"
#import "SendWeiboViewController.h"
#import "WriteWeiboViewController.h"
@implementation MainController

-(void)viewDidLoad
{
    self.tabBar.tintColor = [UIColor orangeColor];
    
    HomeController *homeVC = [HomeController new];
    
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:homeVC];
    
    na.tabBarItem.title = @"首页";
    
    na.tabBarItem.image = [UIImage imageNamed:@"tabbar_home@2x"];
    
    NewsScreen *NewVC1 = [NewsScreen new];
    
    UINavigationController *na1 = [[UINavigationController alloc]initWithRootViewController:NewVC1];
    
    na1.tabBarItem.title = @"消息";
    
    na1.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center@2x"];
    
    NewsScreen *NewVC2 = [NewsScreen new];
    
    UINavigationController *na2 = [[UINavigationController alloc]initWithRootViewController:NewVC2];
    
    SearchMainController *NewVC3 = [SearchMainController new];
    
    UINavigationController *na3 = [[UINavigationController alloc]initWithRootViewController:NewVC3];
    
    na3.tabBarItem.title = @"发现";
    
    na3.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover@2x"];
    
    MyViewController *NewVC4 = [MyViewController new];
    
    UINavigationController *na4 = [[UINavigationController alloc]initWithRootViewController:NewVC4];
    
    na4.tabBarItem.title = @"我";
    
    na4.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile@2x"];
    
    self.selectedIndex = 3;
    
    self.viewControllers = @[na,na1,na2,na3,na4];
    
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    bu.frame = CGRectMake(0, 0, 40, 40);
    
    bu.center = CGPointMake(self.tabBar.frame.size.width/2, self.tabBar.frame.size.height/2);
    
    [bu setBackgroundImage:[UIImage imageNamed:@"+"] forState:UIControlStateNormal];
    
    [bu addTarget:self action:@selector(touchAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabBar addSubview:bu];
    
    
}
-(void)loadData
{

    st = [[SaveCountTool alloc]init];
    
    long long uid = [st.saveCount.uid_value longLongValue];
    
    [Usertool UserToolGetUserinfoWithUserID:uid orName:nil Success:^(NSDictionary *dic)
     {
        
         User *us = [User mj_objectWithKeyValues:dic];
         
         st.username = us.screen_name;
         
         
         [HttpTool HttpToolDowmloadImageWithURL:us.avatar_hd success:^(id JSON)
         {
             
             st.userimg = JSON;
             
         } failure:^(NSError *error)
         {
             
         }];
         
    } failurs:^(NSError *error) {
        
    }];

}
-(void)touchAction
{

    SendWeiboViewController* sc = [SendWeiboViewController new];
    
    sc.opendaldelegate = self;
    
    [self presentViewController:sc animated:YES completion:nil];
    
}
-(void)openmodal
{
    WriteWeiboViewController *wwvc = [[WriteWeiboViewController alloc]init];
    [self presentViewController:wwvc animated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    //请求个人数据
    [self loadData];
    [self.selectedViewController beginAppearanceTransition: YES animated: animated];
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.selectedViewController endAppearanceTransition];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [self.selectedViewController endAppearanceTransition];
}
@end
