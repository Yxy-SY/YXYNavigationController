//
//  ViewControllerNext.m
//  YXYNavigationController
//
//  Created by yuxiuyi on 2017/9/11.
//
//

#import "ViewControllerNext.h"

#import "YXYNavigationController.h"

#import "UIViewController+YXYViewConroller.h"

@interface ViewControllerNext ()

@end

@implementation ViewControllerNext

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *data = self.param[@"data"];
    
    NSLog(@"%@",data);
    
    [self createLeftBarButtonItemWithTitle:@"返回"];
}

-(void)clickedLeftBarButton:(id)sender
{
    YXYViewControllerSwitchParam *p = [YXYViewControllerSwitchParam new];
    p.param[@"data"] = @"fromViewControllerNext";
    [YXYNavigationController popWithSwitchParam:p];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
