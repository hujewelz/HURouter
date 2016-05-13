//
//  ViewController.m
//  HURouter
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 hujewelz. All rights reserved.
//

#import "ViewController.h"
#import "HURouter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *s = @"/www.a.com/b/c?id=1&name=a";
    NSURL *url = [NSURL URLWithString:s];

    NSLog(@"\nscheme:%@\n host:%@\n path:%@\n parameterString:%@\n query:%@\n relativePath:%@",url.scheme, url.host, url.path,url.parameterString,url.query,url.relativePath);
    NSLog(@"pathComponents:%@", url.pathComponents);
    
        
}

- (void)viewDidAppear:(BOOL)animated {
    //NSLog(@"vc: %@", [HURouter shared].presentingViewController);
    //    NSLog(@"visibleViewController: %@",self.navigationController.visibleViewController);
    //    NSLog(@"presentedViewController: %@",self.presentedViewController);
    //    NSLog(@"presentingViewController: %@",self.presentingViewController);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
