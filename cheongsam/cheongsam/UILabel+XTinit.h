//
//  UILabel+XTinit.h
//  FootMassage
//
//  Created by Admin on 16/8/8.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    right,
    center,
    left,
    XTdefault,
} XTAliment;

@interface UILabel (XTinit)

+(id)sharedWithFont:(CGFloat )font andColor:(UIColor *)color andAnligment:(XTAliment) XTAliment andBackgroundColor:(UIColor*)BGColor;

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;
@end
