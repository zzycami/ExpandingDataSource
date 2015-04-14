//
//  ExpandingDataSource.m
//  ExpandingDataSource
//
//  Created by damingdan on 15/4/13.
//  Copyright (c) 2015年 kuteng. All rights reserved.
//

#import "ExpandingDataSource.h"

@interface ExpandingDataSource ()
@property (nonatomic) NSIndexPath *expandingIndexPath;
@property (nonatomic) NSIndexPath *expandedIndexPath;
@end

@implementation ExpandingDataSource
@synthesize expandedIndexPath = _expandedIndexPath;
@synthesize expandingIndexPath = _expandingIndexPath;

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.expandedIndexPath) {
        return [self expandingTableView:tableView numberOfRowsInSection:section] + 1;
    }
    return [self expandingTableView:tableView numberOfRowsInSection:section];
}

- (NSInteger) expandingTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath isEqual:self.expandedIndexPath]) {
        return [self expandedTableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[indexPath row] - 1 inSection:[indexPath section]]];
    }else {
        return [self expandingTableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell*) expandingTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)expandingIndexPath {
    return nil;
}

- (UITableViewCell*) expandedTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)expandedIndexPath {
    return nil;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // disable touch on expanded cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.reuseIdentifier isEqualToString:ExpandedCellIdentifier]) {
        [self expandedTableView:tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:[indexPath row] - 1 inSection:[indexPath section]]];
        return;
    }
    // deselect row
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // get the actual index path
    indexPath = [self actualIndexPathForTappedIndexPath:indexPath];
    
    // save the expanded cell to delete it later
    NSIndexPath *theExpandedIndexPath = self.expandedIndexPath;
    
    if ([indexPath isEqual:self.expandingIndexPath]) {
        self.expandingIndexPath = nil;
        self.expandedIndexPath = nil;
    }else {
        // add the expanded cell
        self.expandingIndexPath = indexPath;
        self.expandedIndexPath = [NSIndexPath indexPathForRow:[indexPath row] + 1 inSection:[indexPath section]];
    }
    
    [tableView beginUpdates];
    
    if (theExpandedIndexPath) {
        [tableView deleteRowsAtIndexPaths:@[theExpandedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    if (self.expandedIndexPath) {
        [tableView insertRowsAtIndexPaths:@[self.expandedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    [tableView endUpdates];
    
    // scroll to the expanded cell
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    // trigger the normal select event
    [self expandingTableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (NSIndexPath *)actualIndexPathForTappedIndexPath:(NSIndexPath *)indexPath {
    if (self.expandedIndexPath && [indexPath row] > [self.expandedIndexPath row]) {
        return [NSIndexPath indexPathForRow:[indexPath row] - 1 inSection:[indexPath section]];
    }
    return indexPath;
}

- (void) expandingTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void) expandedTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
