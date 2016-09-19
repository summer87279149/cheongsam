//
//  FourBtns.m
//  cheongsam
//
//  Created by Admin on 16/9/14.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import "FourBtns.h"

@implementation FourBtns

- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage*)img andTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [[UIImageView alloc]initWithImage:img];
        self.image.image = img;
        [self addSubview:self.image];
        
        
        self.Label = [UILabel sharedWithFont:14 andColor:[UIColor blackColor] andAnligment:center andBackgroundColor:nil];
        self.Label.text = title;
        [self addSubview:self.Label];
        
        
        [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.top.mas_equalTo(self.mas_top);
            make.width.mas_equalTo(self.mas_width).offset(-20);
            make.height.mas_equalTo(60);
        }];
        [self.Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.top.mas_equalTo(self.image.mas_bottom);
            make.width.mas_equalTo(self.mas_width);
            make.bottom.mas_equalTo(self.mas_bottom);

        }];
        
    }
    return self;
}










@end
