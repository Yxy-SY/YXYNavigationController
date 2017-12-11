//
//  RefreshHeaderView.m
//  etionUI
//
//  Created by wangjian on 11/11/13.
//  Copyright (c) 2013 GuangZhouXuanWu. All rights reserved.
//

#import "XUIRefreshHeaderView.h"

//#import "UIStyleSkinManagerInternal.h"

#define DEFAULT_TITLE_PREFIX   @"最近更新"

//#define STATE_TITLE_PULL @"下拉刷新"
//#define STATE_TITLE_READY @"释放刷新"
//#define STATE_TITLE_REFRESH @"正在刷新"

NSString *const XUIRefreshHeaderViewStatusTextPull = @"XUIRefreshHeaderViewStatusTextPull";
NSString *const XUIRefreshHeaderViewStatusTextReady = @"XUIRefreshHeaderViewStatusTextReady";
NSString *const XUIRefreshHeaderViewStatusTextRefresh = @"XUIRefreshHeaderViewStatusTextRefresh";

typedef NS_ENUM(NSUInteger, XUIRefreshingState)
{
    XUIRefreshingStateNormal,
    XUIRefreshingStateRefreshReady,
    XUIRefreshingStateRefreshing,
    XUIRefreshingStateRefreshed,
};

@interface XUIRefreshHeaderView ()
{
    UIView *_refreshIndicatorView;
    UIView *_refreshingView;

    UILabel *_stateLable;
    UILabel *_titleLable;

    UIView *_headContentView;
    UIView *_brandContentView;

    NSString *_titlePrefixText;

    BOOL _endRefreshingImmediately;

    BOOL _addedTopInset;

    BOOL _subtractingTopInset;
    
    NSDictionary *_statusTexts;
    
    CGFloat _refreshHeadViewHeight;
    
    CGFloat _refreshHeadViewThreshold;

    XUIRefreshingState _refreshingState;

    XUIRefreshHeaderViewPresentType _presentType;

    XUIRefreshingAnimatedType _refreshingAnimatedType;

    XUIRefreshIndicatorAnimatedType _refreshIndicatorAnimatedType;

    __unsafe_unretained id <XUIRefreshHeaderViewDelegate> _delegate;

    UITableView *_tableView;
}

@end

@implementation XUIRefreshHeaderView

@synthesize refreshHeadViewHeight = _refreshHeadViewHeight;

@synthesize refreshHeadViewThreshold = _refreshHeadViewThreshold;

@synthesize statusTexts = _statusTexts;

@synthesize titlePrefixText = _titlePrefixText;

@synthesize brandContentView = _brandContentView;

@synthesize presentType = _presentType;

@synthesize refreshingAnimatedType = _refreshingAnimatedType;

@synthesize refreshIndicatorAnimatedType = _refreshIndicatorAnimatedType;

@synthesize refreshingView = _refreshingView;

@synthesize refreshIndicatorView = _refreshIndicatorView;

@synthesize endRefreshingImmediately = _endRefreshingImmediately;

@synthesize szTag;

- (id)initWithDelegate:(id <XUIRefreshHeaderViewDelegate>)delegate
{
    self = [self initWithFrame:CGRectZero];

    _delegate = delegate;

    return self;
}

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initialize];
    }

    self.backgroundColor = [UIColor clearColor];

    return self;
}

