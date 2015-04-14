//
//  ExtendedTableViewCell.m
//  ExpandingDataSource
//
//  Created by damingdan on 15/4/13.
//  Copyright (c) 2015年 kuteng. All rights reserved.
//

#import "ExtendedTableViewCell.h"

@implementation ExtendedTableViewCell
@synthesize onLeftButtonClicked = _onLeftButtonClicked;
@synthesize onRightButtonClicked = _onRightButtonClicked;

- (void)awakeFromNib {
    // Initialization code
}


- (IBAction)onButtonLeftClick:(id)sender {
    if (self.onLeftButtonClicked) {
        self.onLeftButtonClicked();
    }
}


- (IBAction)onButtonRightClick:(id)sender {
    if (self.onRightButtonClicked) {
        self.onRightButtonClicked();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
