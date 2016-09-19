//
//  UserTool.m
//  都市摇摇看
//
//  Created by admin on 15/12/4.
//  Copyright © 2015年 hackcc. All rights reserved.
//

#import "UserTool.h"
#import "AppDelegate.h"

@implementation UserTool

#pragma mark 正则匹配手机号
+ (BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

#pragma mark alertView显示
+ (void)alertViewDisplayTitle:(NSString *)title andMessage:(NSString *)message andDisplayValue:(double)value{
    
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:[[[UIApplication sharedApplication] delegate] window] cancelButtonTitle:nil otherButtonTitles:nil];
    
    [alert show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(value * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
    });
}

@end
