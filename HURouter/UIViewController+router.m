//
//  UIViewController+router.m
//  HURouter
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 hujewelz. All rights reserved.
//

#import "UIViewController+router.h"
#import <objc/runtime.h>

static char kParamBundingKey;

@implementation UIViewController (router)

- (void)setParam:(NSDictionary *)param {
    objc_setAssociatedObject(self, &kParamBundingKey, param, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)param {
    return objc_getAssociatedObject(self, &kParamBundingKey);
}



@end
