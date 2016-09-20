//
//  NSDate+Addition.h
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Addition)

/**
 *  判断是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  判断是否为今天
 */
- (BOOL)isToday;

/**
 *  判断是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回日期字符串
 *
 *  @param date       NSDate类型日期
 *  @param dateFromat zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。yyyy-MM-dd HH:mm:ss zzz
 *
 *  @return 返回日期字符串
 */
- (NSString *)stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFromat;





@end
