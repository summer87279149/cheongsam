//
//  TableViewCell.h
//  cheongsam
//
//  Created by Admin on 16/9/26.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QPHModel.h"
@interface TableViewCell : UITableViewCell

@property (nonatomic, strong) QPHModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
