//
//  FBShareObject.h
//  FunRun
//
//  Created by Chris Shanley on 1/14/13.
//  Copyright (c) 2013 Chris Shanley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBShareObject : NSObject
{
    NSMutableDictionary *post;
}


-(id)init;
-(id)initWithLink:(NSString *)link imagePath:(NSString *)imgPath postName:(NSString *)name caption:(NSString *)caption description:(NSString *)description;
-(NSDictionary *)toDictionary;


@property(nonatomic, strong)NSString *link;
@property(nonatomic, strong)NSString *picture;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *caption;
@property(nonatomic, strong)NSString *description;



/*
[[NSMutableDictionary alloc] initWithObjectsAndKeys:
 @"https://developers.facebook.com/ios", @"link",
 @"https://developers.facebook.com/attachment/iossdk_logo.png", @"picture",
 @"Facebook SDK for iOS", @"name",
 @"Build great social apps and get more installs.", @"caption",
 @"The Facebook SDK for iOS makes it easier and faster to develop Facebook integrated iOS apps.", @"description",
 nil];*/
@end
