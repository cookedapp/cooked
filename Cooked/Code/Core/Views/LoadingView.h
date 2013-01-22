//
//  LoadingView.h
//  StoryTBD
//
//  Created by chrisshanley on 10/31/12.
//  Copyright (c) 2012 chrisshanley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView
{
    UIActivityIndicatorView *spinner;
}

@property(nonatomic, strong)UIActivityIndicatorView *spinner;
@end
