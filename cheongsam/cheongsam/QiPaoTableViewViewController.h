//
//  QiPaoTableViewViewController.h
//  cheongsam
//
//  Created by Admin on 16/9/26.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,BandAddress){
    BandAddressAll,
    BandAddressBeijing,
    BandAddressShanghai,
    BandAddressGuangzhou,
};
@interface QiPaoTableViewViewController : UIViewController

@property(nonatomic,assign)BandAddress addressType;

- (instancetype)initWithType:(BandAddress)addressType;
@end
