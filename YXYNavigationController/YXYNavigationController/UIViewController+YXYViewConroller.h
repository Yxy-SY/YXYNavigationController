//
//  UIViewController+YXYViewConroller.h
//  nav
//
//  Created by yuxiuyi on 15-6-20.
//  Copyright (c) 2015年 yuxiuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YXYViewControllerSwitchParam.h"

@interface UIViewController (YXYViewConroller)

@property(nonatomic,readonly) NSDictionary *param;

- (instancetype)initWithViewControllerSwitchParam:(YXYViewControllerSwitchParam*)switchParam;

- (void)initViewDidLoad;

+ (UIViewController*)currentRootViewController;

+ (UIViewController*)superViewController:(UIView*)view;

- (UIViewController*)superViewController;

- (UIViewController*)topViewController;

- (void)enumViewController:(void (^)(UIViewController *viewController, NSUInteger idx, BOOL *stop))block;

/**
 *  视图将要被释放时，响应此方法，子类重写此方法时，必须调用父方法
 */
- (void)viewControllerWillDealloc;

@end
