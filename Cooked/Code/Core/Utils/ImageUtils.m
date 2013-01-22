//
//  ImageUtils.m
//  FunRun
//
//  Created by Chris Shanley on 1/14/13.
//  Copyright (c) 2013 Chris Shanley. All rights reserved.
//

#import "ImageUtils.h"
#import <QuartzCore/QuartzCore.h>

@implementation ImageUtils


+(UIImage *)drawView:(UIView *)view AtRect:(CGRect)drawFrame
{
    UIGraphicsBeginImageContext( drawFrame.size );
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
