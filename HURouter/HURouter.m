//
//  HURouter.m
//  HURouter
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 hujewelz. All rights reserved.
//

#import "HURouter.h"
#import "HUNotFoundViewController.h"
#import "HUWebViewController.h"

@interface HURouter ()

@property (nonatomic, strong) NSMutableDictionary *routes;

@end

@implementation HURouter

+ (instancetype)shared {
    static HURouter *router = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [HURouter new];
    });
    return router;
}

- (instancetype)init {
    if (self = [super init]) {
        _routes = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)map:(NSString *)className with:(NSString *)key {
    Class class = NSClassFromString(className);
    if (_routes[key] == nil) {
        _routes[key] = class;
    }
}

- (void)map:(NSDictionary *)dictionary {
    if (dictionary) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:dictionary.count];
        [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
            Class class = NSClassFromString(obj);
            dict[key] = class;
            
        }];
        [_routes addEntriesFromDictionary:[dict copy]];
    }
    
}

- (UIViewController *)matchController:(NSString *)route {
    if (route == nil) {
        return nil;
    }
    NSURL *url = [NSURL URLWithString:route];
    NSLog(@"\nscheme:%@\n host:%@\n path:%@\n parameterString:%@\n query:%@\n relativePath:%@",url.scheme, url.host, url.path,url.parameterString,url.query,url.relativePath);
    NSLog(@"pathComponents:%@", url.pathComponents);
    
    NSString *scheme = url.scheme;
    if (scheme && ([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"])) {
        HUWebViewController *webviewVc = [[HUWebViewController alloc] init];
        webviewVc.url = url;
        return webviewVc;
    }
    
    NSString *classKey = [NSString stringWithFormat:@"%@%@",url.host?:@"",url.path];
    Class class = _routes[classKey];
    id instance = [[class alloc] init];
    
    if (!instance || ![instance isKindOfClass:[UIViewController class]]) {
        return nil;
    }
    return instance;
}

- (void)route:(NSString *)route withPresentType:(HUPresentType)type{
    if (route == nil) {
        return;
    }
    NSURL *url = [NSURL URLWithString:route];
    NSString *scheme = url.scheme;
    
    UIViewController *vc = [self matchController:route];
    if (vc == nil) {
        HUNotFoundViewController *notfoundVc = [[HUNotFoundViewController alloc] init];
        if (self.currentViewController.navigationController) {
            [self.currentViewController.navigationController pushViewController:notfoundVc animated:YES];
        }
        else {
            [self.currentViewController presentViewController:notfoundVc animated:YES completion:nil];
        }
        return;
    }
    else if (![scheme isEqualToString:@"http"] && ![scheme isEqualToString:@"https"]) {
        NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
        NSArray *params = [url.query componentsSeparatedByString:@"&"];
        for (NSString *param in params) {
            NSArray *result = [param componentsSeparatedByString:@"="];
            paramDict[[result firstObject]] = [result lastObject];
        }
        NSLog(@"param: %@", paramDict);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([vc respondsToSelector:@selector(setParam:)]) {
            [vc performSelector:@selector(setParam:) withObject:paramDict];
        }
#pragma clang diagnostic pop
    }
    
    
    switch (type) {
        case HUPresentTypeModal:
            [self.currentViewController presentViewController:vc animated:YES completion:nil];
            break;
        case HUPresentTypePush:
            [self.currentViewController.navigationController pushViewController:vc animated:YES];
            break;
        default:
            break;
    }
}

#pragma mark - private

- (UIViewController *)findViewController:(UIViewController *)inCotorller {
    if ([inCotorller isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabVc = (UITabBarController *)inCotorller;
        return [self findViewController:tabVc.selectedViewController];
    }
    else if ([inCotorller isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController *)inCotorller;
        return [self findViewController:navigationController.visibleViewController];
    }
    else if ([inCotorller isKindOfClass:[UIViewController class]]){
        return inCotorller;
    }
    return nil;
}

- (UIViewController *)currentViewController {
    return [self findViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}




@end
