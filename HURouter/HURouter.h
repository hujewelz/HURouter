//
//  HURouter.h
//  HURouter
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 hujewelz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HUPresentType) {
    HUPresentTypePush,
    HUPresentTypeModal
};

@interface HURouter : NSObject

+ (instancetype)shared;

@property (nonatomic, strong) UIViewController *currentViewController;

- (void)map:(NSString *)className with:(NSString *)key;

- (void)route:(NSString *)route withPresentType:(HUPresentType)type;

@end
