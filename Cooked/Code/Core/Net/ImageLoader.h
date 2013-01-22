//
//  ImageLoader.h
//  StoryTBD
//
//  Created by chrisshanley on 10/27/12.
//  Copyright (c) 2012 chrisshanley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef void (^LoadingBlock ) (BOOL success);

@interface ImageLoader : NSObject
{
    LoadingBlock            block;
    UIImage                *image;
    NSString               *imageName;
    BOOL                    saveToDisc;
}

-(id)initWithImageNamed:(NSString *)imageName;
-(void)loadImage:( LoadingBlock )blockRef;

@property(nonatomic, copy)LoadingBlock block;
@property(nonatomic, strong)NSString  *imageName;
@property(nonatomic, assign)BOOL       saveToDisc;
@property(nonatomic, strong)UIImage   *image;
@end
