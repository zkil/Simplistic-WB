//
//  PopViewcController.m
//  Simplistic WB
//
//  Created by Ibokan1 on 12/5/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "PopViewcController.h"
#import "ReplyNews.h"
#import "NewsAtCell.h"
#import "StatusDetailsController.h"
#import "StatusTool.h"
#import "MJExtension.h"
#import "Status.h"
@interface PopViewcController ()

@end

@implementation PopViewcController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //警告弹出框
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"回复评论" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {
    
        [self.delegate skipController:self.cell];
        
        
    }];
    
    

    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"查看微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {
        
        NewsAtCell *ce = (NewsAtCell*)self.cell;
    
       [StatusTool statusToolGetStatusWithID:ce.wbID success:^(id JSON)
        {

            
            [self.delegate WbController:JSON];
            
         
       } failure:^(NSError *error)
        {

        
          [self.delegate WbFailController:error];
            
            

       }];
       
        
        
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    [self addAction:action1];
    
    [self addAction:action2];
    
    [self addAction:action3];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
