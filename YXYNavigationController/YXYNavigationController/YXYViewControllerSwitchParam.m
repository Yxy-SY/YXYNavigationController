//
//  YXYViewControllerSwitchParam.m
//  nav
//
//  Created by yuxiuyi on 15/8/10.
//  Copyright (c) 2015年 yuxiuyi. All rights reserved.
//

#import "YXYViewControllerSwitchParam.h"

@implementation YXYViewControllerSwitchParam
{
    NSMutableDictionary *_param;
}

@synthesize param = _param;

-(void)setParam:(NSMutableDictionary *)param
{
    if(_param == nil)
        _param = [NSMutableDictionary new];
    [_param addEntriesFromDictionary:param];
}

-(NSMutableDictionary*)param
{
    if(_param == nil)
        _param = [NSMutableDictionary new];
    return _param;
}

@end