- (void)initialize
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    _refreshHeadViewHeight = 60;
    
    _refreshHeadViewThreshold = 65;
    
    _refreshingState = XUIRefreshingStateNormal;

    _titlePrefixText = DEFAULT_TITLE_PREFIX;
    
    self.statusTexts = @{XUIRefreshHeaderViewStatusTextPull:@"下拉刷新",XUIRefreshHeaderViewStatusTextReady:@"释放刷新",XUIRefreshHeaderViewStatusTextRefresh:@"正在刷新"};

    _headContentView = [[UIView alloc] initWithFrame:CGRectZero];
    _headContentView.backgroundColor = [UIColor clearColor];
    [self addSubview:_headContentView];

    _refreshIndicatorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refresh_head"]];
    _refreshIndicatorView.size = CGSizeMake(_refreshIndicatorView.width > 0 ? MIN(_refreshIndicatorView.width, 40) : 40, _refreshIndicatorView.height > 0 ? MIN(_refreshIndicatorView.width, 40) : 40);
    _refreshIndicatorView.backgroundColor = [UIColor clearColor];
    [_headContentView addSubview:_refreshIndicatorView];

    _refreshingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _refreshingView.size = CGSizeMake(20, 20);
    _refreshingView.hidden = YES;
    [(UIActivityIndicatorView *) _refreshingView stopAnimating];
    [_headContentView addSubview:_refreshingView];

    _stateLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _stateLable.backgroundColor = [UIColor clearColor];
    _stateLable.font = [UIFont systemFontOfSize:14];
    _stateLable.text = [_statusTexts objectForKey:XUIRefreshHeaderViewStatusTextPull];
    _stateLable.size = [@"国国国国国国" stringSizeWithFont:_stateLable.font];
    _stateLable.textAlignment = NSTextAlignmentCenter;
    [_headContentView addSubview:_stateLable];

    _titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLable.backgroundColor = [UIColor clearColor];
    _titleLable.font = [UIFont systemFontOfSize:12];
    _titleLable.textColor = [UIColor colorWithRed:((0x4a99d3 & 0xff0000) >> 16) / 255.0f
                                            green:((0x4a99d3 & 0xff00) >> 8) / 255.0f
                                             blue:(0x4a99d3 & 0xff) / 255.0f
                                            alpha:1.0];
    
    _titleLable.text = [NSString stringWithFormat:@"%@：%@", _titlePrefixText, @"0000-00-00 00:00:00"];
    _titleLable.size = [_titleLable.text stringSizeWithFont:_titleLable.font];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    [_headContentView addSubview:_titleLable];

    _brandContentView = [[UIView alloc] initWithFrame:CGRectZero];
    _brandContentView.backgroundColor = [UIColor clearColor];
    [self addSubview:_brandContentView];

    if ([_delegate respondsToSelector:@selector(refreshHeaderViewLastUpdateTime:)])
        [self setLastUpdateTime:[_delegate refreshHeaderViewLastUpdateTime:self]];

    _refreshingAnimatedType = XUIRefreshingAnimatedTypeImagePlayCycle;
    CGSize s = CGSizeMake(24, 15);
    self.refreshingView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, s.width, s.height)];
    self.refreshingView.backgroundColor = [UIColor clearColor];
    ((UIImageView *) self.refreshingView).animationDuration = 1.0;
    ((UIImageView *) self.refreshingView).animationImages = @[[UIImage imageNamed:@"refresh_indicator_1.png"],[UIImage imageNamed:@"refresh_indicator_2.png"],[UIImage imageNamed:@"refresh_indicator_3.png"],[UIImage imageNamed:@"refresh_indicator_4.png"],[UIImage imageNamed:@"refresh_indicator_5.png"]];
}

-(void)setRefreshingAnimatedType:(XUIRefreshingAnimatedType)refreshingAnimatedType
{
    _refreshingAnimatedType = refreshingAnimatedType;
    
    self.refreshingView  = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.refreshingView.size = CGSizeMake(20, 20);
    self.refreshingView.hidden = YES;
    [(UIActivityIndicatorView *) self.refreshingView  stopAnimating];
}

-(void)setRefreshHeadViewHeight:(CGFloat)refreshHeadViewHeight
{
    _refreshHeadViewHeight = refreshHeadViewHeight;
    [self setNeedsLayout];
}

-(void)setRefreshHeadViewThreshold:(CGFloat)refreshHeadViewThreshold
{
    _refreshHeadViewThreshold = refreshHeadViewThreshold;
    [self setNeedsLayout];
}

- (void)setTitlePrefixText:(NSString *)text
{
    if ([_titlePrefixText isEqualToString:text])
        return;
    NSDictionary *dic = [NSDictionary dictionaryWithObject:text forKey:_titlePrefixText];
    _titleLable.text = [NSString replaceString:_titleLable.text replacekv:dic];
    _titlePrefixText = text;
}

