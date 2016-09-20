//
//  XTBaseTableViewCell.h
//  XTCommon
//
//  Created by Admin on 16/9/20.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTBaseTableViewCell : UITableViewCell

@property (nonatomic, weak) UITableView *tableView;


/**
 *  创建一个非xib中加载的cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  创建一个从xib中加载的tableview cell
 */
+ (instancetype)nibCellWithTableView:(UITableView *)tableView;

@end
