//
//  WebViewController.h
//  cheongsam
//
//  Created by Admin on 17/1/12.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (nonatomic, copy) NSString *urlString;

- (instancetype)initWithUrlString:(NSString *)urlString;

@end
