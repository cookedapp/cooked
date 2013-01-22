//
//  AppUtils.h
//  StoryTBD
//
//  Created by chrisshanley on 8/25/12.
//  Copyright (c) 2012 chrisshanley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUtils : NSObject
{
    UIImage *videoFrameRef;
}

@property(nonatomic, strong)UIImage *videoFrameRef;

+(NSString *)applicationDocumentsDirectory;
+(AppUtils *)sharedAppUtils;

@end
