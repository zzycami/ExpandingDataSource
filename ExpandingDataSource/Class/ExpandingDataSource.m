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
    NSInteger expandingCount = [self expandingTableView:tableView numberOfRowsInSection:section];
    if (expandingCount == 0) {
        // If the list is empty, the expanded item is no longer exist.
        return 0;
    }
    if (self.expandedIndexPath) {
        return expandingCount + 1;
    }
    return expandingCount;
}

- (NSInteger) expandingTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // When table view delete the last item, should update the expanded index path
    NSInteger expandingCount = [self expandingTableView:tableView numberOfRowsInSection:indexPath.section];
    if (self.expandedIndexPath.row > expandingCount) {
        self.expandedIndexPath = [NSIndexPath indexPathForRow:expandingCount inSection:[indexPath section]];
        self.expandingIndexPath = [NSIndexPath indexPathForRow:expandingCount - 1 inSection:[indexPath section]];
    }
    
    if ([indexPath isEqual:self.expandedIndexPath]) {
        return [self expandedTableView:tableView cellForRowAtIndexPath:self.expandingIndexPath];
    }else {
        indexPath = [self actualIndexPathForTappedIndexPath:indexPath];
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
        if ([self respondsToSelector:@selector(expandedTableView:didSelectRowAtIndexPath:)]) {
            [self expandedTableView:tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:[indexPath row] - 1 inSection:[indexPath section]]];
        }
        return;
    }
    // deselect row
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // get the actual index path
    indexPath = [self actualIndexPathForTappedIndexPath:indexPath];
    
    // save the expanded cell to delete it later
    NSIndexPath *theExpandedIndexPath = self.expandedIndexPath;
    NSIndexPath *theExpandingIndexPath = self.expandingIndexPath;
    
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
        if ([self respondsToSelector:@selector(tableView:didShrinkedRowCell:)]) {
            UITableViewCell* expandingCell = [tableView cellForRowAtIndexPath:theExpandingIndexPath];
            if (expandingCell && [expandingCell.reuseIdentifier isEqualToString:ExpandingCellIdentifier]) {
                [self tableView:tableView didShrinkedRowCell:expandingCell];
            }
        }
        [tableView deleteRowsAtIndexPaths:@[theExpandedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }
    if (self.expandedIndexPath) {
        if ([self respondsToSelector:@selector(tableView:didExpandedRowAtCell:)]) {
            //UITableViewCell* expandingCell = [tableView cellForRowAtIndexPath:self.expandingIndexPath];
            if (cell && [cell.reuseIdentifier isEqualToString:ExpandingCellIdentifier]) {
                [self tableView:tableView didExpandedRowAtCell:cell];
            }
        }
        [tableView insertRowsAtIndexPaths:@[self.expandedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    [tableView endUpdates];
    
    // scroll to the expanded cell
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    // trigger the normal select event
    if ([self respondsToSelector:@selector(expandingTableView:didSelectRowAtIndexPath:)]) {
        [self expandingTableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (NSIndexPath *)actualIndexPathForTappedIndexPath:(NSIndexPath *)indexPath {
    if (self.expandedIndexPath && [indexPath row] > [self.expandedIndexPath row]) {
        return [NSIndexPath indexPathForRow:[indexPath row] - 1 inSection:[indexPath section]];
    }
    return indexPath;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath isEqual:self.expandedIndexPath]) {
        return [self expandedTableView:tableView heightForRowAtIndexPath:indexPath];
    }else {
        return [self expandingTableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (CGFloat) expandedTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat) expandingTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
@end
