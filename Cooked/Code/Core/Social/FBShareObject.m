//
//  FBShareObject.m
//  FunRun
//
//  Created by Chris Shanley on 1/14/13.
//  Copyright (c) 2013 Chris Shanley. All rights reserved.
//

#import "FBShareObject.h"

@implementation FBShareObject

@synthesize caption,description,link, name ,picture;

-(id)init
{
    self = [super init];
    if( self != nil  )
    {
        
    }
    return self;
}


-(id)initWithLink:(NSString *)url imagePath:(NSString *)imgPath postName:(NSString *)postname caption:(NSString *)postcaption description:(NSString *)postdescription
{
    self = [super init];
    if( self != nil  )
    {
        self.link        = url;
        self.picture     = imgPath;
        self.name        = postname;
        self.caption     = postcaption;
        self.description = postdescription;
    }
    return self;
}


-(NSDictionary *)toDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
[dict setValue:self.picture     forKey:@"picture"];
    [dict setValue:self.name        forKey:@"name"];
    [dict setValue:self.description forKey:@"description"];
    [dict setValue:self.caption     forKey:@"caption"];
    [dict setValue:self.description forKey:@"description"];
 
    return  dict;
}

@end
