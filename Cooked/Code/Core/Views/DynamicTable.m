//
//  DynamicTable.m
//  StoryTBD
//
//  Created by chrisshanley on 8/30/12.
//  Copyright (c) 2012 chrisshanley. All rights reserved.
//

#import "DynamicTable.h"

@implementation DynamicTable


@synthesize tableDelegate;
@synthesize tableData;
@synthesize cellType;

-(id)initWithTableData:(NSDictionary *)info andFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if( self)
    {
        self.rowHeight  = 60;
        self.tableData  = info;
        self.dataSource = self;
        self.delegate   = self;
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sections = [self.tableData valueForKey:@"sections"];
    NSArray *rows     = [[sections objectAtIndex:section] valueForKey:@"cells"];
    return  [rows count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray *sections = [self.tableData valueForKey:@"sections"];
    return [sections count];
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.rowHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuse    = @"cell";
    NSDictionary    *section  = [[self.tableData valueForKey:@"sections"] objectAtIndex:indexPath.section];
    NSArray         *rows     = [section valueForKey:@"cells"];
    
    CustomCell *cell        = [self dequeueReusableCellWithIdentifier:reuse];
    
    if( cell == nil )
    {
        cell = [[NSClassFromString(self.cellType) alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableDelegate tabel:self selectedCell:(CustomCell *)[self cellForRowAtIndexPath:indexPath]];
}


@end
