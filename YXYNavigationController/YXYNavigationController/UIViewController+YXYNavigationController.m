//
//  UIViewController+YXYNavigationController.m
//  nav
//
//  Created by yuxiuyi on 15-6-21.
//  Copyright (c) 2015年 yuxiuyi. All rights reserved.
//

#import "UIViewController+YXYNavigationController.h"

@implementation UIViewController (YXYNavigationController)

- (void)setNavTitle:(NSString *)navTitle
{
    self.navigationItem.title = navTitle;
}

- (NSString*)navTitle
{
    return self.navigationItem.title;
}

- (void)setTitleView:(UIView *)titleView
{
    self.navigationItem.titleView = titleView;
}

- (UIView*)titleView
{
    return self.navigationItem.titleView;
}

- (void)setPrompt:(NSString *)prompt
{
    self.navigationItem.prompt = prompt;
}

- (NSString*)prompt
{
    return self.navigationItem.prompt;
}

- (void)setHidesBackButton:(BOOL)hidesBackButton
{
    self.navigationItem.hidesBackButton = hidesBackButton;
}

- (BOOL)hidesBackButton
{
    return self.navigationItem.hidesBackButton;
}

- (void)setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem
{
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (UIBarButtonItem*)leftBarButtonItem
{
    return self.navigationItem.leftBarButtonItem;
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem
{
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (UIBarButtonItem*)rightBarButtonItem
{
    return self.navigationItem.rightBarButtonItem;
}


- (void)createBackBarButtonItemWithTitle:(NSString*)title
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(clickedLeftBarButton:)];
    self.navigationItem.backBarButtonItem = item;
}

- (void)createBackBarButtonItemWithImage:(UIImage*)image
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(clickedLeftBarButton:)];
    self.navigationItem.backBarButtonItem = item;
}

- (void)createBackBarButtonItemWithView:(UIView*)view
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.backBarButtonItem = item;
}

- (void)createLeftBarButtonItemWithTitle:(NSString*)title
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(clickedLeftBarButton:)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)createLeftBarButtonItemWithImage:(UIImage*)image
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(clickedLeftBarButton:)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)createLeftBarButtonItemWithView:(UIView*)view
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)createRightBarButtonItemWithBarButtonSystemItem:(UIBarButtonSystemItem)barButtonSystemItem
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:barButtonSystemItem target:self action:@selector(clickedRightBarButton:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)clickedLeftBarButton:(id)sender
{
    
}

- (void)createRightBarButtonItemWithTitle:(NSString*)title
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(clickedRightBarButton:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)createRightBarButtonItemWithImage:(UIImage*)image
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(clickedRightBarButton:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)createRightBarButtonItemWithView:(UIView*)view
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)clickedRightBarButton:(id)sender
{
    
}


- (void)recvPopViewControllerSwitchParam:(YXYViewControllerSwitchParam*)switchParam
{
    
}


- (void)viewControllerWillMoveAppear
{
    
}

- (void)viewControllerDidMoveAppear
{
    
}


- (void)viewControllerWillMoveReappear
{
    
}

- (void)viewControllerDidMoveReappear
{
    
}

- (void)viewControllerWillMoveDisappear
{
    
}

- (void)viewControllerDidMoveDisappear
{
    
}

- (void)viewControllerWillMoveDealloc
{
    
}

- (void)viewControllerDidMoveDealloc
{
    
}

@end
