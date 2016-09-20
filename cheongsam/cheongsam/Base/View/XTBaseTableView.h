//
//  XTBaseTableView.h
//  XTCommon
//
//  Created by Admin on 16/9/19.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,XTBaseTableViewRowAnimation){
    Fade = UITableViewRowAnimationFade,
    Right = UITableViewRowAnimationRight,           // slide in from right (or out to right)
    Left = UITableViewRowAnimationLeft,
    Top = UITableViewRowAnimationTop,
    Bottom = UITableViewRowAnimationBottom,
    None = UITableViewRowAnimationNone,            // available in iOS 3.0
    Middle = UITableViewRowAnimationMiddle,          // available in iOS 3.2.  attempts to keep cell centered in the space it will/did occupy
    Automatic = 100  // available in iOS 5.0.  chooses an appropriate animation style for you
};

@class XTBaseTableViewCell;

@interface XTBaseTableView : UITableView

- (void)xt_updateWithUpdateBlock:(void (^)(XTBaseTableView *tableView))updateBlock;

- (UITableViewCell *)xt_cellAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - 只对已经存在的cell进行刷新，没有类似于系统的 如果行不存在，默认insert操作
/** 刷新单行、动画默认*/
- (void)xt_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath;

/** 刷新单行、动画默认*/
- (void)xt_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(XTBaseTableViewRowAnimation)animation;

/** 刷新多行、动画默认*/
- (void)xt_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/** 刷新多行、动画默认*/
- (void)xt_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(XTBaseTableViewRowAnimation)animation;

/** 刷新某个section、动画默认*/
- (void)xt_reloadSingleSection:(NSInteger)section;

/** 刷新某个section、动画自定义*/
- (void)xt_reloadSingleSection:(NSInteger)section animation:(XTBaseTableViewRowAnimation)animation;

/** 刷新多个section、动画默认*/
- (void)xt_reloadSections:(NSArray <NSNumber *>*)sections;

/** 刷新多个section、动画自定义*/
- (void)xt_reloadSections:(NSArray <NSNumber *>*)sections animation:(XTBaseTableViewRowAnimation)animation;

#pragma mark - 删除cell
/** 删除单行、动画默认*/
- (void)xt_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath;

/** 删除单行、动画自定义*/
- (void)xt_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(XTBaseTableViewRowAnimation)animation;

/** 删除多行、动画默认*/
- (void)xt_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/** 删除多行、动画自定义*/
- (void)xt_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(XTBaseTableViewRowAnimation)animation;

/** 删除某个section、动画默认*/
- (void)xt_deleteSingleSection:(NSInteger)section;

/** 删除某个section、动画自定义*/
- (void)xt_deleteSingleSection:(NSInteger)section animation:(XTBaseTableViewRowAnimation)animation;

/** 删除多个section*/
- (void)xt_deleteSections:(NSArray <NSNumber *>*)sections;

/** 删除多个section*/
- (void)xt_deleteSections:(NSArray <NSNumber *>*)sections animation:(XTBaseTableViewRowAnimation)animation;

#pragma mark - 增加cell
/** 增加单行 动画无*/
- (void)xt_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath;

/** 增加单行，动画自定义*/
- (void)xt_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(XTBaseTableViewRowAnimation)animation;

/** 增加单section，动画无*/
- (void)xt_insertSingleSection:(NSInteger)section;

/** 增加单section，动画自定义*/
- (void)xt_insertSingleSection:(NSInteger)section animation:(XTBaseTableViewRowAnimation)animation;

/** 增加多行，动画无*/
- (void)xt_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/** 增加多行，动画自定义*/
- (void)xt_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(XTBaseTableViewRowAnimation)animation;

/** 增加多section，动画无*/
- (void)xt_insertSections:(NSArray <NSNumber *>*)sections;

/** 增加多section，动画自定义*/
- (void)xt_insertSections:(NSArray <NSNumber *>*)sections animation:(XTBaseTableViewRowAnimation)animation;

@end
