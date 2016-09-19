//
//  UIView+lineView.m
//  FootMassage
//
//  Created by Admin on 16/8/8.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import "UIView+lineView.h"

@implementation UIView (lineView)
+(id)lineWithColor:(UIColor *)color{
    UIView *view  =[[UIView alloc]init];
    view.backgroundColor = color;
    
    return view;
}
@end
