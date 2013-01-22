//
//  LoadingView.m
//  StoryTBD
//
//  Created by chrisshanley on 10/31/12.
//  Copyright (c) 2012 chrisshanley. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

@synthesize spinner;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [ self setBackgroundColor: [ UIColor colorWithRed:0 green:0 blue:0 alpha:0.7 ] ];
        
        self.spinner = [[ UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        
        [ self.spinner setCenter:self.center ];
        [ self addSubview:self.spinner ];
        [ self.spinner startAnimating ];
    }
    return self;
}



@end
