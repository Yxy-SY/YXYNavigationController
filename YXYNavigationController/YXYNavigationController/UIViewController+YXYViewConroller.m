//
//  UIViewController+YXYViewConroller.m
//  nav
//
//  Created by yuxiuyi on 15-6-20.
//  Copyright (c) 2015年 yuxiuyi. All rights reserved.
//

#import "UIViewController+YXYViewConroller.h"

#import "YXYNavigationController.h"

 #import<objc/runtime.h>

#import <objc/message.h>


@implementation UIViewController (YXYViewConroller)

- (instancetype)initWithViewControllerSwitchParam:(YXYViewControllerSwitchParam*)switchParam
{
    self = [self init];
    
    if(switchParam.param.count > 0)
        self.param = switchParam.param;
    
    return self;
}

- (void)initViewDidLoad
{
    
}

-(void)setParam:(NSDictionary *)param
{
    objc_setAssociatedObject(self, "param", param, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSDictionary *)param
{
    return objc_getAssociatedObject(self, "param");
}

+ (UIViewController*)currentRootViewController
{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

+ (UIViewController*)superViewController:(UIView*)view
{
    id nextresponder = [view nextResponder];
    if (FALSE == [nextresponder isKindOfClass:[UIViewController class]])
        nextresponder = nil;
    return (UIViewController *) nextresponder;
}

- (UIViewController*)superViewController
{
    return [UIViewController superViewController:self.view];
}

- (UIViewController*)topViewController
{
    __block UIViewController *viewController = nil;
    [self.view.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        UIViewController *v = [UIViewController superViewController:obj];
        if(v != nil && [v isKindOfClass:[UIViewController class]] && v.view == obj)
        {
            viewController = v;
            *stop = YES;
        }
    }];
    return viewController;
}

- (void)enumViewController:(void (^)(UIViewController *viewController, NSUInteger idx, BOOL *stop))block
{
    @autoreleasepool
    {
        [self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
        {
            UIViewController *viewController = [UIViewController superViewController:obj];
            block(viewController,idx,stop);
        }];
    }
}

- (void)viewControllerWillDealloc
{
    
}


@end
