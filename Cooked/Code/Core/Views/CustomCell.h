//
//  CustomCell.h
//  StoryTBD
//
//  Created by chrisshanley on 8/30/12.
//  Copyright (c) 2012 chrisshanley. All rights reserved.
//
@class CustomCell;
@protocol CustomCellDelegate <NSObject>

-(void)customCell:(CustomCell *) selectedWithInfo:(NSDictionary *)info;

@end


#import <UIKit/UIKit.h>


@interface CustomCell : UITableViewCell
{
    NSDictionary *info;
    NSIndexPath   *indexPath;
}

-(void)renderCell;

@property(nonatomic,  strong)NSIndexPath   *indexPath;
@property(nonatomic , strong)NSDictionary *info;
@end
