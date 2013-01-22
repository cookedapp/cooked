//
//  DiscUtils.h
//  StoryTBD
//
//  Created by chrisshanley on 9/4/12.
//  Copyright (c) 2012 chrisshanley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscUtils : NSObject
{
    NSFileManager *fileManager;
}
+(DiscUtils *)sharedDiscUtils;
-(BOOL)doesImageOfNameExist:(NSString *)fileName;
-(void)saveImageForName:(NSString *)fileName withImage:(UIImage *)image;
-(void)imageSaveCompete;
-(void)loadImageFromDisc:( void (^) (UIImage *image) )block;

@property(nonatomic, strong)NSFileManager *fileManager;
@end
