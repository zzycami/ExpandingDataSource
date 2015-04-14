//
//  ViewController.m
//  ExpandingDataSource
//
//  Created by damingdan on 15/4/13.
//  Copyright (c) 2015年 kuteng. All rights reserved.
//

#import "ViewController.h"
#import "TestDataSource.h"

@interface ViewController ()
@property(nonatomic, retain) TestDataSource* testDataSource;
@end

@implementation ViewController
@synthesize testDataSource = _testDataSource;

- (TestDataSource*) testDataSource {
    if (!_testDataSource) {
        _testDataSource = [[TestDataSource alloc] init];
    }
    return _testDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self.testDataSource;
    self.tableView.dataSource = self.testDataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
