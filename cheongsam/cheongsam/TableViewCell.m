//
//  TableViewCell.m
//  cheongsam
//
//  Created by Admin on 16/9/26.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(QPHModel *)model{
    _model = model;
    [self.image sd_setImageWithURL:URLWITHSTRING(model.image)];
    self.title.text = model.title;
}
@end
