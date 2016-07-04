//
//  ViewController.m
//  HURouter
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 hujewelz. All rights reserved.
//

#import "ViewController.h"
#import "HURouter.h"
#import "HUWebViewController.h"
#import "BViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *s = @"http://www.a.com/b/c?id=1&name=a";
    NSURL *url = [NSURL URLWithString:s];

    NSLog(@"\nscheme:%@\n host:%@\n path:%@\n parameterString:%@\n query:%@\n relativePath:%@",url.scheme, url.host, url.path,url.parameterString,url.query,url.relativePath);
    NSLog(@"pathComponents:%@", url.pathComponents);
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)push:(id)sender {
    //传统页面跳转方式
//    BViewController *bVC = [[BViewController alloc] init];
//    [bVC setValue:@{@"name":@"b"} forKey:@"param"];
//    [self.navigationController pushViewController:bVC animated:YES];
    
    [[HURouter shared] route:@"bb?name=b" withPresentType:HUPresentTypePush];
    
}

- (IBAction)loadweb:(id)sender {
    //传统页面跳转方式
//    HUWebViewController *webviewVc = [[HUWebViewController alloc] init];
//    webviewVc.url = [NSURL URLWithString:@"https://www.baidu.com"];
//    [self.navigationController pushViewController:webviewVc animated:YES];
    
    [[HURouter shared] route:@"https://www.baidu.com" withPresentType:HUPresentTypePush];
}


@end
