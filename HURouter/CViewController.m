//
//  CViewController.m
//  HURouter
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 hujewelz. All rights reserved.
//

#import "CViewController.h"
#import "HURouter.h"

@implementation CViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


}

- (void)viewDidAppear:(BOOL)animated {
   // NSLog(@"vc: %@", [HURouter shared].presentingViewController);
//    NSLog(@"visibleViewController: %@",self.navigationController.visibleViewController);
//    NSLog(@"presentedViewController: %@",self.presentedViewController);
//    NSLog(@"presentingViewController: %@",self.presentingViewController);
    
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