- (void)setHiddenTitle:(BOOL)hidden
{
    if (_titleLable.hidden == hidden)
        return;

    _titleLable.hidden = hidden;
    [self setNeedsLayout];
}

- (void)setStateTextAlignment:(NSTextAlignment)textAlignment
{
    if (_stateLable.textAlignment == textAlignment)
        return;

    _stateLable.textAlignment = textAlignment;
    [self setNeedsLayout];
}

- (void)setStateTextColor:(UIColor *)color
{
    _stateLable.textColor = color;
}

- (void)setStateTextFont:(UIFont *)font
{
    if ([_stateLable.font isEqual:font])
        return;

    _stateLable.font = font;

    [self setNeedsLayout];
}

- (void)setTitleTextColor:(UIColor *)color
{
    _titleLable.textColor = color;
}

- (void)setTitleTextFont:(UIFont *)font
{
    if ([_titleLable.font isEqual:font])
        return;

    _titleLable.font = font;

    [self setNeedsLayout];
}

- (NSTextAlignment)stateTextAlignment
{
    return _stateLable.textAlignment;
}

- (void)setRefreshingView:(UIView *)view
{
    if (_refreshingView == view)
    {

    }
    else if (view != nil)
    {
        view.hidden = YES;
        view.size = CGSizeMake(view.width > 0 ? MIN(view.width, 40) : 40, view.height > 0 ? MIN(view.height, 40) : 40);
        view.center = _refreshingView.center;
        [_refreshingView.superview insertSubview:view belowSubview:_refreshingView];
        [_refreshingView removeFromSuperview];
        _refreshingView = view;
    }
    else
    {
        [_refreshingView removeFromSuperview];
    }
}

- (void)setRefreshIndicatorView:(UIView *)view
{
    if (_refreshIndicatorView == view)
    {

    }
    else if (view != nil)
    {
        view.size = CGSizeMake(view.width > 0 ? MIN(view.width, 40) : 40, view.height > 0 ? MIN(view.height, 40) : 40);
        view.center = _refreshIndicatorView.center;
        [_refreshIndicatorView.superview insertSubview:view belowSubview:_refreshIndicatorView];
        [_refreshIndicatorView removeFromSuperview];
        _refreshIndicatorView = view;
    }
    else
    {
        [_refreshIndicatorView removeFromSuperview];
    }
}

- (BOOL)isRefreshing
{
    return _refreshingState == XUIRefreshingStateRefreshing;
}

#pragma mark - view events

- (void)willMoveToSuperview:(UIView *)superview
{
    [super willMoveToSuperview:superview];

    if ([self.superview isKindOfClass:[UIScrollView class]])
    {
        [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    }
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];

    if ([self.superview isKindOfClass:[UIScrollView class]])
    {
        UIScrollView *scrollView = (UIScrollView *) self.superview;
        [scrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:NULL];

//        self.frame=CGRectMake(0, -scrollView.height, scrollView.width, scrollView.height);

//        _brandContentView.frame = CGRectMake(0, 0, self.width, self.height - HEAD_H);
//        
//        _headContentView.frame = CGRectMake(0, _brandContentView.bottom, self.width, HEAD_H);
//        
//        [self reLayout];

        if (_presentType == XUIRefreshHeaderViewPresentTypeBehindTableView && [scrollView isKindOfClass:[UITableView class]])
            [self addBehindTableView:(UITableView *) scrollView];
        else
            self.frame = CGRectMake(0, -scrollView.height, scrollView.width, scrollView.height);
    }
    else if (_tableView != nil)
    {
        [_tableView addObserver:self forKeyPath:@"contentOffset" options:0 context:NULL];
    }
}

//- (void)setFrame:(CGRect)frame
//{
//    [super setFrame:frame];
//
//    [self reLayout];
//}

