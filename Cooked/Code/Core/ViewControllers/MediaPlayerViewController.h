//
//  MediaPlayerViewController.h
//  StoryTBD
//
//  Created by chrisshanley on 9/15/12.
//  Copyright (c) 2012 chrisshanley. All rights reserved.
//

@protocol MoviePlayerDelegate <NSObject>

-(void)videoReadyToPlay;
-(void)videoComplete;
-(void)videoCanceled;
-(void)videoThumbLoaded:(UIImage *)image;

@end

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MediaPlayerViewController : MPMoviePlayerViewController
{
    __weak id<MoviePlayerDelegate> movieDelegate;
}

-(void)registerEvents;

@property(nonatomic, weak)id<MoviePlayerDelegate> movieDelegate;


@end
