//
//  EHDatabase.m
//  EHLib
//
//  Created by Chris Shanley on 1/4/13.
//  Copyright (c) 2013 Chris Shanley. All rights reserved.
//

#import "Database.h"
#import "Config.h"

@interface Database()
{
    NSString *dbPath;
    sqlite3_stmt *statement;
}
-(void)debugMethodListTables;
-(id)init;
-(void)loadFile;


@end





@implementation Database


+(Database *)sharedDatabase
{
    static dispatch_once_t onceToken;
    static Database *instance;
    
    dispatch_once(&onceToken, ^
    {
        instance = [[Database alloc]init];
    });
    
    return instance;
}

-(id)init
{
    self = [super init];
    
    if( self != nil )
    {
        [self loadFile];
        
        database = NULL;
        int success = sqlite3_open([dbPath UTF8String], &database);
        
        if( success == SQLITE_OK )
        {
            statement = nil;
        }
        else
        {
            NSLog(@"%@ error opening db file %s ", self, sqlite3_errmsg(database));
        }
        [self debugMethodListTables];
    }
    
    return self;
}


-(void)loadFile
{
    NSFileManager *fileManager  = [NSFileManager defaultManager];
    NSError       *error;
    NSArray       *paths        = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString      *docs         = [paths objectAtIndex:0];
    NSString      *writePath    = [docs stringByAppendingFormat:@"/%@", DBName];
    NSString      *resourcePath = nil;
    
    BOOL exists = [fileManager fileExistsAtPath:writePath];
    BOOL writeSuccess = NO;
    
    if( exists )
    {
        NSLog(@"%@ , db exists at %@ ", self, writePath );
    }
    else
    {
        resourcePath = [[[NSBundle mainBundle]resourcePath]stringByAppendingFormat:@"/%@", DBName];
        writeSuccess = [fileManager copyItemAtPath:resourcePath toPath:writePath error:&error];
        if( writeSuccess == NO)
        {
            NSLog(@"%@ , unable to write db to %@ ", self, writePath );
        }
        else
        {
            NSLog(@"%@ , do written to %@ ", self, writePath );
        }
    }
    
    dbPath = writePath;
}

-(NSArray *)runSelect:(NSString *)query
{
    sqlite3_reset(statement);
    
    const char *sql    = [query UTF8String];
    int statementReady = sqlite3_prepare_v2(database, sql, -1, &statement, NULL);
    int count          = 0;
    
    NSMutableArray      *queryResults = [NSMutableArray array];
    NSMutableDictionary *resultRow    = nil;
    
    if(statementReady == SQLITE_OK)
    {
        while( sqlite3_step(statement) == SQLITE_ROW )
        {
            resultRow = [NSMutableDictionary dictionary];
            count     = sqlite3_column_count(statement);
            for(int i = 0; i < count; i++ )
            {
                NSString *name  = [NSString stringWithUTF8String: sqlite3_column_name(statement, i)];
                NSString *value = [NSString stringWithUTF8String: (char *)sqlite3_column_text(statement, i)];
                [resultRow setValue:value forKey:name];
            }
            [queryResults addObject:resultRow];
        }
    }
    else
    {
        NSLog(@"%@ failed to prepare statement %s ", self , sqlite3_errmsg(database));
    }
    
    NSLog(@"%@, runSelect complete " , self );
    
    return queryResults;
}

-(BOOL)runInsert:(NSString *)query
{
    
    sqlite3_reset(statement);
    
    BOOL success       = NO;
    const char *sql    = [query UTF8String];
    int statementReady = sqlite3_prepare_v2(database, sql, -1, &statement, NULL);
    
    if( statementReady == SQLITE_OK )
    {
        if(sqlite3_step(statement) == SQLITE_DONE )
        {
            success = YES;
        }
        else
        {
            // add logic for insert failing 
        }
    }
    else
    {
        NSLog(@"%@ failed to prepare statement %s ", self , sqlite3_errmsg(database));
        success = statementReady;
    }
    
    sqlite3_reset(statement);
    
    return  success;
}

-(void)debugMethodListTables
{
    sqlite3_reset(statement);
    // add debug code to print table names
    sqlite3_reset(statement);
}

-(void)close
{
    sqlite3_close(database);
}

@end
