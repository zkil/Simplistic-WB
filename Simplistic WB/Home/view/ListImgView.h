//
//  ListImgView.h
//  Simplistic WB
//
//  Created by wzk on 15/11/30.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ListImgViewDelegete <NSObject>
-(void)pushOriginalImageController:(NSString *)pic_url;
@end
@interface ListImgView : UIImageView
@property(nonatomic)NSArray *pic_urls;
@property(nonatomic)UIViewController<ListImgViewDelegete> *delegate;
@end
