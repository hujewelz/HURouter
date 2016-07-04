//
//  HUWebViewController.m
//  HURouter
//
//  Created by jewelz on 16/6/3.
//  Copyright © 2016年 hujewelz. All rights reserved.
//

#import "HUWebViewController.h"

@interface HUWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation HUWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.webView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:_url]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - webview delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;
    
}


#pragma mark - getter an setter

//- (void)setUrl:(NSURL *)url {
//    _url = url;
//    //[self.webView loadRequest:[NSURLRequest requestWithURL:url]];
//}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.delegate = self;
    }
    return _webView;
}

@end
