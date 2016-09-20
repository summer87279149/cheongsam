//
//  XTBaseTableViewController.m
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "XTBaseTableViewController.h"
#import "XTBaseTableViewCell.h"

#import <objc/runtime.h>
#import "MJExtension.h"
#import "UIView+Tap.h"
#import "UIView+Layer.h"
#import "MJRefresh.h"

const char XTBaseTableVcNavRightItemHandleKey;
const char XTBaseTableVcNavLeftItemHandleKey;
#import "XTBaseTableViewController.h"

@interface XTBaseTableViewController ()
@property (nonatomic, copy) XTTableVcCellSelectedHandle handle;
@property (nonatomic, weak) UIImageView *refreshImg;
@end

@implementation XTBaseTableViewController
@synthesize needCellSepLine = _needCellSepLine;
@synthesize sepLineColor = _sepLineColor;
@synthesize navItemTitle = _navItemTitle;
@synthesize navRightItem = _navRightItem;
@synthesize navLeftItem = _navLeftItem;
@synthesize hiddenStatusBar = _hiddenStatusBar;
@synthesize barStyle = _barStyle;
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

/**
 *  加载tableview
 */
- (XTBaseTableView *)tableView {
    if(!_tableView){
        XTBaseTableView *tab = [[XTBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:tab];
        _tableView = tab;
        tab.dataSource = self;
        tab.delegate = self;
        tab.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
        tab.separatorColor = kSeperatorColor;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //    [self xt_hiddenLoadMore];
}

#pragma mark - loading & alert
- (void)xt_showLoading {
    //    [FMHUD showLoading];
}

- (void)xt_hiddenLoading {
    //    [FMHUD hideHUD];
}

- (void)xt_showTitle:(NSString *)title after:(NSTimeInterval)after {
    //    [FDHUD showTitle:title];
    //    [FDHUD hideHUDAfterTimeout:after];
}

/** 添加空界面文字*/
- (void)xt_addEmptyPageWithText:(NSString *)text {
    //    [[NHEmptyPageManager sharedManager] setDelegateForScrollView:self.tableView emptyText:text];
}

/** 设置导航栏右边的item*/
- (void)xt_setUpNavRightItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *rightItemTitle))handle {
    [self xt_setUpNavItemTitle:itemTitle handle:handle leftFlag:NO];
}

/** 设置导航栏左边的item*/
- (void)xt_setUpNavLeftItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *leftItemTitle))handle {
    [self xt_setUpNavItemTitle:itemTitle handle:handle leftFlag:YES];
}

- (void)xt_navItemHandle:(UIBarButtonItem *)item {
    void (^handle)(NSString *) = objc_getAssociatedObject(self, &XTBaseTableVcNavRightItemHandleKey);
    if (handle) {
        handle(item.title);
    }
}

- (void)xt_setUpNavItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *itemTitle))handle leftFlag:(BOOL)leftFlag {
    if (itemTitle.length == 0 || !handle) {
        if (itemTitle == nil) {
            itemTitle = @"";
        } else if ([itemTitle isKindOfClass:[NSNull class]]) {
            itemTitle = @"";
        }
        if (leftFlag) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:nil action:nil];
        } else {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:nil action:nil];
        }
    } else {
        if (leftFlag) {
            objc_setAssociatedObject(self, &XTBaseTableVcNavLeftItemHandleKey, handle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:self action:@selector(xt_navItemHandle:)];
        } else {
            objc_setAssociatedObject(self, &XTBaseTableVcNavRightItemHandleKey, handle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:self action:@selector(xt_navItemHandle:)];
        }
    }
    
}

/** 监听通知*/
- (void)xt_observeNotiWithNotiName:(NSString *)notiName action:(SEL)action {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:action name:notiName object:nil];
}

