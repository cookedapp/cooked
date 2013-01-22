
//  Created by Chris Shanley on 12/19/12.
//  Copyright (c) 2012 Chris Shanley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocalRequest.h"


typedef void (^CueCompeteBlock) (BOOL success, id results);

@interface RequestCue : NSObject
{
    
    NSArray         *requests;
    int             requestIndex;
    BOOL            returnOneResult;
    NSMutableDictionary    *allResults;
    CueCompeteBlock cueCompleteBlock;
    LocalRequest  *currentRequst;
}

-(id)initWithRequests:(NSArray *)array returnOneResponse:(BOOL)value completeBlock:(CueCompeteBlock)block;
-(void)runQue;

@property(nonatomic, copy)CueCompeteBlock cueCompleteBlock;
@property(nonatomic, strong)NSArray *requests;
@end