- (void)reLayout
{
    _brandContentView.frame = CGRectMake(0, 0, self.width, self.height - _refreshHeadViewHeight);
    
    _headContentView.frame = CGRectMake(0, _brandContentView.bottom, self.width, _refreshHeadViewHeight);
    
    if (_titleLable.hidden == YES)
    {
     //   CGSize s = [[_statusTexts objectForKey:XUIRefreshHeaderViewStatusTextReady] stringSizeWithFont:_stateLable.font];
        CGSize s = [@"国国国国国国" stringSizeWithFont:_stateLable.font];
        CGFloat width = _refreshIndicatorView.width + s.width + 20;
        CGFloat left = (_headContentView.width - width) / 2;

        _refreshIndicatorView.left = left;
        _refreshIndicatorView.centerY = _headContentView.height / 2;

        _stateLable.left = _refreshIndicatorView.right + 20;
        _stateLable.centerY = _headContentView.height / 2;
    }
    else
    {
    //    CGSize s1 = [[_statusTexts objectForKey:XUIRefreshHeaderViewStatusTextReady] stringSizeWithFont:_stateLable.font];
        CGSize s1 = [@"国国国国国国" stringSizeWithFont:_stateLable.font];
        CGSize s2 = [_titleLable.text stringSizeWithFont:_titleLable.font];
        CGFloat width = _refreshIndicatorView.width + MAX(s1.width, s2.width)+ 20;
        CGFloat top = (_headContentView.height - s1.height - s2.height - 5) / 2;
        CGFloat left = (_headContentView.width - width) / 2;

        _refreshIndicatorView.left = left;
        _refreshIndicatorView.centerY = _headContentView.height / 2;

        _titleLable.left = _refreshIndicatorView.right + 20;
        switch (_stateLable.textAlignment)
        {
            case NSTextAlignmentLeft:
            {
                _stateLable.left = _titleLable.left;
                break;
            }
            case NSTextAlignmentCenter:
            default:
            {
                _stateLable.centerX = _titleLable.centerX;
                break;
            }
        }

        _stateLable.top = top;
        _titleLable.top = _stateLable.bottom + 5;
    }

    _refreshingView.center = _refreshIndicatorView.center;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    if(_refreshingState == XUIRefreshingStateRefreshing)
        _stateLable.text = [_statusTexts objectForKey:XUIRefreshHeaderViewStatusTextRefresh];
    else
        _stateLable.text = [_statusTexts objectForKey:XUIRefreshHeaderViewStatusTextPull];
    
    [self reLayout];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (_presentType != XUIRefreshHeaderViewPresentTypeBehindTableView)
    {
        if (object == self.superview && [keyPath isEqualToString:@"contentOffset"])
        {
            if ([self.superview isKindOfClass:[UIScrollView class]])
            {
                UIScrollView *scrollView = (UIScrollView *) self.superview;
                [self refreshHeaderViewDidScroll:scrollView];
            }
        } else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    else
    {
        if (object == _tableView && [keyPath isEqualToString:@"contentOffset"])
        {
            [self refreshHeaderViewDidScroll:_tableView];
        }
    }
}

#pragma mark - fake UIScrollViewDelegate

- (void)refreshHeaderViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat topInset = scrollView.contentInset.top;
    if (_addedTopInset && !_subtractingTopInset)
    {
        topInset -= _headContentView.height;
    }

    CGFloat offset = scrollView.contentOffset.y + topInset;

    switch (_presentType)
    {
        case XUIRefreshHeaderViewPresentTypeDefault:
        {
            break;
        }
        case XUIRefreshHeaderViewPresentTypePinToTop:
        {
            if (offset <= -_refreshHeadViewHeight)
            {
                self.top = -self.height - (ABS(offset)- _refreshHeadViewHeight);
            }
            else if (offset >= _refreshHeadViewHeight)
            {
                self.top = -self.height;
            }
            break;
        }
        case XUIRefreshHeaderViewPresentTypeBehindTableView:
        {
            break;
        }
    }

    if (_refreshIndicatorAnimatedType == XUIRefreshIndicatorAnimatedTypeFollowScroll)
    {
        if (offset < 0.0f && !self.isRefreshing)
            _refreshIndicatorView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, -2 * M_PI* offset * 10 / self.height);
    }

    switch (_refreshingState)
    {
        case XUIRefreshingStateNormal:
        {
            if (offset < -_refreshHeadViewThreshold && scrollView.isDragging)
            {
                _refreshingState = XUIRefreshingStateRefreshReady;
                _stateLable.text = [_statusTexts objectForKey:XUIRefreshHeaderViewStatusTextReady];

                if (_refreshIndicatorAnimatedType == XUIRefreshIndicatorAnimatedTypeDefault)
                {
                    [UIView animateWithDuration:0.3 animations:^
                    {
                        _refreshIndicatorView.transform = CGAffineTransformRotate(_refreshIndicatorView.transform, M_PI);
                    }];
                }
            }
            break;
        }
        case XUIRefreshingStateRefreshReady:
        {
            if (offset >= -_refreshHeadViewThreshold && scrollView.isDragging)
            {
                _refreshingState = XUIRefreshingStateNormal;
                _stateLable.text = [_statusTexts objectForKey:XUIRefreshHeaderViewStatusTextPull];

                if (_refreshIndicatorAnimatedType == XUIRefreshIndicatorAnimatedTypeDefault)
                {
                    [UIView animateWithDuration:0.3 animations:^
                    {
                        _refreshIndicatorView.transform = CGAffineTransformRotate(_refreshIndicatorView.transform, -M_PI);
                    }];
                }
            }
            if (offset < 0 && !scrollView.isDragging)
            {
                if (offset > -_refreshHeadViewThreshold)
                {
                    [self beginRefreshing];
                    [self addTopInsets];
                }
                else
                    ;//[self beginRefreshing];

                if (_endRefreshingImmediately == YES)
                {
                    [self endRefreshing];
                }
            }
            break;
        }
        case XUIRefreshingStateRefreshing:
        {
            if (!_addedTopInset)
            {
                [self addTopInsets];
            }

            break;
        }
        case XUIRefreshingStateRefreshed:
        {
            if (offset >= -5.f)
            {
                [self reset];
            }
            break;
        }
    }
}

