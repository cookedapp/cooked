//  Created by Chris Shanley on 12/19/12.
//  Copyright (c) 2012 Chris Shanley. All rights reserved.
//

#import "RequestCue.h"
@interface RequestCue()
{
    
}
-(void)requestComplete;
-(void)cueComplete;

@end


@implementation RequestCue

@synthesize cueCompleteBlock, requests;

-(id)initWithRequests:(NSArray *)array returnOneResponse:(BOOL)value completeBlock:(CueCompeteBlock)block
{
    self = [super init];
    if( self )
    {
        self.requests         = array;
        self.cueCompleteBlock = block;
        requestIndex          = 0;
        returnOneResult       = value;
        allResults            = [[NSMutableDictionary alloc]init];
    }
    return  self;
}


-(void)runQue
{
    currentRequst = [self.requests objectAtIndex:requestIndex];
    RequestCue __weak *weakRef = self;
    
    [currentRequst executeWithBlock:^(BOOL success)
    {
        [weakRef requestComplete];
        
    } inDatabase:nil];
}

-(void)requestComplete
{
    [allResults setValue:currentRequst.requestResults forKey:currentRequst.requestName];
    
    if( returnOneResult == NO )
    {
        currentRequst.requestCompleteBlock(YES);
    }
   
    
    if( requestIndex == [self.requests count]-1 )
    {
        [self cueComplete];
    }
    else
    {
        requestIndex++;
        [self runQue];
    }
}

-(void)cueComplete
{
    self.cueCompleteBlock(YES , allResults);
}


@end
