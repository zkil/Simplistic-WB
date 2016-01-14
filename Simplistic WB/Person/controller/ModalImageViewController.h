//
//  ModalImageViewController.h
//  Simplistic WB
//
//  Created by LXF on 15/12/7.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChangeBackgroundImageDelegate<NSObject>
-(void)ChangeBackgroundImage:(UIImage*)image;
@end

@interface ModalImageViewController : UIViewController
//属性传值，传image
@property (nonatomic,strong) UIImage *image;

@property (nonatomic,strong) id <ChangeBackgroundImageDelegate>changeBackgroundImageDelegate;

@end
