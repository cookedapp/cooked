//
//  FBManager.m
//  FunRun
//
//  Created by Chris Shanley on 1/14/13.
//  Copyright (c) 2013 Chris Shanley. All rights reserved.
//

#import "FBManager.h"
@interface FBManager()
{
    
}

-(void)setCurrentError:(NSError *)value;
-(void)getPhotoInfo:(NSString *)photoID;
@end


@implementation FBManager


@synthesize session;
@synthesize completeBlock;


+(FBManager *)sharedManager
{
    static dispatch_once_t onceToken;
    static FBManager *instance;
    
    dispatch_once(&onceToken, ^{
        instance = [[FBManager alloc]init];
    });
    return instance;
}


-(void)login:(ActionCompleteBlock)block
{
    self.completeBlock = block;
    
    NSArray *permissions = [NSArray arrayWithObjects:@"publish_actions",@"user_photos", nil];
    
    if( self.session == nil || self.session.isOpen == NO)
    {
        self.session = [[FBSession alloc]initWithPermissions:permissions];
        
        __block FBManager *weakself = self;
        
        [self.session openWithCompletionHandler:^(FBSession *s, FBSessionState status, NSError *error)
        {
            if( error == nil )
            {
                weakself.session = s;
                [FBSession setActiveSession:s];
                weakself.completeBlock(YES);
            }
            else
            {
                [weakself setCurrentError:error];
                weakself.completeBlock(NO);
            }
            
        }];
    }
    else
    {
        [FBSession setActiveSession:self.session];
        self.completeBlock(YES);
    }
}


-(void)shareToNewsFeed:(FBShareObject *)postData completeBlock:(ActionCompleteBlock )block
{
    self.completeBlock = block;
    __block FBManager *weakself = self;
    [FBRequestConnection startWithGraphPath:@"me/feed" parameters:[postData toDictionary] HTTPMethod:@"POST" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
       
        if( error != nil )
        {
            NSLog(@"%@ got error , %@ ", weakself, error );
            [weakself setCurrentError:error];
            weakself.completeBlock(NO);
        }
        else
        {
            weakself.completeBlock(YES);
        }
    }];
}

-(void)loadFriends:(ActionCompleteBlock )block
{
    __block FBManager *weakself = self;
    
    [FBRequestConnection startWithGraphPath:@"me/friends" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
       
        if( error != nil )
        {
            [weakself setCurrentError:error];
            weakself.completeBlock(NO);
        }
        else
        {
            NSLog(@"%@ , friends : %@ ", self, result );
            weakself.completeBlock(NO);
        }

    }];
}

-(void)savePhoto:(UIImage *)img completeBlock:(ImageActionCompleteBlock)block
{
    self.imageCompleteBlock = block;
    __block FBManager *weakself = self;
    
    
    [FBRequestConnection startForUploadPhoto:img completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
       
        if( error != nil )
        {
            [weakself setCurrentError:error];
            NSLog(@"%@ fb failed save image , %@ ", self, error );
            //
            //    weakself.imageCompleteBlock(NO, result);
        }
        else
        {

            [weakself getPhotoInfo:[result valueForKey:@"id"]];
        }
    }];
}

-(void)getPhotoInfo:(NSString *)photoID
{
    __block FBManager *weakself = self;
    
    [FBRequestConnection startWithGraphPath:[NSString stringWithFormat:@"/%@", photoID] completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if( error == nil )
        {
            self.imageCompleteBlock( YES , [result valueForKey:@"picture"] );
        }
        else
        {
            [weakself setCurrentError:error];
            self.imageCompleteBlock(NO, nil );
        }
    }];
}

-(void)setCurrentError:(NSError *)value
{
    currentError = value;
}

-(NSError *)getCurrentError
{
    return currentError;
}

@end
