//
//  TestDataSource.m
//  ExpandingDataSource
//
//  Created by damingdan on 15/4/13.
//  Copyright (c) 2015年 kuteng. All rights reserved.
//

#import "TestDataSource.h"
#import "ExtendedTableViewCell.h"

@interface TestDataSource ()
@property(nonatomic, retain) NSArray* dataSource;

@end

@implementation TestDataSource
@synthesize dataSource = _dataSource;

- (NSArray*) dataSource {
    if (!_dataSource) {
        _dataSource = @[@"Test1", @"Test2", @"Test3", @"Test4", @"Test5", @"Test6", @"Test7", @"Test8"];
    }
    return _dataSource;
}

- (NSInteger) expandingTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell*) expandingTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)expandingIndexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ExpandingCellIdentifier];
    cell.textLabel.text = self.dataSource[expandingIndexPath.row];
    return cell;
}

- (UITableViewCell*) expandedTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)expandedIndexPath {
    ExtendedTableViewCell* cell = (ExtendedTableViewCell*)[tableView dequeueReusableCellWithIdentifier:ExpandedCellIdentifier];
    cell.onLeftButtonClicked = ^() {
        
        NSLog(@"clicked left button at row:%d", (int)expandedIndexPath.row);
    };
    
    cell.onRightButtonClicked = ^() {
        NSLog(@"clicked right button at row:%d", (int)expandedIndexPath.row);
    };
    return cell;
}

- (CGFloat) expandedTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat) expandingTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void) tableView:(UITableView *)tableView didExpandedRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"expand row at %d", indexPath.row);
}

- (void) tableView:(UITableView *)tableView didShrinkedRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"shrink row at %d", indexPath.row);
}


@end
