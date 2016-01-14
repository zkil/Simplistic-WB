//
//  AppDelegate.m
//  Simplistic WB
//
//  Created by Ibokan1 on 11/25/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "AppDelegate.h"
#import "NewIdentityController.h"
#import "LoginScreenController.h"
#import "SaveCount.h"
#import "SaveCountTool.h"
#import "NewsScreen.h"
#import "MainController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    
    //通过单例模式获取NSUserDefaults对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *st = [defaults objectForKey:@"isfirst"];
    
    //判断是否是第一次进入
    if (st==nil)
    {
    
        [defaults setObject:@"first" forKey:@"isfirst"];
        
        NewIdentityController *SNVC = [NewIdentityController new];
        
        self.window.rootViewController = SNVC;
        
    }
    
    
    else
    {
     
        SaveCountTool *st = [[SaveCountTool alloc]init];
        
        //tmp文件是否存在acctoken
        //进入主页
        if (st.saveCount)
        {
            NSLog(@"%@,%@",st.saveCount.access_token_value,st.saveCount.uid_value);
            
            MainController *ta = [MainController new];
            
            //UINavigationController *na  = [[UINavigationController alloc]initWithRootViewController:ta];
            
             self.window.rootViewController = ta;
            
            
        }
        //再次进入登陆页面
        else
        {
            
          LoginScreenController *SSVC = [LoginScreenController new];
        
          self.window.rootViewController = SSVC;
            
        }
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
