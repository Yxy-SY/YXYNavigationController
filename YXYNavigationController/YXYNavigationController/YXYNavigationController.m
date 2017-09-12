//
//  YXYNavigationController.m
//  nav
//
//  Created by yuxiuyi on 15-6-20.
//  Copyright (c) 2015年 yuxiuyi. All rights reserved.
//

#import "YXYNavigationController.h"

#import "UIViewController+YXYViewConroller.h"

#import "YXYNavigationPopAnimator.h"

@interface YXYNavigationController ()<UINavigationBarDelegate,UIGestureRecognizerDelegate>
{
    NSMutableArray *_deallocViewControllers;
    
    NSMutableArray *_popViewControllers;
    
    UIPanGestureRecognizer *_leftToRightSwipe;
    
    BOOL _swipeToRight;
    
    BOOL _canSwipeToRight;
    
    UIPercentDrivenInteractiveTransition *_popInteractionController;
    
    YXYViewControllerSwitchParam *_popSwitchParam;
    
    NSTimer *_timer;
    
    BOOL _beginSwipe;
}

@end


@implementation YXYNavigationController

- (instancetype)initWithRootViewControllerClass:(Class)cls
{
    return [self initWithRootViewController:[cls new]];
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    
    __unsafe_unretained id s = self;
    
    super.delegate = s;
    
    self.interactivePopGestureRecognizer.enabled = NO;
    
    _popViewControllers = [NSMutableArray new];
    
    _leftToRightSwipe = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(leftToRightSwipe:)];
    _leftToRightSwipe.delegate = self;
    [self.view addGestureRecognizer:_leftToRightSwipe];
    
    return self;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.view.userInteractionEnabled = NO;
    
    [super pushViewController:viewController animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController deallocViewController:(NSArray*)deallocViewController animated:(BOOL)animated
{
    self.view.userInteractionEnabled = NO;
    
    if(_deallocViewControllers == nil)
        _deallocViewControllers = [NSMutableArray new];
    [_deallocViewControllers addObjectsFromArray:deallocViewController];
    
    [self pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerWithSwitchParam:(YXYViewControllerSwitchParam*)switchParam animated:(BOOL)animated
{
    self.view.userInteractionEnabled = NO;
    
    NSArray *ar = self.viewControllers;
    
    _popSwitchParam = switchParam;
    UIViewController *popViewController = [super popViewControllerAnimated:animated];
    
    //不知道什么原因，可能是动画还没有放完，马上返回，有时回返回nil
    if(popViewController == nil)
    {
        if(ar.count > 1)
        {
            popViewController = ar[ar.count - 1];
            
            [popViewController viewControllerDidMoveDealloc];
            [popViewController viewControllerWillDealloc];
        }
    }
    else
    {
        [_popViewControllers addObject:popViewController];
    }
    
    return popViewController;
}

- (NSArray *)popToViewController:(UIViewController *)viewController withSwitchParam:(YXYViewControllerSwitchParam*)switchParam animated:(BOOL)animated
{
    self.view.userInteractionEnabled = NO;
    
    _popSwitchParam = switchParam;
    NSArray *ar = [super popToViewController:viewController animated:animated];
    [_popViewControllers addObjectsFromArray:[[ar reverseObjectEnumerator] allObjects]];
    return ar;
}

- (void)popCountOfViewController:(NSUInteger)count withSwitchParam:(YXYViewControllerSwitchParam*)switchParam
{
    NSArray *ar = self.viewControllers;
    UIViewController *vcl = ar[ar.count - 1 - count];
    
    [self popToViewController:vcl withSwitchParam:switchParam animated:YES];
}

- (NSDictionary*)containViewControllers:(NSArray*)viewControllerNames
{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    
    for(NSString *viewControllerName in viewControllerNames)
    {
        Class cls = NSClassFromString(viewControllerName);
        [self.viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
        {
            if([obj isMemberOfClass:cls])
            {
                dic[[@(idx) stringValue]] = NSStringFromClass([obj class]);
            }
        }];
    }
    return dic;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(_popViewControllers.count <= 0)
    {
        NSArray *viewControllers = self.viewControllers;
        if(viewControllers.count >= 2)
        {
            UIViewController *viewController = viewControllers[viewControllers.count - 2];
            [viewController viewControllerWillMoveDisappear];
        }
        
        [viewController viewControllerWillMoveAppear];
    }
    else
    {
     //   [(UIViewController*)_popViewControllers[_popViewControllers.count - 1] viewControllerWillMoveDealloc];
        [_popViewControllers makeObjectsPerformSelector:@selector(viewControllerWillMoveDealloc)];
        if(_popSwitchParam != nil && [viewController respondsToSelector:@selector(recvPopViewControllerSwitchParam:)])
           [viewController recvPopViewControllerSwitchParam:_popSwitchParam];
        [viewController viewControllerWillMoveReappear];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.view.userInteractionEnabled = YES;
    
    if(_popViewControllers.count <= 0)
    {
        NSArray *viewControllers = self.viewControllers;
        if(viewControllers.count >= 2)
        {
            UIViewController *viewController = viewControllers[viewControllers.count - 2];
            [viewController viewControllerDidMoveDisappear];
        }
        [viewController viewControllerDidMoveAppear];
    }
    else
    {
     //   [(UIViewController*)_popViewControllers[_popViewControllers.count - 1] viewControllerDidMoveDealloc];
        [_popViewControllers makeObjectsPerformSelector:@selector(viewControllerDidMoveDealloc)];
        [viewController viewControllerDidMoveReappear];
        
        [_popViewControllers makeObjectsPerformSelector:@selector(viewControllerWillDealloc)];
        [_popViewControllers removeAllObjects];
    }
    
    if(_deallocViewControllers.count > 0)
    {
        NSMutableArray *ar = [self.viewControllers mutableCopy];
        
        [ar removeObjectsInArray:_deallocViewControllers];
        
        self.viewControllers = ar;
        
        [_deallocViewControllers makeObjectsPerformSelector:@selector(viewControllerDidMoveDealloc)];
        
        [_deallocViewControllers makeObjectsPerformSelector:@selector(viewControllerWillDealloc)];
        
        [_deallocViewControllers removeAllObjects];
    }
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return _popInteractionController;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if(operation == UINavigationControllerOperationPop)
    {
        if(_swipeToRight == YES)
        {
            return [YXYNavigationPopAnimator new];
        }
    }
    return nil;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    UIView *view = touch.view;
    if ([NSStringFromClass([view class]) isEqualToString:@"UITableViewCellContentView"])
    {
        UIView *superView = view.superview;
        if([[UIDevice currentDevice].systemVersion floatValue]>=8.0?YES:NO)
        {
            if(superView != nil && [superView isKindOfClass:[UITableViewCell class]])
            {
                superView = superView.superview;
                if(superView != nil && [superView isKindOfClass:NSClassFromString(@"UITableViewWrapperView")])
                {
                    superView = superView.superview;
                    if(superView != nil && [superView isKindOfClass:[UITableView class]])
                    {
                        id<UITableViewDelegate> delegate = ((UITableView*)superView).delegate;
                        if([delegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)])
                        {
                            return NO;
                        }
                    }
                }
            }
        }
        else
        {
            if(superView != nil && [superView isKindOfClass:NSClassFromString(@"UITableViewCellScrollView")])
            {
                superView = superView.superview;
                if(superView != nil && [superView isKindOfClass:[UITableViewCell class]])
                {
                    superView = superView.superview;
                    if(superView != nil && [superView isKindOfClass:NSClassFromString(@"UITableViewWrapperView")])
                    {
                        superView = superView.superview;
                        if(superView != nil && [superView isKindOfClass:[UITableView class]])
                        {
                            id<UITableViewDelegate> delegate = ((UITableView*)superView).delegate;
                            if([delegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)])
                            {
                                return NO;
                            }
                        }
                    }
                }
            }
        }
    }
    return YES;
}

-(void)leftToRightSwipe:(UIPanGestureRecognizer*)recongnizer
{
    if(recongnizer.state == UIGestureRecognizerStateBegan)
    {
        NSArray *viewControllers = self.viewControllers;
        if(viewControllers.count <= 1)
        {
            _canSwipeToRight = NO;
            return;
        }
        
        [_popViewControllers removeAllObjects];
        
        [_popViewControllers addObject:viewControllers[viewControllers.count - 1]];
        
        _beginSwipe = NO;
        
        //防止滑动过快，系统强制关闭页面
        
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(blockAction:) userInfo:nil repeats:NO];
        
        [_timer setFireDate:[NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]+0.1]];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
    else if(recongnizer.state == UIGestureRecognizerStateChanged)
    {
        CGFloat m = [recongnizer translationInView:self.view].x;
        
        if(_swipeToRight == NO && _beginSwipe == YES)
        {
            if(m > 0 )
            {
                _swipeToRight = YES;
                
                _popInteractionController = [UIPercentDrivenInteractiveTransition new];
                
                [self popViewControllerAnimated:YES];
            }
        }
        
        CGFloat d = fabs(m / self.view.bounds.size.width);
        [_popInteractionController updateInteractiveTransition:d];
    }
    else
    {
        if(_swipeToRight == YES && [recongnizer translationInView:self.view].x > 100)
        {
            [_popInteractionController finishInteractiveTransition];
        }
        else
        {
            [_popInteractionController cancelInteractiveTransition];
            
            [_popViewControllers removeAllObjects];
        };
        
        _swipeToRight = NO;
        _beginSwipe = NO;
    }
}

-(void)blockAction:(id)sender
{
    _beginSwipe = YES;
}

- (void)enableSwipeToLeftViewController:(BOOL)enable
{
    _leftToRightSwipe.enabled = enable;
}

+ (YXYNavigationController*)currentNavigationController
{
    __block UIViewController *viewController = nil;
    [[UIApplication sharedApplication].keyWindow.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        UIViewController *v = [UIViewController superViewController:obj];
        if(v != nil)
        {
            viewController = v;
            *stop = YES;
        }
    }];
    return (YXYNavigationController*)viewController.navigationController;
}

