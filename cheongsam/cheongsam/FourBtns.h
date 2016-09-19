//
//  FourBtns.h
//  cheongsam
//
//  Created by Admin on 16/9/14.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FourBtns : UIButton

@property(nonatomic,strong) UIImageView *image;

@property(nonatomic,strong) UILabel *Label;

- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage*)img andTitle:(NSString *)title;

@end
