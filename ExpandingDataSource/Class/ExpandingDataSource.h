//
//  ExpandingDataSource.h
//  ExpandingDataSource
//
//  Created by damingdan on 15/4/13.
//  Copyright (c) 2015年 kuteng. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  The main cell identifier, you should set the cell identifier to this
 */
static NSString* ExpandingCellIdentifier = @"ExpandingCellIdentifier";

/**
 *  The expending cell identifier, you should set the expending cell identifier to this
 */
static NSString* ExpandedCellIdentifier = @"ExpandedCellIdentifier";

/**
 *  If you want your table view have a expend view. you can extends @c ExpandingDataSource, This class finished all the expend logical, you can just care about the appearence and event of your main cell and expend cell.
 */
@interface ExpandingDataSource : NSObject<UITableViewDataSource, UITableViewDelegate>
/**
 *  The same function to tableView:numberOfRowsInSection:, but you should implement expandingTableView:numberOfRowsInSection: instead of the normal one
 *
 *  @param tableView
 *  @param section
 *
 *  @return
 */
- (NSInteger) expandingTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

/**
 *  The same function to tableView:cellForRowAtIndexPath:, but you should implement this to return a expanding @c UITableViewCell
 *
 *  @param tableView
 *  @param expandingIndexPath
 *
 *  @return a expanding UITableViewCell, the main one
 */
- (UITableViewCell*) expandingTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) expandingIndexPath;

/**
 *  to see expandingTableView:cellForRowAtIndexPath. This is for the expended one
 *
 *  @param tableView
 *  @param expandedIndexPath
 *
 *  @return a expanded @c UITabelViewCell
 */
- (UITableViewCell*) expandedTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) expandedIndexPath;

/**
 *  Delegate to call when select the expanding cell
 *
 *  @param tableView
 *  @param indexPath
 */
- (void) expandingTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Delegate to call when select the expanded cell
 *
 *  @param tableView
 *  @param indexPath
 */
- (void) expandedTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end