#pragma mark -

- (void)beginRefreshing
{
    if (self.isRefreshing)
        return;
    
    [self showRefreshing];

    if ([_delegate respondsToSelector:@selector(refreshHeaderViewBeginRefreshing:)])
        [_delegate refreshHeaderViewBeginRefreshing:self];
}

- (void)showRefreshing
{
    if (self.isRefreshing)
    {
        return;
    }
    
    if (_refreshingState == XUIRefreshingStateNormal)
    {
        [self addTopInsets];
    }
    
    _refreshingState = XUIRefreshingStateRefreshing;
    _stateLable.text = [_statusTexts objectForKey:XUIRefreshHeaderViewStatusTextRefresh];
    
    _refreshIndicatorView.hidden = YES;
    _refreshingView.hidden = NO;
    
    [self spinRefreshingView:YES];
}

- (void)endRefreshing
{
    if (!self.isRefreshing)
    {
        return;
    }

    if (_addedTopInset)
    {
        [self subtractTopInsets];
    } else
    {
        _refreshingState = XUIRefreshingStateRefreshed;
    }

    _refreshIndicatorView.hidden = NO;
    _refreshingView.hidden = YES;

    _stateLable.text = [_statusTexts objectForKey:XUIRefreshHeaderViewStatusTextPull];
    
    [self spinRefreshingView:NO];

    if ([_delegate respondsToSelector:@selector(refreshHeaderViewLastUpdateTime:)])
        [self setLastUpdateTime:[_delegate refreshHeaderViewLastUpdateTime:self]];

    if ([_delegate respondsToSelector:@selector(refreshHeaderViewRefreshingEnded:)])
        [_delegate refreshHeaderViewRefreshingEnded:self];
}

- (void)reset
{
    _stateLable.text = [_statusTexts objectForKey:XUIRefreshHeaderViewStatusTextPull];
    _refreshIndicatorView.transform = CGAffineTransformIdentity;
    _refreshingState = XUIRefreshingStateNormal;
}

