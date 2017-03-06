//
//  ClassifyDetailCell.h
//  cheongsam
//
//  Created by Admin on 17/1/13.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassifyDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *recentSaled;
@property (weak, nonatomic) IBOutlet UILabel *popular;

@end
