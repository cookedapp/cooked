//
//  EHLocalRequest.m
//  EHLib
//
//  Created by Chris Shanley on 12/19/12.
//  Copyright (c) 2012 Chris Shanley. All rights reserved.
//

#import "LocalRequest.h"

@interface LocalRequest()
{
    Database *dbRef;
    BOOL success;
}

-(void)executeSelectQuery;
-(void)executeActionQuery;
-(void)queryThreadComplete;

@end

@implementation LocalRequest


@synthesize requestName;
@synthesize requestCompleteBlock;
@synthesize requestResults;

-(id)initWithQuery:(NSString *)value
{
    self = [super init];
    
    if( self != nil)
    {
        query   = value;
        success = NO;
    }
    return self;
}

-(void)runSelectWithBlock:(LocalRequestCompleteBlock )block inDatabase:(Database *)db
{
    self.requestCompleteBlock = block;
    
    LocalRequest __block *weakself = self;
    dbRef = db;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^
    {
        [weakself executeSelectQuery];
    });
}

-(void)executeWithBlock:(LocalRequestCompleteBlock )block inDatabase:(Database *)db
{
    self.requestCompleteBlock = block;
    
    LocalRequest __block *weakself = self;
    dbRef = db;
    dispatch_async(dispatch_get_global_queue(0, 0), ^
    {
        [weakself executeActionQuery];
    });
}

-(void)executeActionQuery
{
    success = [dbRef runInsert:query];
    LocalRequest __block *weakself = self;
    dispatch_async(dispatch_get_main_queue(), ^
    {
       [weakself queryThreadComplete];
    });
}

-(void)executeSelectQuery
{
    self.requestResults = [dbRef runSelect:query];
    
    if( self.requestResults != nil )
    {
        success = YES;
    }
        
    LocalRequest __block *weakself = self;
    dispatch_async(dispatch_get_main_queue(), ^
    {
        [weakself queryThreadComplete];
    });
}

-(void)queryThreadComplete
{
    self.requestCompleteBlock(success);
}

@end
