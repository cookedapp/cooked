//
//  FBManager.h
//  FunRun
//
//  Created by Chris Shanley on 1/14/13.
//  Copyright (c) 2013 Chris Shanley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import "FBShareObject.h"

typedef void (^ActionCompleteBlock) (BOOL success);
typedef void (^ImageActionCompleteBlock) (BOOL success, NSString *imageURL);

@interface FBManager : NSObject
{
    NSError *currentError;
}

+(FBManager *)sharedManager;

-(void)login:(ActionCompleteBlock)block;
-(void)shareToNewsFeed:(FBShareObject *)postData completeBlock:(ActionCompleteBlock )block;
-(void)loadFriends:(ActionCompleteBlock )block;
-(void)savePhoto:(UIImage *)img completeBlock:(ImageActionCompleteBlock)block;


-(NSError *)getCurrentError;

@property(nonatomic, copy)ActionCompleteBlock completeBlock;
@property(nonatomic, copy)ImageActionCompleteBlock imageCompleteBlock;
@property(nonatomic, strong)FBSession *session;

@end
