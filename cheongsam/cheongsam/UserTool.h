//
//  UserTool.h
//  都市摇摇看
//
//  Created by admin on 15/12/4.
//  Copyright © 2015年 hackcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserTool : NSObject

// 匹配手机号
+ (BOOL) isValidateMobile:(NSString *)mobile;

// 显示提示框
+ (void)alertViewDisplayTitle:(NSString *)title andMessage:(NSString *)message andDisplayValue:(double)value;

@end
