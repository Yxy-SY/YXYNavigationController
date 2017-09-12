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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createRightBarButtonItemWithTitle:@"下一页"];

}

-(void)clickedRightBarButton:(id)sender
{
    YXYViewControllerSwitchParam *p = [YXYViewControllerSwitchParam new];
    p.param[@"data"] = @"fromViewController";
    [YXYNavigationController pushViewControllerClass:[ViewControllerNext class] withSwitchParam:p];
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
