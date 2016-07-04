//
//  BViewController.m
//  HURouter
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 hujewelz. All rights reserved.
//

#import "BViewController.h"
#import "UIViewController+router.h"
#import "HURouter.h"

@implementation BViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"vc: %@", [HURouter shared].currentViewController);
    self.title = self.param[@"name"];
}



@end
