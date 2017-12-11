//
//  RefreshHeaderView.h
//  etionUI
//
//  Created by wangjian on 11/11/13.
//  Copyright (c) 2013 GuangZhouXuanWu. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const XUIRefreshHeaderViewStatusTextPull;
extern NSString *const XUIRefreshHeaderViewStatusTextReady;
extern NSString *const XUIRefreshHeaderViewStatusTextRefresh;

/**
 *  下拉刷新的呈现方式
 */
typedef NS_ENUM(NSUInteger, XUIRefreshHeaderViewPresentType)
{
    /**
     *  默认方式，下拉刷新跟随移动
     */
    XUIRefreshHeaderViewPresentTypeDefault,
    /**
     *  下拉刷新在下拉范围内跟随移动，超出范围定在顶部
     */
    XUIRefreshHeaderViewPresentTypePinToTop,
    /**
     *  下拉刷新隐藏在tableview后，类似网易刷新，注意tableview.backgroundView不能为空
     */
    XUIRefreshHeaderViewPresentTypeBehindTableView
};

/**
 *  刷新中动画播放方式
 */
typedef NS_ENUM(NSUInteger,XUIRefreshingAnimatedType)
{
    /**
     *  默认方式
     */
    XUIRefreshingAnimatedTypeDefault,
    /**
     *  刷新动画旋转循环滚动
     */
    XUIRefreshingAnimatedTypeImageRotate,
    /**
     *  播放刷新动画
     */
    XUIRefreshingAnimatedTypeImagePlayCycle
};

/**
 *  刷新指示箭头变化方式
 */
typedef NS_ENUM(NSUInteger,XUIRefreshIndicatorAnimatedType)
{
    /**
     *  默认方式，下拉指示箭头指向上或下
     */
    XUIRefreshIndicatorAnimatedTypeDefault,
    /**
     *  下拉箭头跟随scrollview滚动而滚动
     */
    XUIRefreshIndicatorAnimatedTypeFollowScroll
};

@class XUIRefreshHeaderView;

@protocol XUIRefreshHeaderViewDelegate <NSObject>

@optional

/**
 *  返回最后更新时间
 *
 *  @return 最后更新时间，可以为NSString或NSDate
 */
-(id)refreshHeaderViewLastUpdateTime:(XUIRefreshHeaderView*)view;

/**
 *  开始刷新
 *
 */
-(void)refreshHeaderViewBeginRefreshing:(XUIRefreshHeaderView*)view;

/**
 *  结束刷新
 *
 */
-(void)refreshHeaderViewRefreshingEnded:(XUIRefreshHeaderView*)view;

@end

/**
 *  下拉刷新控件
 */
@interface XUIRefreshHeaderView : UIView<UIViewExtendDelegate>
{

}

/**
 *  标题前缀，如“最后更新时间”、“更新时间”，默认是“最后更新”
 */
@property(nonatomic,retain) NSString *titlePrefixText;

@property (nonatomic, readonly, getter=isRefreshing) BOOL refreshing;

/**
 *  隐藏标题，默认为NO
 */
@property(nonatomic,assign) BOOL hiddenTitle;

/**
 *  在下拉释放后立即关闭刷新状态
 */
@property(nonatomic,assign) BOOL endRefreshingImmediately;

/**
 *  用于摆放商标的视图，对XUIRefreshHeaderViewPresentTypeDefault有效
 */
@property(nonatomic,readonly) UIView *brandContentView;

@property(nonatomic,assign) XUIRefreshHeaderViewPresentType presentType;

@property(nonatomic,assign) XUIRefreshingAnimatedType refreshingAnimatedType;

@property(nonatomic,assign) XUIRefreshIndicatorAnimatedType refreshIndicatorAnimatedType;

/**
 *  刷新动画视图
 */
@property(nonatomic,retain) UIView *refreshingView;

/**
 *  刷新箭头视图，默认为[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refresh_head.png"]]
 */
@property(nonatomic,retain) UIView *refreshIndicatorView;

/**
 *  状态文字的水平排序，只有NSTextAlignmentLeft/NSTextAlignmentCenter
 */
@property(nonatomic,assign) NSTextAlignment stateTextAlignment;

@property(nonatomic,retain) UIFont *stateTextFont;

@property(nonatomic,retain) UIFont *titleTextFont;

@property(nonatomic,retain) UIColor *stateTextColor;

@property(nonatomic,retain) UIColor *titleTextColor;

/**
 *  状态文字
 */
@property(nonatomic,retain) NSDictionary *statusTexts;

/**
 *  控件高度
 */
@property(nonatomic,assign) CGFloat refreshHeadViewHeight;

/**
 *  控件下拉的最大值
 */
@property(nonatomic,assign) CGFloat refreshHeadViewThreshold;

- (id)init;

- (id)initWithDelegate:(id<XUIRefreshHeaderViewDelegate>)delegate;

/**
 *  手动展开刷新，且响应refreshHeaderViewBeginRefreshing:回调
 */
- (void)beginRefreshing;

/**
 *  手动展开刷新，但不相应refreshHeaderViewBeginRefreshing:回调
 */
- (void)showRefreshing;

/**
 *  手动关闭刷新
 */
- (void)endRefreshing;

/**
 *  设置标题时间
 *
 *  @param date 时间，可为NSString或NSDate
 */
- (void)setLastUpdateTime:(id)date;

- (void)refreshHeaderViewDidScroll:(UIScrollView *)scrollView;

@end
