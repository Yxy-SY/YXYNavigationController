//
//  TableViewController.m
//  YXYNavigationController
//
//  Created by yuxiuyi on 2017/9/13.
//
//

#import "TableViewController.h"

#import "XUIRefreshHeaderView.h"

@interface TableViewController ()<XUIRefreshHeaderViewDelegate>
{
    XUIRefreshHeaderView *_refreshHeaderView;
}
@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(_refreshHeaderView == nil)
        _refreshHeaderView = [[XUIRefreshHeaderView alloc]initWithDelegate:self];
    
    [self.tableView addSubview:_refreshHeaderView];
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}


- (void)refreshHeaderViewBeginRefreshing:(XUIRefreshHeaderView *)view
{
    void(^f)()=^()
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_refreshHeaderView endRefreshing];
        });
    };
    
    f();
}

- (id)refreshHeaderViewLastUpdateTime:(XUIRefreshHeaderView *)view
{
    id date = nil;
    
    return date;
}

@end
