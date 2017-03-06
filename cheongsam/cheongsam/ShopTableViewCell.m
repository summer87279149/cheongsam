//
//  ShopTableViewCell.m
//  cheongsam
//
//  Created by Admin on 16/9/26.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import "ShopTableViewCell.h"

@implementation ShopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shopTap)];
    self.shopImage.userInteractionEnabled = YES;
    [self.shopImage addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(QPTap)];
    self.QPimageView.userInteractionEnabled = YES;
    [self.QPimageView addGestureRecognizer:tap2];




}
-(void)shopTap{
    [self.shopImageTapDelegate sendNext:self];
}


-(void)QPTap{
    [self.QPimageViewDelegate sendNext:self];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
