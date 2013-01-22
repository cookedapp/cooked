//
//  DiscUtils.m
//  StoryTBD
//
//  Created by chrisshanley on 9/4/12.
//  Copyright (c) 2012 chrisshanley. All rights reserved.
//

#import "DiscUtils.h"

@implementation DiscUtils

@synthesize fileManager;

+(DiscUtils *)sharedDiscUtils
{
    static DiscUtils *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
    {
        instance = [[DiscUtils alloc]init];
        instance.fileManager  = [[NSFileManager alloc]init];
    });
    return  instance;
}

-(BOOL)doesImageOfNameExist:(NSString *)fileName
{
    return NO;
}

-(void)saveImageForName:(NSString *)fileName withImage:(UIImage *)image
{
    
}


-(void)loadImageFromDisc:( void (^) (UIImage *image) )block
{
    
}

-(void)imageSaveCompete
{
    
}

@end
