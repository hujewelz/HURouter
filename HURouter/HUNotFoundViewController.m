//
//  HUNotFoundViewController.m
//  HURouter
//
//  Created by jewelz on 16/6/2.
//  Copyright © 2016年 hujewelz. All rights reserved.
//

#import "HUNotFoundViewController.h"

@interface HUNotFoundViewController ()

@end

@implementation HUNotFoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupView];
}

- (void)setupView {
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = @"Page Not Found";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
