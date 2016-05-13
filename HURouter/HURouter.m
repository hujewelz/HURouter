//
//  HURouter.m
//  HURouter
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 hujewelz. All rights reserved.
//

#import "HURouter.h"

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

- (void)route:(NSString *)route withPresentType:(HUPresentType)type{
    if (route == nil) {
        return;
    }
    NSURL *url = [NSURL URLWithString:route];
    Class class = _routes[url.path];
    id instance = [[class alloc] init];
    if (![instance isKindOfClass:[UIViewController class]]) {
        return;
    }
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    NSArray *params = [url.query componentsSeparatedByString:@"&"];
    for (NSString *param in params) {
        NSArray *result = [param componentsSeparatedByString:@"="];
        paramDict[[result firstObject]] = [result lastObject];
    }
    NSLog(@"param: %@", paramDict);
    if ([instance respondsToSelector:@selector(setParams:)]) {
        [instance performSelector:@selector(setParams:) withObject:paramDict];
    }
    switch (type) {
        case HUPresentTypeModal:
            [self.currentViewController presentViewController:instance animated:YES completion:nil];
            break;
        case HUPresentTypePush:
            [self.currentViewController.navigationController pushViewController:instance animated:YES];
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
