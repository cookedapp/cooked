//
//  MediaPlayerViewController.m
//  StoryTBD
//
//  Created by chrisshanley on 9/15/12.
//  Copyright (c) 2012 chrisshanley. All rights reserved.
//

#import "MediaPlayerViewController.h"

@interface MediaPlayerViewController ()

-(void)videoFrameLoaded:(NSNotification *)note;
-(void)videoEnded:(NSNotification *)note;
-(void)movieTimeReady:(NSNotification *)note;
-(void)movieValidated:(NSNotification *)note;

@end

@implementation MediaPlayerViewController


@synthesize movieDelegate;

-(id)initWithContentURL:(NSURL *)contentURL
{
    self = [super initWithContentURL:contentURL];
    if( self )
    {
    }
    return  self;
}

-(void)registerEvents
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [ center addObserver:self selector:@selector(videoFrameLoaded:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil ];
    [ center addObserver:self selector:@selector(videoEnded:)          name:MPMoviePlayerPlaybackDidFinishNotification              object:nil ];
    [ center addObserver:self selector:@selector(videoEnded:)          name:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey         object:nil ];
    [ center addObserver:self selector:@selector(movieTimeReady:)      name:MPMovieDurationAvailableNotification                    object:nil ];
    [ center addObserver:self selector:@selector(movieValidated:)      name:MPMoviePlayerLoadStateDidChangeNotification             object:nil ];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)videoFrameLoaded:(NSNotification *)note
{
    UIImage *image = [[note userInfo ]valueForKey:MPMoviePlayerThumbnailImageKey];
    [self.movieDelegate videoThumbLoaded:image];
}

-(void)videoEnded:(NSNotification *)note
{
    [self.movieDelegate videoComplete];
}

-(void)movieTimeReady:(NSNotification *)note
{
    
    NSNotificationCenter    *center      = [NSNotificationCenter defaultCenter];
    NSArray                 *array       = [NSArray arrayWithObject:[ NSNumber numberWithDouble:0.2] ];
    [center removeObserver:self name:MPMovieDurationAvailableNotification object:nil];
    [self.moviePlayer requestThumbnailImagesAtTimes:array timeOption:MPMovieTimeOptionNearestKeyFrame ];
}

-(void)movieValidated:(NSNotification *)note
{
    [self.movieDelegate videoReadyToPlay];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