/** 设置刷新类型*/
- (void)setRefreshType:(XTBaseTableVcRefreshType)refreshType {
    _refreshType = refreshType;
    switch (refreshType) {
        case XTBaseTableVcRefreshTypeNone: // 没有刷新
            break ;
        case XTBaseTableVcRefreshTypeOnlyCanRefresh: { // 只有下拉刷新
            [self xt_addRefresh];
        } break ;
        case XTBaseTableVcRefreshTypeOnlyCanLoadMore: { // 只有上拉加载
            [self xt_addLoadMore];
        } break ;
        case XTBaseTableVcRefreshTypeRefreshAndLoadMore: { // 下拉和上拉都有
            [self xt_addRefresh];
            [self xt_addLoadMore];
        } break ;
        default:
            break ;
    }
}

/** 导航栏标题*/
- (void)setNavItemTitle:(NSString *)navItemTitle {
    if ([navItemTitle isKindOfClass:[NSString class]] == NO) return ;
    if ([navItemTitle isEqualToString:_navItemTitle]) return ;
    _navItemTitle = navItemTitle.copy;
    self.navigationItem.title = navItemTitle;
}

- (NSString *)navItemTitle {
    return self.navigationItem.title;
}

/** statusBar是否隐藏*/
- (void)setHiddenStatusBar:(BOOL)hiddenStatusBar {
    _hiddenStatusBar = hiddenStatusBar;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)hiddenStatusBar {
    return _hiddenStatusBar;
}

- (void)setBarStyle:(UIStatusBarStyle)barStyle {
    if (_barStyle == barStyle) return ;
    _barStyle = barStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)prefersStatusBarHidden {
    return self.hiddenStatusBar;
}

- (void)setShowRefreshIcon:(BOOL)showRefreshIcon {
    _showRefreshIcon = showRefreshIcon;
    self.refreshImg.hidden = !showRefreshIcon;
}

- (UIImageView *)refreshImg {
    if (!_refreshImg) {
        UIImageView *refreshImg = [[UIImageView alloc] init];
        [self.view addSubview:refreshImg];
        _refreshImg = refreshImg;
        [self.view bringSubviewToFront:refreshImg];
        refreshImg.image = [UIImage imageNamed:@"refresh"];
        WeakSelf(weakSelf);
        [refreshImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.view).mas_offset(-15);
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.bottom.mas_equalTo(weakSelf.view).mas_offset(-20);
        }];
        refreshImg.layerCornerRadius = 22;
        refreshImg.backgroundColor = kWhiteColor;
        
        [refreshImg setTapActionWithBlock:^{
            [self startAnimation];
            [weakSelf xt_beginRefresh];
        }];
    }
    return _refreshImg;
}

- (void)startAnimation {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.refreshImg.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)endRefreshIconAnimation {
    [self.refreshImg.layer removeAnimationForKey:@"rotationAnimation"];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.barStyle;
}

/** 右边item*/
- (void)setNavRightItem:(UIBarButtonItem *)navRightItem {
    
    _navRightItem = navRightItem;
    self.navigationItem.rightBarButtonItem = navRightItem;
}

- (UIBarButtonItem *)navRightItem {
    return self.navigationItem.rightBarButtonItem;
}
/** 左边item*/
- (void)setNavLeftItem:(UIBarButtonItem *)navLeftItem {
    
    _navLeftItem = navLeftItem;
    self.navigationItem.leftBarButtonItem = navLeftItem;
}

- (UIBarButtonItem *)navLeftItem {
    return self.navigationItem.leftBarButtonItem;
}

/** 需要系统分割线*/
- (void)setNeedCellSepLine:(BOOL)needCellSepLine {
    _needCellSepLine = needCellSepLine;
    self.tableView.separatorStyle = needCellSepLine ? UITableViewCellSeparatorStyleSingleLine : UITableViewCellSeparatorStyleNone;
}

- (BOOL)needCellSepLine {
    return self.tableView.separatorStyle == UITableViewCellSeparatorStyleSingleLine;
}

- (void)xt_addRefresh {
    [NHUtils addPullRefreshForScrollView:self.tableView pullRefreshCallBack:^{
        [self xt_refresh];
    }];
}

- (void)xt_addLoadMore {
    [NHUtils addLoadMoreForScrollView:self.tableView loadMoreCallBack:^{
        [self xt_loadMore];
    }];
}

