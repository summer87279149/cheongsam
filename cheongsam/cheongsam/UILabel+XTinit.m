//
//  UILabel+XTinit.m
//  FootMassage
//
//  Created by Admin on 16/8/8.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import "UILabel+XTinit.h"

@implementation UILabel (XTinit)
+(id)sharedWithFont:(CGFloat )font andColor:(UIColor *)color andAnligment:(XTAliment ) XTAliment andBackgroundColor:(UIColor*)BGColor {
    UILabel *label = [[UILabel alloc]init];
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:font];
    switch (XTAliment) {
        case right:
            label.textAlignment = NSTextAlignmentRight;
            break;
        case center:
            label.textAlignment = NSTextAlignmentCenter;
            break;
        case left:
            label.textAlignment = NSTextAlignmentLeft;
            break;
        default:
            break;
    }
    if (BGColor) {
        label.backgroundColor = BGColor;
    }
 return label;
}
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}
@end
