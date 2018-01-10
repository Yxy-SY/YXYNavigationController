//
//  ViewController.m
//  YXYNavigationController
//
//  Created by yuxiuyi on 2017/9/11.
//
//

#import "ViewController.h"

#import "ViewControllerNext.h"

#import "YXYNavigationController.h"

#import "TableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createRightBarButtonItemWithTitle:@"下一页"];
    //    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
    //    //    YXYViewControllerSwitchParam *p = [YXYViewControllerSwitchParam new];
    //    p.param[@"data"] = @"fromViewController";
    //    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
    //    //    YXYViewControllerSwitchParam *p = [YXYViewControllerSwitchParam new];
    //    p.param[@"data"] = @"fromViewController";
    //    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
    //    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
    //    //    YXYViewControllerSwitchParam *p = [YXYViewControllerSwitchParam new];
    //    p.param[@"data"] = @"fromViewController";
    //    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
    //    //    YXYViewControllerSwitchParam *p = [YXYViewControllerSwitchParam new];
    //    p.param[@"data"] = @"fromViewController";
    //    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
}

-(void)clickedRightBarButton:(id)sender
{
//    YXYViewControllerSwitchParam *p = [YXYViewControllerSwitchParam new];
//    p.param[@"data"] = @"fromViewController";
//    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
//
    //    YXYViewControllerSwitchParam *p = [YXYViewControllerSwitchParam new];
    //    p.param[@"data"] = @"fromViewController";
    //    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
    //    //    YXYViewControllerSwitchParam *p = [YXYViewControllerSwitchParam new];
    //    p.param[@"data"] = @"fromViewController";
    //    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
    //    //    YXYViewControllerSwitchParam *p = [YXYViewControllerSwitchParam new];
    //    p.param[@"data"] = @"fromViewController";
    //    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
    //    //    YXYViewControllerSwitchParam *p = [YXYViewControllerSwitchParam new];
    //    p.param[@"data"] = @"fromViewController";
    //    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
    //    //    YXYViewControllerSwitchParam *p = [YXYViewControllerSwitchParam new];
    //    p.param[@"data"] = @"fromViewController";
    //    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
    //    //    YXYViewControllerSwitchParam *p = [YXYViewControllerSwitchParam new];
    //    p.param[@"data"] = @"fromViewController";
    //    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
    //    //    YXYViewControllerSwitchParam *p = [YXYViewControllerSwitchParam new];
    //    p.param[@"data"] = @"fromViewController";
    //    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
    //    //    YXYViewControllerSwitchParam *p = [YXYViewControllerSwitchParam new];
    //    p.param[@"data"] = @"fromViewController";
    //    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
    //    //    YXYViewControllerSwitchParam *p = [YXYViewControllerSwitchParam new];
    //    p.param[@"data"] = @"fromViewController";
    //    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
    //    //    YXYViewControllerSwitchParam *p = [YXYViewControllerSwitchParam new];
    //    p.param[@"data"] = @"fromViewController";
    //    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
    //    //    YXYViewControllerSwitchParam *p = [YXYViewControllerSwitchParam new];
    //    p.param[@"data"] = @"fromViewController";
    //    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
    //    //    YXYViewControllerSwitchParam *p = [YXYViewControllerSwitchParam new];
    //    p.param[@"data"] = @"fromViewController";
    //    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
    //    //    YXYViewControllerSwitchParam *p = [YXYViewControllerSwitchParam new];
    //    p.param[@"data"] = @"fromViewController";
    //    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
    //
    [YXYNavigationController pushViewController:[TableViewController new]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)recvPopViewControllerSwitchParam:(YXYViewControllerSwitchParam*)switchParam
{
    NSString *data = switchParam.param[@"data"];
    NSLog(@"%@",data);
}


@end