/** 表视图偏移*/
- (void)setTableEdgeInset:(UIEdgeInsets)tableEdgeInset {
    _tableEdgeInset = tableEdgeInset;
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [self.view layoutIfNeeded];
    [self.view setNeedsLayout];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    WeakSelf(weakSelf);
    //    // update
    //    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(weakSelf.view).mas_offset(weakSelf.tableEdgeInset);
    //    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
    [self.view sendSubviewToBack:self.tableView];
}
/** 分割线颜色*/
- (void)setSepLineColor:(UIColor *)sepLineColor {
    if (!self.needCellSepLine) return;
    _sepLineColor = sepLineColor;
    
    if (sepLineColor) {
        self.tableView.separatorColor = sepLineColor;
    }
}

- (UIColor *)sepLineColor {
    return _sepLineColor ? _sepLineColor : [UIColor whiteColor];
}

/** 刷新数据*/
- (void)xt_reloadData {
    [self.tableView reloadData];
}

/** 开始下拉*/
- (void)xt_beginRefresh {
    if (self.refreshType == XTBaseTableVcRefreshTypeOnlyCanRefresh || self.refreshType == XTBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [NHUtils beginPullRefreshForScrollView:self.tableView];
    }
}

/** 刷新*/
- (void)xt_refresh {
    if (self.refreshType == XTBaseTableVcRefreshTypeNone || self.refreshType == XTBaseTableVcRefreshTypeOnlyCanLoadMore) {
        return ;
    }
    self.isRefresh = YES; self.isLoadMore = NO;
}

/** 上拉加载*/
- (void)xt_loadMore {
    if (self.refreshType == XTBaseTableVcRefreshTypeNone || self.refreshType == XTBaseTableVcRefreshTypeOnlyCanRefresh) {
        return ;
    }
    if (self.dataArray.count == 0) {
        return ;
    }
    self.isRefresh = NO; self.isLoadMore = YES;
    
}

- (void)xt_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass {
    [self xt_commonConfigResponseWithResponse:response isRefresh:isRefresh modelClass:modelClass emptyText:nil];
}

- (void)xt_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass emptyText:(NSString *)emptyText {
    if ([response isKindOfClass:[NSArray class]] == NO) return ;
    if (self.isRefresh) { // 刷新
        
        // 停止刷新
        [self xt_endRefresh];
        
        // 设置模型数组
        [self.dataArray removeAllObjects];
        self.dataArray = [modelClass mj_objectArrayWithKeyValuesArray:response];
        
        // 设置空界面占位文字
        if (emptyText.length) {
            [self xt_addEmptyPageWithText:emptyText];
        }
        
        // 刷新界面
        [self xt_reloadData];
        
    } else { // 上拉加载
        
        // 停止上拉
        [self xt_endLoadMore];
        
        // 没有数据提示没有更多了
        if ([response count] == 0) {
            [self xt_noticeNoMoreData];
        } else {
            
            // 设置模型数组
            NSArray *newModels = [modelClass mj_objectArrayWithKeyValuesArray:response];
            if (newModels.count < 50) {
                [self xt_hiddenLoadMore];
            }
            [self.dataArray addObjectsFromArray:newModels];
            
            // 刷新界面
            [self xt_reloadData];
        }
    }
}

/** 停止刷新*/
- (void)xt_endRefresh {
    if (self.refreshType == XTBaseTableVcRefreshTypeOnlyCanRefresh || self.refreshType == XTBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [NHUtils endRefreshForScrollView:self.tableView];
    }
}

/** 停止上拉加载*/
- (void)xt_endLoadMore {
    if (self.refreshType == XTBaseTableVcRefreshTypeOnlyCanLoadMore || self.refreshType == XTBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [NHUtils endLoadMoreForScrollView:self.tableView];
    }
}

/** 隐藏刷新*/
- (void)xt_hiddenRrefresh {
    if (self.refreshType == XTBaseTableVcRefreshTypeOnlyCanRefresh || self.refreshType == XTBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [NHUtils hiddenHeaderForScrollView:self.tableView];
    }
}