+ (YXYNavigationController*)navigationController
{
    if([[UIDevice currentDevice].systemVersion floatValue]>=8.0?YES:NO)
    {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        UIView *lastView = [keyWindow.subviews lastObject];
        
        //弹出模态框
        if([lastView isKindOfClass:NSClassFromString(@"UITransitionView")])
        {
            UIView *view = [lastView.subviews lastObject];
            UIViewController *vcl = [UIViewController superViewController:view];
            if([vcl isMemberOfClass:[YXYNavigationController class]])
            {
                return (YXYNavigationController*)vcl;
            }
            else
            {
                if ([keyWindow.rootViewController isKindOfClass:[YXYNavigationController class]])
                    return (YXYNavigationController*)keyWindow.rootViewController;
                else
                {
                    UIWindow *window = [[UIApplication sharedApplication].delegate window];
                    UIViewController *vcl = [window rootViewController];
                    if ([vcl isKindOfClass:[YXYNavigationController class]])
                        return (YXYNavigationController*)vcl;
                    else
                        return nil;
                }
            }
        }
        //弹出XUIPanelWindow
        else if([keyWindow isKindOfClass:NSClassFromString(@"XUIPanelWindow")])
        {
            UIWindow *window = [UIApplication sharedApplication].windows[0];
            if(window.rootViewController != nil)
            {
                return (YXYNavigationController*)window.rootViewController;
            }
        }
        else
        {
            if ([keyWindow.rootViewController isKindOfClass:[YXYNavigationController class]])
                return (YXYNavigationController*)keyWindow.rootViewController;
            else
            {
                if ([keyWindow.rootViewController isKindOfClass:[YXYNavigationController class]])
                    return (YXYNavigationController*)keyWindow.rootViewController;
                else
                {
                    UIWindow *window = [[UIApplication sharedApplication].delegate window];
                    UIViewController *vcl = [window rootViewController];
                    if ([vcl isKindOfClass:[YXYNavigationController class]])
                        return (YXYNavigationController*)vcl;
                    else
                        return nil;
                }
            }
        }
    }
    else
    {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        if([keyWindow isMemberOfClass:[UIWindow class]] != YES)
        {
            return (YXYNavigationController*)window.rootViewController;
        }
        else
        {
            UIViewController *vcl = [UIApplication sharedApplication].keyWindow.rootViewController;
            if([[keyWindow subviews] lastObject] == vcl.view)
            {
                return (YXYNavigationController*)vcl;
            }
            else
            {
                return (YXYNavigationController*)[UIViewController superViewController:[[keyWindow subviews] lastObject]];
            }
        }
    }
    
    return nil;
}

