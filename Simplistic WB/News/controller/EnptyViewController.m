//
//  EnptyViewController.m
//  Simplistic WB
//
//  Created by wzk on 15/12/12.
//  Copyright (c) 2015年 Ibokan1. All rights reserved.
//

#import "EnptyViewController.h"

@interface EnptyViewController ()

@end

@implementation EnptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIAlertController *AL = [UIAlertController  alertControllerWithTitle:@"获取失败" message:@"失败原因" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:[self.error localizedDescription] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                              {
                                  
                                  
                                  
                              }];
    
    [AL addAction:action1];
    
    [self presentViewController:AL animated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
