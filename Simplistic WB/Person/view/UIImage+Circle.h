//
//  UIImage+Circle.h
//  Simplistic WB
//
//  Created by LXF on 15/11/30.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Circle)

+(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset;

+(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

@end
