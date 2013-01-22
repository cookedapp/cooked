//
//  NetworkUtils.h
//  StoryTBD
//
//  Created by chrisshanley on 8/30/12.
//  Copyright (c) 2012 chrisshanley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface NetworkUtils : NSObject
{
    AFHTTPClient *client;
    AFNetworkReachabilityStatus networkStatus;
    BOOL initialized;
}

-(BOOL)hasNetworkConnection;
-(void)getConnectionStatusWithDelay:( void (^) () )done;
+(NetworkUtils *)shareNetworkUtils;


@property(nonatomic , assign)AFNetworkReachabilityStatus networkStatus;


@end