- (void)addTopInsets
{
    if (_addedTopInset == YES)
        return;

    _addedTopInset = YES;
    
    //在某些情况下，系统还没有调用layoutSubviews就执行addTopInsets，必须调用完layoutSubviews才能addTopInsets
    if(CGRectEqualToRect(_headContentView.frame, CGRectZero))
        [self layoutSubviews];

    UIScrollView *scrollView = (UIScrollView *) (_presentType != XUIRefreshHeaderViewPresentTypeBehindTableView ? self.superview : _tableView);
    UIEdgeInsets inset = scrollView.contentInset;
    inset.top += _headContentView.height;

    [UIView animateWithDuration:.3f animations:^
    {
        scrollView.contentInset = inset;
        scrollView.contentOffset = CGPointMake(0, -inset.top);
    }];
}

- (void)subtractTopInsets
{
    if (_subtractingTopInset == YES)
        return;

    _subtractingTopInset = YES;

    UIScrollView *scrollView = (UIScrollView *) (_presentType != XUIRefreshHeaderViewPresentTypeBehindTableView ? self.superview : _tableView);
    UIEdgeInsets inset = scrollView.contentInset;
    inset.top -= _headContentView.height;

    [UIView animateWithDuration:.3f animations:^
    {
        scrollView.contentInset = inset;
    }                completion:^(BOOL finished)
    {
        _subtractingTopInset = NO;
        _addedTopInset = NO;

        if (scrollView.contentOffset.y <= scrollView.contentInset.top && !scrollView.isDragging)
        {
            [self reset];
        } else
        {
            _refreshingState = XUIRefreshingStateRefreshed;
        }
    }];
}

- (void)spinRefreshingView:(BOOL)beginAnimate
{
    switch (_refreshingAnimatedType)
    {
        case XUIRefreshingAnimatedTypeDefault:
        {
            if ([_refreshingView isKindOfClass:[UIActivityIndicatorView class]])
            {
                if (beginAnimate)
                    [(UIActivityIndicatorView *) _refreshingView startAnimating];
                else
                    [(UIActivityIndicatorView *) _refreshingView stopAnimating];
                break;
            }
        }
        case XUIRefreshingAnimatedTypeImageRotate:
        {
            if (beginAnimate)
            {
                CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                rotate.fromValue = [NSNumber numberWithFloat:0];
                rotate.toValue = [NSNumber numberWithFloat:2 * M_PI];
                rotate.duration = 1;
                rotate.autoreverses = NO;
                rotate.repeatCount = CGFLOAT_MAX;
                [_refreshingView.layer addAnimation:rotate forKey:@"RefreshingViewRotate"];
            }
            else
            {
                [_refreshingView.layer removeAnimationForKey:@"RefreshingViewRotate"];
            }

            break;
        }
        case XUIRefreshingAnimatedTypeImagePlayCycle:
        {
            if ([_refreshingView isKindOfClass:[UIImageView class]])
            {
                if (beginAnimate)
                    [(UIImageView *) _refreshingView startAnimating];
                else
                    [(UIImageView *) _refreshingView stopAnimating];
            }
            break;
        }
    }
}

- (void)setLastUpdateTime:(id)date
{
    if ([date isKindOfClass:[NSString class]])
        _titleLable.text = [NSString stringWithFormat:@"%@：%@", _titlePrefixText, date];
    else if ([date isKindOfClass:[NSDate class]])
    {
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dateStr = [formatter stringFromDate:(NSDate *)date];
        
        _titleLable.text = [NSString stringWithFormat:@"%@：%@", _titlePrefixText,dateStr];
    }
}

- (void)addBehindTableView:(UITableView *)tableView
{
    if (tableView.backgroundView != nil)
    {
        _tableView = tableView;
        [_tableView.backgroundView addSubview:self];
        self.frame = CGRectMake(0, -tableView.height + _refreshHeadViewHeight, _tableView.width, _tableView.height);
    }
}

@end
