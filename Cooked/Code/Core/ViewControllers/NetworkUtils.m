//
//  NetworkUtils.m
//  StoryTBD
//
//  Created by chrisshanley on 8/30/12.
//  Copyright (c) 2012 chrisshanley. All rights reserved.
//

#import "NetworkUtils.h"

@interface NetworkUtils()
{
    
}

-(void)setInitialized:(BOOL )value;
-(BOOL)initialized;
@end

@implementation NetworkUtils
@synthesize networkStatus;

+(NetworkUtils *)shareNetworkUtils
{
    static NetworkUtils *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
    {
        instance = [[NetworkUtils alloc]init];
        
    });
    
    return  instance;
}

-(void)setInitialized:(BOOL )value
{
    initialized = value;
}

-(BOOL)initialized
{
    return initialized;
}

-(id)init
{
    self = [super init];
    self.networkStatus = AFNetworkReachabilityStatusUnknown;
    
    
    if( self )
    {
        initialized = NO;
    }
    
    return  self;
}

-(void)getConnectionStatusWithDelay:( void (^) () )done
{
    client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://google.com"]];
    
    __block NetworkUtils *blockSelf = self;
    
    [client setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
    {
        blockSelf.networkStatus = status;
        
        if(  blockSelf.networkStatus == AFNetworkReachabilityStatusUnknown )
        {
            return ;
        }
        
        if( [blockSelf initialized] == NO )
        {
            done();
            [blockSelf setInitialized:YES];
            [blockSelf hasNetworkConnection];
        }
    }];
}

-(BOOL)hasNetworkConnection
{
    BOOL hasConnection = ( AFNetworkReachabilityStatusNotReachable ) ? NO : YES;
    
    
    if( hasConnection == NO  )
    {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Sorry"
                                              message:@"A internet connection is required to get TBD's content"
                                              delegate:nil cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [av show];
    }
    return hasConnection;
}

@end