/** 隐藏上拉加载*/
- (void)xt_hiddenLoadMore {
    if (self.refreshType == XTBaseTableVcRefreshTypeOnlyCanLoadMore || self.refreshType == XTBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [NHUtils hiddenFooterForScrollView:self.tableView];
    }
}

/** 提示没有更多信息*/
- (void)xt_noticeNoMoreData {
    if (self.refreshType == XTBaseTableVcRefreshTypeOnlyCanLoadMore || self.refreshType == XTBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [NHUtils noticeNoMoreDataForScrollView:self.tableView];
    }
}

/** 头部正在刷新*/
- (BOOL)isHeaderRefreshing {
    return [NHUtils headerIsRefreshForScrollView:self.tableView];
}

//* 尾部正在刷新
- (BOOL)isFooterRefreshing {
    return [NHUtils footerIsLoadingForScrollView:self.tableView];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
// 分组数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self respondsToSelector:@selector(xt_numberOfSections)]) {
        return self.xt_numberOfSections;
    }
    return 0;
}

// 指定组返回的cell数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(xt_numberOfRowsInSection:)]) {
        return [self xt_numberOfRowsInSection:section];
    }
    return 0;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if ([self respondsToSelector:@selector(xt_headerAtSection:)]) {
//        return [self xt_headerAtSection:section];
//    }
//    return nil;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    if ([self respondsToSelector:@selector(xt_footerAtSection:)]) {
//        return [self xt_footerAtSection:section];
//    }
//    return nil;
//}

// 每一行返回指定的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self respondsToSelector:@selector(xt_cellAtIndexPath:)]) {
        return [self xt_cellAtIndexPath:indexPath];
    }
    // 1. 创建cell
    XTBaseTableViewCell *cell = [XTBaseTableViewCell cellWithTableView:self.tableView];
    
    // 2. 返回cell
    return cell;
}

// 点击某一行 触发的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XTBaseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self respondsToSelector:@selector(xt_didSelectCellAtIndexPath:cell:)]) {
        [self xt_didSelectCellAtIndexPath:indexPath cell:cell];
    }
}

- (UIView *)refreshHeader {
    return self.tableView.mj_header;
}

// 设置分割线偏移间距并适配
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.needCellSepLine) return ;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    if ([self respondsToSelector:@selector(xt_sepEdgeInsetsAtIndexPath:)]) {
        edgeInsets = [self xt_sepEdgeInsetsAtIndexPath:indexPath];
    }
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) [tableView setSeparatorInset:edgeInsets];
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) [tableView setLayoutMargins:edgeInsets];
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) [cell setSeparatorInset:edgeInsets];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) [cell setLayoutMargins:edgeInsets];
}

// 每一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(xt_cellheightAtIndexPath:)]) {
        return [self xt_cellheightAtIndexPath:indexPath];
    }
    return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(xt_sectionHeaderHeightAtSection:)]) {
        return [self xt_sectionHeaderHeightAtSection:section];
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(xt_sectionFooterHeightAtSection:)]) {
        return [self xt_sectionFooterHeightAtSection:section];
    }
    return 0.01;
}

- (NSInteger)xt_numberOfSections { return 0; }

- (NSInteger)xt_numberOfRowsInSection:(NSInteger)section { return 0; }

- (UITableViewCell *)xt_cellAtIndexPath:(NSIndexPath *)indexPath { return [XTBaseTableViewCell cellWithTableView:self.tableView]; }

- (CGFloat)xt_cellheightAtIndexPath:(NSIndexPath *)indexPath { return 0; }

- (void)xt_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(XTBaseTableViewCell *)cell { }



- (CGFloat)xt_sectionHeaderHeightAtSection:(NSInteger)section { return 0.01; }

- (CGFloat)xt_sectionFooterHeightAtSection:(NSInteger)section { return 0.01; }

- (UIEdgeInsets)xt_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath { return UIEdgeInsetsMake(0, 15, 0, 0); }

- (void)dealloc { [[NSNotificationCenter defaultCenter] removeObserver:self]; }

@end