+ (void)pushViewController:(UIViewController *)viewController
{
    YXYNavigationController *navigationController = [YXYNavigationController navigationController];
    [navigationController pushViewController:viewController animated:YES];
}

//+ (void)pushViewController:(UIViewController *)viewController andDeallocViewController:(UIViewController*)currentViewController
//{
//    YXYNavigationController *navigationController = [YXYNavigationController navigationController];
//    navigationController.deallocViewController = currentViewController;
//    
//    [navigationController pushViewController:viewController animated:YES];
//}

+ (void)pushReplaceCount:(NSUInteger)count viewController:(UIViewController *)viewController
{
    YXYNavigationController *navigationController = [YXYNavigationController navigationController];
    NSArray *ar = navigationController.viewControllers;
    NSArray *replaces = [ar subarrayWithRange:NSMakeRange(ar.count - count, count)];
    [navigationController pushViewController:viewController deallocViewController:replaces animated:YES];
}

+ (void)pushDeallocViewController:(UIViewController *)viewController
{
    YXYNavigationController *navigationController = [YXYNavigationController navigationController];
    NSArray *ar = navigationController.viewControllers;
    [navigationController pushViewController:viewController deallocViewController:ar animated:YES];
}

+ (void)pushViewControllerClass:(Class)cls
{
    [YXYNavigationController pushViewControllerClass:cls withSwitchParam:nil];
}

