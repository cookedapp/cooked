//
//  CustomCell.m
//  StoryTBD
//
//  Created by chrisshanley on 8/30/12.
//  Copyright (c) 2012 chrisshanley. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize indexPath, info;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)renderCell
{
    
}

@end
