//
//  UIViewController+YXYNavigationController.h
//  nav
//
//  Created by yuxiuyi on 15-6-21.
//  Copyright (c) 2015年 yuxiuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXYViewControllerSwitchParam;

@interface UIViewController (YXYNavigationController)

@property(nonatomic,copy) NSString *navTitle;

@property(nonatomic,retain) UIView *titleView;

@property(nonatomic,copy)   NSString *prompt;

@property(nonatomic,assign) BOOL hidesBackButton;

@property(nonatomic,retain) UIBarButtonItem *leftBarButtonItem;

@property(nonatomic,retain) UIBarButtonItem *rightBarButtonItem;


- (void)createBackBarButtonItemWithTitle:(NSString*)title;

- (void)createBackBarButtonItemWithImage:(UIImage*)image;

- (void)createBackBarButtonItemWithView:(UIView*)view;


- (void)createLeftBarButtonItemWithTitle:(NSString*)title;

- (void)createLeftBarButtonItemWithImage:(UIImage*)image;

- (void)createLeftBarButtonItemWithView:(UIView*)view;

- (void)clickedLeftBarButton:(id)sender;


- (void)createRightBarButtonItemWithTitle:(NSString*)title;

- (void)createRightBarButtonItemWithImage:(UIImage*)image;

- (void)createRightBarButtonItemWithView:(UIView*)view;

- (void)createRightBarButtonItemWithBarButtonSystemItem:(UIBarButtonSystemItem)barButtonSystemItem;

- (void)clickedRightBarButton:(id)sender;

- (void)recvPopViewControllerSwitchParam:(YXYViewControllerSwitchParam*)switchParam;


/**
 *  视图将要移入可见区域
 */
- (void)viewControllerWillMoveAppear;

/**
 *  视图已经移入可见区域
 */
- (void)viewControllerDidMoveAppear;


/**
 *  视图将要重新移入可见区域
 */
- (void)viewControllerWillMoveReappear;

/**
 *  视图已经重新移入可见区域
 */
- (void)viewControllerDidMoveReappear;


/**
 *  视图将要移出可见区域，不是在栈中移除
 */
- (void)viewControllerWillMoveDisappear;

/**
 *  视图已经移出可见区域，不是在栈中移除
 */
- (void)viewControllerDidMoveDisappear;

/**
 *  视图将要移出可见区域，且将要在栈中移除
 */
- (void)viewControllerWillMoveDealloc;

/**
 *  视图已经移出可见区域，且已经在栈中移除
 */
- (void)viewControllerDidMoveDealloc;


@end
