//
//  DynamicTable.h
//  StoryTBD
//
//  Created by chrisshanley on 8/30/12.
//  Copyright (c) 2012 chrisshanley. All rights reserved.
//

@class DynamicTable;
@class CustomCell;
@protocol DynamicTableProtocal <NSObject>

@required
    -(void)tabel:(DynamicTable *)table selectedCell:(CustomCell *)cell;
@optional
    //
@end

#import <UIKit/UIKit.h>
#import "CustomCell.h"

@interface DynamicTable : UITableView<UITableViewDataSource, UITableViewDelegate>
{
    __weak id<DynamicTableProtocal> tableDelegate;

    NSDictionary *tableData;
    NSString     *cellType;
}

-(id)initWithTableData:(NSDictionary *)info andFrame:(CGRect)rect;

@property(nonatomic, strong)NSString     *cellType;
@property(nonatomic, strong)NSDictionary *tableData;
@property(nonatomic, weak)id<DynamicTableProtocal> tableDelegate;
@end