+ (void)pushViewControllerClass:(Class)cls withSwitchParam:(YXYViewControllerSwitchParam*)switchParam
{
    UIViewController *vcl = [[cls alloc] initWithViewControllerSwitchParam:switchParam];
    [YXYNavigationController pushViewController:vcl];
}

+ (void)pushReplaceCount:(NSUInteger)count viewControllerClass:(Class)cls withSwitchParam:(YXYViewControllerSwitchParam*)switchParam
{
    UIViewController *vcl = [[cls alloc] initWithViewControllerSwitchParam:switchParam];
    [YXYNavigationController pushReplaceCount:count viewController:vcl];
}

+ (void)pushReplaceViewControllerClass:(Class)cls withSwitchParam:(YXYViewControllerSwitchParam *)switchParam
{
    [YXYNavigationController pushReplaceCount:1 viewControllerClass:cls withSwitchParam:switchParam];
}

+ (void)pushReplaceViewControllerClass:(Class)cls
{
    [YXYNavigationController pushReplaceViewControllerClass:cls withSwitchParam:nil];
}

+ (void)pushDeallocViewControllerClass:(Class)cls
{
    UIViewController *vcl = [cls new];
    [YXYNavigationController pushDeallocViewController:vcl];
}

+ (void)pop
{
    [YXYNavigationController popWithSwitchParam:nil];
}

+ (void)popWithSwitchParam:(YXYViewControllerSwitchParam *)switchParam
{
    YXYNavigationController *navigationController = [YXYNavigationController navigationController];
    [navigationController popViewControllerWithSwitchParam:switchParam animated:YES];
}

+ (void)popToViewControllerClass:(Class)cls
{
    [YXYNavigationController popToViewControllerClass:cls withSwitchParam:nil];
}

+ (void)popToViewControllerClass:(Class)cls withSwitchParam:(YXYViewControllerSwitchParam *)switchParam
{
    YXYNavigationController *navigationController = [YXYNavigationController navigationController];
    [navigationController.viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        UIViewController *viewController = obj;
        if([viewController isMemberOfClass:cls])
        {
            [navigationController popToViewController:viewController withSwitchParam:switchParam animated:YES];
            *stop = YES;
        }
    }];
}

+ (void)popCountOfViewController:(NSUInteger)count
{
    [YXYNavigationController popCountOfViewController:count withSwitchParam:nil];
}

+ (void)popCountOfViewController:(NSUInteger)count withSwitchParam:(YXYViewControllerSwitchParam*)switchParam
{
    YXYNavigationController *navigationController = [YXYNavigationController navigationController];
    [navigationController popCountOfViewController:count withSwitchParam:switchParam];
}

+ (NSDictionary*)containViewControllers:(NSArray*)viewControllerNames
{
    YXYNavigationController *navigationController = [YXYNavigationController navigationController];
    return [navigationController containViewControllers:viewControllerNames];
}

+ (void)enableSwipeToLeftViewController:(BOOL)enable
{
    YXYNavigationController *navigationController = [YXYNavigationController navigationController];
    [navigationController enableSwipeToLeftViewController:enable];
}

+ (void)insertViewControllerClass:(Class)cls atInvertedIndex:(NSUInteger)index
{
    YXYNavigationController *navigationController = [YXYNavigationController navigationController];
    NSArray *ar = navigationController.viewControllers;
    UIViewController *vcl = [[cls alloc] init];
    NSMutableArray *array = [NSMutableArray arrayWithArray:ar];
    [array insertObject:vcl atIndex:array.count - index];
    [navigationController setViewControllers:array animated:YES];
}

@end
