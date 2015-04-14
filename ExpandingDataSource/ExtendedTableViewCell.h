//
//  ExtendedTableViewCell.h
//  ExpandingDataSource
//
//  Created by damingdan on 15/4/13.
//  Copyright (c) 2015年 kuteng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExtendedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *buttonLeft;
@property (weak, nonatomic) IBOutlet UIButton *buttonRight;

@property (copy, nonatomic) void (^onLeftButtonClicked)();
@property (copy, nonatomic) void (^onRightButtonClicked)();
@end
