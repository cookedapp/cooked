//
//  AppUtils.m
//  StoryTBD
//
//  Created by chrisshanley on 8/25/12.
//  Copyright (c) 2012 chrisshanley. All rights reserved.
//

#import "AppUtils.h"

@implementation AppUtils
@synthesize videoFrameRef;

+(AppUtils *)sharedAppUtils
{
    static AppUtils *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        instance = [[AppUtils alloc]init];
    });
    return instance;
}

+(NSString *)applicationDocumentsDirectory
{
    return [ NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES ) lastObject ];
}

@end
