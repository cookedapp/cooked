//
//  EHLocalRequest.h
//  EHLib
//
//  Created by Chris Shanley on 12/19/12.
//  Copyright (c) 2012 Chris Shanley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Database.h"

typedef void (^LocalRequestCompleteBlock) (BOOL success);


/* TODO : implement state managment and property for request objects 
 */
typedef enum EHRequestType
{
    kSelect,
    kInsert,
    kUpdate,
    kDelete
    
}EHRequestType;

@interface LocalRequest : NSObject
{
    NSString *query;
    NSString *requestName;
    BOOL      runPostSelect;
}



/* METHOD : initWithQuery:(NSString *)value - crates a new instance
 * @param value : the sql string, all dynamic values must be in place
 */
-(id)initWithQuery:(NSString *)value;



/* METHOD : runSelectWithBlock:(LocalRequestCompleteBlock )block inDatabase:(EHDatabase *)db - does a select query on the DB, get the results form @property requestResults
 * @param block : the completion block, only reports a success or fail, if success, access data via requestResults
 * @param db    : an instanace to the DB that has the query code, must extend EHDatabase.h , see EHDatabase for required methods
 */
-(void)runSelectWithBlock:(LocalRequestCompleteBlock )block inDatabase:(Database *)db;



/* METHOD : executeWithBlock:(LocalRequestCompleteBlock )block inDatabase:(EHDatabase *)db - used for a update, insert or delete call
 * @param block : the completion block, only reports a success or fail, if success, @property requestResults is not set
 * @param db    : an instanace to the DB that has the query code, must extend EHDatabase.h , see EHDatabase for required methods
 */
-(void)executeWithBlock:(LocalRequestCompleteBlock )block  inDatabase:(Database *)db;


/* PROPERTY : requestName - used when using object in a EHRequestQue, name is use for the dictionary key in the que results
 * example
 * NSArray *array = [someQueObject valueforKey:request.requestName];
 */
@property(nonatomic, strong) NSString                  *requestName;

/* PROPERTY : requestResults - set before the complete block is called, formatted as array but otherwise typed for id for other uses
 */
@property(nonatomic, strong) id                         requestResults;

/* PROPERTY : requestCompleteBlock - called when request is completed, only sends back a success or fail BOOL, developers now have access to requestResults object
 */
@property(nonatomic, copy  ) LocalRequestCompleteBlock  requestCompleteBlock;

@end
