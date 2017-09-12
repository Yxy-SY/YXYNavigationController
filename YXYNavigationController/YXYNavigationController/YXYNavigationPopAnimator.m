//
//  XUINavigationPopAnimator.m
//  nav
//
//  Created by yuxiuyi on 15-7-7.
//  Copyright (c) 2015年 yuxiuyi. All rights reserved.
//

#import "YXYNavigationPopAnimator.h"

@implementation YXYNavigationPopAnimator

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CALayer *l = fromViewController.view.layer;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 5, fromViewController.view.frame.size.height)];
    l.shadowPath = path.CGPath;
    l.shadowOffset = CGSizeMake(-2, 0);
    l.shadowOpacity = 0.5;
    
    [[transitionContext containerView] insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    __block CGRect toRect = toViewController.view.frame;
    
    CGRect toOriRect = toRect;
    CGRect fromOriRect = fromViewController.view.frame;
    
    CGFloat originX = toRect.origin.x;
    toRect.origin.x -= toRect.size.width / 3;
    toViewController.view.frame = toRect;

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^
    {
        CGRect fromRect = fromOriRect;
        fromRect.origin.x += fromRect.size.width;
        fromViewController.view.frame = fromRect;
        
        toRect.origin.x = originX;
        toViewController.view.frame = toRect;
        
    } completion:^(BOOL finished)
    {
        BOOL result = [transitionContext transitionWasCancelled];
        
        if(result == YES)
        {
            l.shadowPath = NULL;
            l.shadowOffset = CGSizeMake(0, -3);
            l.shadowOpacity = 0;
            
            toViewController.view.frame = toOriRect;
            fromViewController.view.frame = fromOriRect;
        }
        
        [transitionContext completeTransition:!result];
    }];
    
}


@end
