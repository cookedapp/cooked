//
//  ImageLoader.m
//  StoryTBD
//
//  Created by chrisshanley on 10/27/12.
//  Copyright (c) 2012 chrisshanley. All rights reserved.
//

#import "ImageLoader.h"
#import "NetworkUtils.h"
@interface ImageLoader()
{
    BOOL isRetina;
}

-(BOOL)imageExistLocally;
-(void)loadimageFromDisc;
-(void)loadImageFromWeb;
-(void)imageLoadedFromDisc:(NSData *)data;
-(void)imageLoadedFromWeb:(UIImage *)img;
-(void)saveImageToDisc;
-(void)makeImageNameRetina;
-(void)makeImageNonRetinaName;
@end

@implementation ImageLoader

@synthesize imageName, block, saveToDisc, image;

-(id)initWithImageNamed:(NSString *)name
{
    self = [super init];
    self.imageName = name; 
    isRetina = [[UIScreen mainScreen] scale] == 2.0 ? YES : NO;
    
    if( isRetina && [self imageExistLocally] == NO )
    {
        [self makeImageNameRetina];
    }
    
    return self;
}

-(void)makeImageNonRetinaName
{
    NSString *nonretina = @".";
    NSString *name  = [self.imageName stringByReplacingOccurrencesOfString:@"@2x." withString:nonretina ];
    self.imageName = name;
}

-(void)makeImageNameRetina
{
    NSString *retina = @"@2x.";
    NSString *split  = [self.imageName stringByReplacingOccurrencesOfString:@"." withString:retina ];
    self.imageName = split;
}

-(void)loadImage:( LoadingBlock )blockRef
{
    self.block = blockRef;
    if( [self imageExistLocally] )
    {
        [self loadimageFromDisc];
    }
    else
    {
        if( [NetworkUtils shareNetworkUtils].hasNetworkConnection )
        {
            [self loadImageFromWeb];
        }
    }
}



-(BOOL)imageExistLocally
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *tempFile      = [documentsPath stringByAppendingPathComponent:self.imageName];
    return  [[NSFileManager defaultManager]fileExistsAtPath:tempFile];
}

-(void)loadimageFromDisc
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    __block ImageLoader *blockSelf = self;
 
    __block NSString    *blockName = self.imageName;
    dispatch_async(queue, ^{
        
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *tempFile      = [documentsPath stringByAppendingPathComponent:blockName];
        
        NSData *data = [[NSFileManager defaultManager]contentsAtPath:tempFile];
        
        dispatch_sync(dispatch_get_main_queue(), ^
        {
            [blockSelf imageLoadedFromDisc:data];
        });
    });
    
}

-(void)loadImageFromWeb
{
    NSString *serverPath = nil;
    
    
    
    NSString *server     = [[NSUserDefaults standardUserDefaults]valueForKey:serverPath];
    __block NSString *urlString  = [NSString stringWithFormat:@"%@%@%@", server, @"/videos/images/", self.imageName];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    
    __block ImageLoader *blockSelf = self;
    
    AFImageRequestOperation *op = [[AFImageRequestOperation alloc]initWithRequest:request];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        [blockSelf imageLoadedFromWeb:responseObject];  
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"%@ , error loading image from web : %@ ", self , urlString);
    }];
    [op start];
}

-(void)imageLoadedFromWeb:(UIImage *)img
{
    self.image = img;
    self.block( YES );
    __block ImageLoader *blockSelf = self;
    
    NSLog(@"%@ image loaded from web ", self );
    
    if( self.saveToDisc == YES )
    {
        dispatch_queue_t queue  = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue , ^
        {
            [blockSelf saveImageToDisc];
        });
    }

}

-(void)imageLoadedFromDisc:(NSData *)data
{
    self.image = [UIImage imageWithData:data scale:[[UIScreen mainScreen] scale]];
    NSLog(@"%@ image loaded from disc : %@ ", self , self.imageName );
    self.block( YES );
}

-(void)saveImageToDisc
{
    if( isRetina )
    {
        [self makeImageNonRetinaName];
    }
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *tempFile      = [documentsPath stringByAppendingPathComponent:self.imageName];
    NSData  *imageData      = UIImageJPEGRepresentation(self.image, 1);
    BOOL success            = [[NSFileManager defaultManager]createFileAtPath:tempFile contents:imageData attributes:nil];
    
    if( success )
    {
        
    }
    else
    {
        NSLog(@"%@ , image failed to save to disc", self );
    }
}

-(void)imageFailedToLoad
{
 //   NSString    *msg   = @"Sorry there was an error loading images"
 //  UIAlertView *alert = [[ UIAlertView alloc]initWithTitle:@"Error" message:<#(NSString *)#> delegate:<#(id)#> cancelButtonTitle:<#(NSString *)#> otherButtonTitles:<#(NSString *), ...#>, nil]
}

@end
