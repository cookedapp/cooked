//
//  EHDatabase.h
//  EHLib
//
//  Created by Chris Shanley on 1/4/13.
//  Copyright (c) 2013 Chris Shanley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>



@interface Database : NSObject
{
    sqlite3 *database;
}




+(Database *)sharedDatabase;

-(NSArray *)runSelect:(NSString *)query;
-(BOOL)runInsert:(NSString *)query;
-(void)close;

@end
