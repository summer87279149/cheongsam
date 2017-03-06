//
//  ShopTableViewCell.h
//  cheongsam
//
//  Created by Admin on 16/9/26.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShopTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shopImage;

@property (weak, nonatomic) IBOutlet UIImageView *QPimageView;

@property (nonatomic, strong) RACSubject *shopImageTapDelegate;

@property (nonatomic, strong) RACSubject *QPimageViewDelegate;

@end
