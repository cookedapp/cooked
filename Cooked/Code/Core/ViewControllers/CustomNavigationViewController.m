//
//  CustomNavControllerViewController.m
//  StoryTBD
//
//  Created by chrisshanley on 11/3/12.
//  Copyright (c) 2012 chrisshanley. All rights reserved.
//

#import "CustomNavigationViewController.h"

@interface CustomNavigationViewController ()

@end

@implementation CustomNavigationViewController


-(id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}
@end
