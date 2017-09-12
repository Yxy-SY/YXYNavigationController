//
//  YXYNavigationController.h
//  nav
//
//  Created by yuxiuyi on 15-6-20.
//  Copyright (c) 2015年 yuxiuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YXYViewControllerSwitchParam.h"

#import "UIViewController+YXYNavigationController.h"

@interface YXYNavigationController : UINavigationController

- (instancetype)initWithRootViewControllerClass:(Class)cls;

+ (YXYNavigationController*)currentNavigationController;

+ (YXYNavigationController*)navigationController;

+ (void)enableSwipeToLeftViewController:(BOOL)enable;

+ (void)pushViewController:(UIViewController *)viewController;

+ (void)pushViewControllerClass:(Class)cls;

+ (void)pushViewControllerClass:(Class)cls withSwitchParam:(YXYViewControllerSwitchParam*)switchParam;

+ (void)pushReplaceCount:(NSUInteger)count viewControllerClass:(Class)cls withSwitchParam:(YXYViewControllerSwitchParam*)switchParam;

+ (void)pushReplaceViewControllerClass:(Class)cls withSwitchParam:(YXYViewControllerSwitchParam*)switchParam;

+ (void)pushReplaceViewControllerClass:(Class)cls;

+ (void)pushDeallocViewControllerClass:(Class)cls;



+ (void)pop;

+ (void)popWithSwitchParam:(YXYViewControllerSwitchParam*)switchParam;

+ (void)popToViewControllerClass:(Class)cls;

+ (void)popToViewControllerClass:(Class)cls withSwitchParam:(YXYViewControllerSwitchParam*)switchParam;

+ (void)popCountOfViewController:(NSUInteger)count;

+ (void)popCountOfViewController:(NSUInteger)count withSwitchParam:(YXYViewControllerSwitchParam*)switchParam;

+ (NSDictionary*)containViewControllers:(NSArray*)viewControllerNames;



+ (void)insertViewControllerClass:(Class)cls atInvertedIndex:(NSUInteger)index;

@end
